package com.zanyun.tms.controller.page.front;

import com.sug.core.platform.exception.ResourceNotFoundException;
import com.zanyun.tms.constants.OrderConstants;
import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.background.TransportationParams;
import com.zanyun.tms.domain.front.Driver;
import com.zanyun.tms.domain.front.Order;
import com.zanyun.tms.domain.front.Owner;
import com.zanyun.tms.interceptor.front.PageCheckRequired;
import com.zanyun.tms.interceptor.front.PageLoginType;
import com.zanyun.tms.mapper.*;
import com.zanyun.tms.view.front.OrderUnpaidListView;
import com.zanyun.tms.view.front.OrderUnpaidView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
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

import static com.zanyun.tms.constants.OrderConstants.VALIDATE_STATUS;
import static com.zanyun.tms.constants.UrlConstants.*;
import static com.zanyun.tms.constants.WeChatSitLoginType.DRIVER;
import static com.zanyun.tms.constants.WeChatSitLoginType.OWNER;

@Controller("OrderPageController")
@RequestMapping(value = PAGE_ORDER)
@PageCheckRequired
public class OrderController {
    private final Logger logger = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OwnerMapper ownerMapper;

    @Autowired
    private DriverMapper driverMapper;

    @Autowired
    private TransportationMapper transportationMapper;

    @RequestMapping(value = LIST,method = RequestMethod.GET)
    @PageLoginType(DRIVER)
    public String orderList(ModelMap model){
        Map<String, Object> map = new HashMap<>();
        map.put("startIndex",0);
        map.put("pageSize",20);
        map.put("status", VALIDATE_STATUS);

        List<OrderUnpaidListView> list = orderMapper.selectUnpaidListView(map);
        int count = orderMapper.selectCount(map);

        model.put("list",list);
        model.put("count",count);
        return getPath() + PAGE_DRIVER + "/orderList";
    }

    @RequestMapping(value = LIST + "/public",method = RequestMethod.GET)
    public String orderPublicList(ModelMap model){
        if(sessionContext.getWeChatBrowser()){
            throw new ResourceNotFoundException("not found");
        }
        Map<String, Object> map = new HashMap<>();
        map.put("startIndex",0);
        map.put("pageSize",20);
        map.put("status", VALIDATE_STATUS);

        List<OrderUnpaidListView> list = orderMapper.selectUnpaidListView(map);
        int count = orderMapper.selectCount(map);

        model.put("list",list);
        model.put("count",count);
        return PAGE_WEB + "/orderList";
    }

    @RequestMapping(value = TAKE + "/{id}", method = RequestMethod.GET)
    @PageLoginType(DRIVER)
    public String orderDetail(@PathVariable Integer id, ModelMap model){
        Order order = orderMapper.selectById(id);
        if(Objects.isNull(order)){
            throw new ResourceNotFoundException("order not found");
        }
        OrderUnpaidView view = new OrderUnpaidView();
        BeanUtils.copyProperties(order,view);

        model.put("order",view);
        return getPath() + PAGE_DRIVER + "/orderTake";
    }

    @RequestMapping(value = CREATE, method = RequestMethod.GET)
    @PageLoginType(OWNER)
    public String create(ModelMap model){
        List<TransportationParams> list = transportationMapper.selectParams();

        list.forEach(t->{
            if(t.getName().equals("type")){
                model.put("list",t.getValue());
            }
        });

        return getPath() + PAGE_OWNER + "/createOrder";
    }


    @RequestMapping(value = "/protocol/{id}", method = RequestMethod.GET)
    @PageLoginType(DRIVER)
    public String orderProtocol(@PathVariable Integer id, ModelMap model){
        Order order = orderMapper.selectById(id);
        if(Objects.isNull(order) || !order.getStatus().equals(OrderConstants.PAID_STATUS) || !order.getDriverId().equals(sessionContext.getDriverId())){
            throw new ResourceNotFoundException("order not found");
        }
        model.put("order",order);
        Owner owner = ownerMapper.selectById(order.getOwnerId());
        model.put("owner",owner);
        Driver driver = driverMapper.selectById(order.getDriverId());
        model.put("driver",driver);
        return getPath() + PAGE_DRIVER + "/orderAgree";
    }

    private String getPath(){
        return sessionContext.getWeChatBrowser() ? PAGE_WECHAT : PAGE_WEB;
    }

}
