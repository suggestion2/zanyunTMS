package com.zanyun.tms.controller.api.background;


import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.web.rest.exception.InvalidRequestException;
import com.sug.core.rest.view.SuccessView;
import com.zanyun.tms.context.background.SessionContext;
import com.zanyun.tms.domain.background.Transportation;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.TransportationMapper;
import com.zanyun.tms.request.background.TransportationCreateForm;
import com.zanyun.tms.request.background.TransportationListForm;
import com.zanyun.tms.request.background.TransportationUpdateForm;
import com.zanyun.tms.view.background.TransportationListView;
import com.zanyun.tms.view.background.TransportationParamsView;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import static com.zanyun.tms.constants.UrlConstants.*;

@RestController
@RequestMapping("/background/transportation")
public class TransportationController {
    @Autowired
    private TransportationMapper transportationMapper;

    @Autowired
    private SessionContext sessionContext;

    @RequestMapping(value = LIST,method = RequestMethod.POST)
    @LoginRequired
    public TransportationListView list(@Valid @RequestBody TransportationListForm form){
        TransportationListView view = new TransportationListView();
        view.setList(transportationMapper.selectList(form.getQueryMap()));
        view.setCount(transportationMapper.selectCount(form.getQueryMap()));

        return view;
    }

    @RequestMapping(value = ID,method = RequestMethod.GET)
    @LoginRequired
    public Transportation getById(@PathVariable Integer id){
        return transportationMapper.selectById(id);
    }

    @RequestMapping(value = CREATE,method = RequestMethod.POST)
    @LoginRequired
    public SuccessView create(@RequestBody @Valid TransportationCreateForm form){
        Map<String,Object> query = new HashMap<>();
        query.put("licenseNum",form.getLicenseNum());
        Transportation transportation = transportationMapper.select(query);
        if(Objects.nonNull(transportation)){
            throw new InvalidRequestException("车牌号已经存在");
        }

        query.remove("licenseNum");
        query.put("engineNum",form.getEngineNum());
        transportation = transportationMapper.select(query);
        if(Objects.nonNull(transportation)){
            throw new InvalidRequestException("发动机号已经存在");
        }

        transportation = new Transportation();
        BeanUtils.copyProperties(form,transportation);
        transportation.setUpdateBy(sessionContext.getUserId());

        transportationMapper.insert(transportation);

        return new SuccessView();
    }

    @RequestMapping(value = "/delete" + ID,method = RequestMethod.DELETE)
    @LoginRequired
    public SuccessView delete(@PathVariable Integer id){
        Transportation transportation = transportationMapper.selectById(id);
        if(Objects.isNull(transportation)){
            throw new ResourceNotFoundException("运力不存在");
        }

        transportationMapper.delete(id);

        return new SuccessView();
    }

    @RequestMapping(value = UPDATE,method = RequestMethod.PUT)
    @LoginRequired
    public SuccessView update(@RequestBody @Valid TransportationUpdateForm form){
        Map<String,Object> query = new HashMap<>();
        query.put("licenseNum",form.getLicenseNum());
        Transportation transportation = transportationMapper.select(query);
        if(Objects.nonNull(transportation) && !transportation.getId().equals(form.getId())){
            throw new InvalidRequestException("车牌号已经存在");
        }

        query.remove("licenseNum");
        query.put("engineNum",form.getEngineNum());
        transportation = transportationMapper.select(query);
        if(Objects.nonNull(transportation) && !transportation.getId().equals(form.getId())){
            throw new InvalidRequestException("发动机号已经存在");
        }

        transportation = transportationMapper.selectById(form.getId());
        BeanUtils.copyProperties(form,transportation);
        transportation.setUpdateBy(sessionContext.getUserId());

        transportationMapper.update(transportation);

        return new SuccessView();
    }

    @RequestMapping(value = "/params",method = RequestMethod.GET)
    @LoginRequired
    public TransportationParamsView params(){
        TransportationParamsView view = new TransportationParamsView();
        view.setList(transportationMapper.selectParams());

        return view;
    }
}
