package com.zanyun.tms.controller.page.front;

import com.sug.core.platform.exception.ForbiddenException;
import com.sug.core.platform.exception.ResourceNotFoundException;
import com.zanyun.tms.constants.OrderConstants;
import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.front.Order;
import com.zanyun.tms.domain.front.Owner;
import com.zanyun.tms.interceptor.front.PageCheckRequired;
import com.zanyun.tms.interceptor.front.PageLoginType;
import com.zanyun.tms.mapper.OrderMapper;
import com.zanyun.tms.mapper.OwnerMapper;
import com.zanyun.tms.view.front.OrderListView;
import com.zanyun.tms.view.front.OrderStatusCount;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import static com.zanyun.tms.constants.UrlConstants.*;
import static com.zanyun.tms.constants.WeChatSitLoginType.OWNER;

@Controller("OwnerPageController")
@RequestMapping(value = PAGE_OWNER)
@PageCheckRequired
public class OwnerController {
    private final Logger logger = LoggerFactory.getLogger(OwnerController.class);

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private OwnerMapper ownerMapper;

    @Autowired
    private OrderMapper orderMapper;

    @RequestMapping(value = REGISTER, method = RequestMethod.GET)
    public String register() {
        if(Objects.nonNull(sessionContext.getOwnerId())){
            return "redirect:/owner/center";
        }
        return getPath() + PAGE_OWNER + REGISTER;
    }

    @RequestMapping(value = LOGIN, method = RequestMethod.GET)
    public String login() {
        if(Objects.nonNull(sessionContext.getOwnerId())){
            return "redirect:/owner/center";
        }
        return getPath() + PAGE_OWNER + LOGIN;
    }

    @RequestMapping(value = PASSWORD_CHANGE, method = RequestMethod.GET)
    public String changePassword() {
        return getPath() + PAGE_OWNER + PASSWORD_CHANGE;
    }

    @RequestMapping(value = CENTER, method = RequestMethod.GET)
    @PageLoginType(OWNER)
    public String ownerCenter(ModelMap model){

        Owner owner = ownerMapper.selectById(sessionContext.getOwnerId());
        Map<String, Object> map = new HashMap<>();

        map.put("ownerId", sessionContext.getOwnerId());
        map.put("cancel", OrderConstants.CANCEL_STATUS);
        map.put("accept", OrderConstants.ACCEPT_STATUS);
        map.put("transport", OrderConstants.TRANSPORT_STATUS);
        map.put("complete", OrderConstants.COMPLETE_STATUS);

        OrderStatusCount count = orderMapper.selectStatusCount(map);

        model.put("owner",owner);
        model.put("count",count);
        model.put("active", "member");
        return getPath() + PAGE_OWNER + CENTER;
    }

    @RequestMapping(value = ORDER_LIST + "/{status}", method = RequestMethod.GET)
    @PageLoginType(OWNER)
    public String ownerList(@PathVariable Integer status, ModelMap model){

        Map<String, Object> map = new HashMap<>();
        map.put("startIndex",0);
        map.put("pageSize",20);
        map.put("ownerId", sessionContext.getOwnerId());
        if(OrderConstants.ALL_STATUS != status){
            map.put(OrderConstants.CREATE_STATUS == status ? "created" : "status", status);
        }

        List<OrderListView> list = orderMapper.selectListView(map);
        int count = orderMapper.selectCount(map);

        model.put("list",list);
        model.put("count",count);

        Owner owner = ownerMapper.selectById(sessionContext.getOwnerId());
        model.put("owner", owner);
        model.put("active", "order");
        return getPath() + PAGE_OWNER + HISTORY;
    }

    @RequestMapping(value = ORDER_DETAIL + "/{id}", method = RequestMethod.GET)
    @PageLoginType(OWNER)
    public String ownerDetail(@PathVariable Integer id, ModelMap model){
        Order order = orderMapper.selectById(id);
        if(Objects.isNull(order)){
            throw new ResourceNotFoundException("order not found");
        }
        if(!sessionContext.getOwnerId().equals(order.getOwnerId())){
            throw new ForbiddenException("no auth");
        }
        order.setDriverFreight(0d);
        order.setFinalFreight(0d);
        model.put("order",order);
        return getPath() + PAGE_OWNER + DETAIL;
    }

    @RequestMapping(value = CENTER + SETTING , method = RequestMethod.GET)
    public String webOwnerCenterSetting(ModelMap model) {
        Owner owner = ownerMapper.selectById(sessionContext.getOwnerId());
        model.put("owner", owner);
        model.put("active", "setting");
        return PAGE_WEB + PAGE_OWNER + SETTING;
    }

    private String getPath(){
        return sessionContext.getWeChatBrowser() ? PAGE_WECHAT : PAGE_WEB;
    }
}
