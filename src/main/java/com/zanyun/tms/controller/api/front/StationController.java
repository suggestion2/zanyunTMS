package com.zanyun.tms.controller.api.front;

import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.interceptor.front.OwnerLoginRequired;
import com.zanyun.tms.mapper.StationMapper;
import com.zanyun.tms.request.front.StationForm;
import com.zanyun.tms.view.front.StationListView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;

import static com.zanyun.tms.constants.UrlConstants.API_STATION;
import static com.zanyun.tms.constants.UrlConstants.LIST;

@RestController
@RequestMapping(API_STATION)
public class StationController {
    @Autowired
    private StationMapper stationMapper;

    @Autowired
    private SessionContext sessionContext;

    @RequestMapping(value = LIST,method = RequestMethod.POST)
    @OwnerLoginRequired
    public StationListView list(@RequestBody @Valid StationForm form){
        Map<String,Object> query = new HashMap<>();

        query.put("effect",true);

        if(StringUtils.hasText(form.getProvince())){
            query.put("province",form.getProvince());
        }
        if(StringUtils.hasText(form.getCity())){
            query.put("city",form.getCity());
        }
        if(StringUtils.hasText(form.getCounty())){
            query.put("county",form.getCounty());
        }
        StationListView view = new StationListView();
        view.setStationList(stationMapper.selectList(query));
        return view;
    }
}
