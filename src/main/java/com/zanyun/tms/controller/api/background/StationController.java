package com.zanyun.tms.controller.api.background;

import com.sug.core.platform.web.pagination.PaginationView;
import com.sug.core.platform.web.rest.exception.InvalidRequestException;
import com.sug.core.rest.view.SuccessView;
import com.zanyun.tms.constants.StationConstants;
import com.zanyun.tms.context.background.SessionContext;
import com.zanyun.tms.domain.front.Station;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.DepartmentMapper;
import com.zanyun.tms.mapper.StationMapper;
import com.zanyun.tms.request.background.ListSearchForm;
import com.zanyun.tms.request.background.StationCreateForm;
import com.zanyun.tms.request.background.StationStatusForm;
import com.zanyun.tms.request.background.StationUpdateForm;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Objects;

import static com.zanyun.tms.constants.UrlConstants.*;

@RestController("StationBackgroundController")
@RequestMapping("/background/station")
public class StationController {
    @Autowired
    private StationMapper stationMapper;

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private SessionContext sessionContext;

    @RequestMapping(value = LIST,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public PaginationView<Station> list(@RequestBody @Valid ListSearchForm form){
        PaginationView<Station> view = new PaginationView<>();
        view.setList(stationMapper.selectList(form.getQueryMap()));
        view.setCount(stationMapper.selectCount(form.getQueryMap()));

        return view;
    }

    @RequestMapping(value = DETAIL + ID,method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public Station getById(@PathVariable Integer id){
        return stationMapper.selectById(id);
    }

    @RequestMapping(value = CREATE,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public SuccessView create(@RequestBody @Valid StationCreateForm form){
        Station station = stationMapper.selectByName(form.getName());
        if(Objects.nonNull(station)){
            throw new InvalidRequestException("场站名已经存在");
        }

        station = new Station();
        BeanUtils.copyProperties(form,station);
        station.setCreateBy(sessionContext.getUserId());

        stationMapper.insert(station);

        return new SuccessView();
    }

    @RequestMapping(value = UPDATE,method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView update(@RequestBody @Valid StationUpdateForm form){
        Station station = stationMapper.selectByName(form.getName());
        if(Objects.nonNull(station) && !station.getId().equals(form.getId())){
            throw new InvalidRequestException("场站名已经存在");
        }

        station = stationMapper.selectById(form.getId());
        BeanUtils.copyProperties(form,station);

        stationMapper.update(station);

        return new SuccessView();
    }

    @RequestMapping(value = ENABLED,method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView enabled(@RequestBody @Valid StationStatusForm form){
        Station station = stationMapper.selectById(form.getId());
        if(Objects.isNull(station) || StationConstants.DISABLED != station.getStatus()){
            throw new InvalidRequestException("无效的场站");
        }

        station.setStatus(StationConstants.ENABLED);

        stationMapper.update(station);

        return new SuccessView();
    }

    @RequestMapping(value = DISABLED,method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView disabled(@RequestBody @Valid StationStatusForm form){
        Station station = stationMapper.selectById(form.getId());
        if(Objects.isNull(station) || StationConstants.ENABLED != station.getStatus()){
            throw new InvalidRequestException("无效的场站");
        }

        station.setStatus(StationConstants.DISABLED);

        stationMapper.update(station);

        return new SuccessView();
    }
}
