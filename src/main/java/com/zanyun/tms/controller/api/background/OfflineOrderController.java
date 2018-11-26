package com.zanyun.tms.controller.api.background;


import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.rest.view.SuccessView;
import com.zanyun.tms.context.background.SessionContext;
import com.zanyun.tms.domain.background.OfflineOrder;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.OfflineOrderMapper;
import com.zanyun.tms.request.background.*;
import com.zanyun.tms.view.background.OfflineOrderListView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Objects;

import static com.zanyun.tms.constants.OrderConstants.*;
import static com.zanyun.tms.constants.UrlConstants.*;
import static com.zanyun.tms.constants.UrlConstants.CREATE;
import static com.zanyun.tms.constants.UrlConstants.DELETE;
import static com.zanyun.tms.constants.UrlConstants.DETAIL;
import static com.zanyun.tms.constants.UrlConstants.ID;
import static com.zanyun.tms.constants.UrlConstants.LIST;
import static com.zanyun.tms.constants.UrlConstants.UPDATE;

@RestController("OfflineOrderBackgroundController")
@RequestMapping("/background/offlineOrder")
public class OfflineOrderController {

    private static final Logger logger = LoggerFactory.getLogger(OfflineOrderController.class);

    @Autowired
    private OfflineOrderMapper offlineOrderMapper;

    @Autowired
    private SessionContext sessionContext;

    @RequestMapping(value = LIST,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public OfflineOrderListView list(@Valid @RequestBody OfflineOrderListForm form){
        OfflineOrderListView view = new OfflineOrderListView();
        view.setList(offlineOrderMapper.selectList(form.getQueryMap()));
        view.setCount(offlineOrderMapper.selectCount(form.getQueryMap()));

        return view;
    }

    @RequestMapping(value = DETAIL + ID,method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public OfflineOrder getById(@PathVariable Integer id){
        return offlineOrderMapper.selectById(id);
    }

    @RequestMapping(value = CREATE,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public SuccessView create(@Valid @RequestBody OfflineOrderCreateForm form){
        OfflineOrder offlineOrder = new OfflineOrder();
        BeanUtils.copyProperties(form,offlineOrder);
        offlineOrder.setUpdateBy(sessionContext.getUserId());

        offlineOrderMapper.insert(offlineOrder);

        return new SuccessView();
    }

    @RequestMapping(value = UPDATE,method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView update(@Valid @RequestBody OfflineOrderUpdateForm form){
        OfflineOrder offlineOrder = offlineOrderMapper.selectById(form.getId());
        if(Objects.isNull(offlineOrder)){
            throw new ResourceNotFoundException("no offlineOrder");
        }

        BeanUtils.copyProperties(form,offlineOrder);
        offlineOrder.setUpdateBy(sessionContext.getUserId());

        offlineOrderMapper.update(offlineOrder);
        return new SuccessView();
    }

    @RequestMapping(value = DELETE,method = RequestMethod.DELETE)
    @LoginRequired
    @AuthRequired
    public SuccessView delete(@PathVariable Integer id){
        offlineOrderMapper.deleteById(id);

        return new SuccessView();
    }
}
