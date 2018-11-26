package com.zanyun.tms.controller.api.background;


import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.web.rest.exception.InvalidRequestException;
import com.sug.core.rest.view.SuccessView;
import com.zanyun.tms.constants.OrderConstants;
import com.zanyun.tms.context.background.SessionContext;
import com.zanyun.tms.domain.front.Order;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.DepartmentMapper;
import com.zanyun.tms.mapper.OrderMapper;
import com.zanyun.tms.request.background.OrderCancelForm;
import com.zanyun.tms.request.background.OrderListForm;
import com.zanyun.tms.request.background.OrderStatusForm;
import com.zanyun.tms.request.background.OrderValidateForm;
import com.zanyun.tms.service.WeChatService;
import com.zanyun.tms.view.background.DepartmentListView;
import com.zanyun.tms.view.background.OrderListView;
import com.zanyun.tms.view.background.OrderView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import static com.zanyun.tms.constants.OrderConstants.*;
import static com.zanyun.tms.constants.OrderConstants.ACCEPT_STATUS;
import static com.zanyun.tms.constants.OrderConstants.CANCEL_LIST_TYPE;
import static com.zanyun.tms.constants.OrderConstants.CANCEL_STATUS;
import static com.zanyun.tms.constants.OrderConstants.COMPLETE_LIST_TYPE;
import static com.zanyun.tms.constants.OrderConstants.COMPLETE_STATUS;
import static com.zanyun.tms.constants.OrderConstants.CREATE_STATUS;
import static com.zanyun.tms.constants.OrderConstants.DONE_LIST_TYPE;
import static com.zanyun.tms.constants.OrderConstants.LIST_TYPE;
import static com.zanyun.tms.constants.OrderConstants.TRANSPORT_LIST_TYPE;
import static com.zanyun.tms.constants.OrderConstants.TRANSPORT_STATUS;
import static com.zanyun.tms.constants.OrderConstants.UNPAID_LIST_TYPE;
import static com.zanyun.tms.constants.OrderConstants.VALIDATE_LIST_TYPE;
import static com.zanyun.tms.constants.OrderConstants.VALIDATE_STATUS;
import static com.zanyun.tms.constants.UrlConstants.*;
import static com.zanyun.tms.constants.UrlConstants.DETAIL;
import static com.zanyun.tms.constants.UrlConstants.ID;
import static com.zanyun.tms.constants.UrlConstants.LIST;
import static com.zanyun.tms.constants.background.MsgTemplates.*;

@RestController("OrderBackgroundController")
@RequestMapping("/background/order")
public class OrderController {

    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private WeChatService weChatService;

    @RequestMapping(value = LIST + LIST_TYPE,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public OrderListView list(@Valid @RequestBody OrderListForm form, @PathVariable String type){
        OrderListView view = new OrderListView();
        Map<String,Object> query = form.getQueryMap();

        switch (type){
            case VALIDATE_LIST_TYPE:
                query.put("status",CREATE_STATUS);
                break;
            case UNPAID_LIST_TYPE:
                query.put("status",VALIDATE_STATUS);
                break;
            case TRANSPORT_LIST_TYPE:
                query.put("status",ACCEPT_STATUS);
                query.put("transDepartmentId",sessionContext.isAdmin() ? null : sessionContext.getDepartmentId());
                break;
            case COMPLETE_LIST_TYPE:
                query.put("status",TRANSPORT_STATUS);
                query.put("comDepartmentId",sessionContext.isAdmin() ? null : sessionContext.getDepartmentId());
                break;
            case DONE_LIST_TYPE:
                query.put("status",COMPLETE_STATUS);
                break;
            case CANCEL_LIST_TYPE:
                query.put("status",CANCEL_STATUS);
                break;
            default:
                throw new InvalidRequestException("unknown type");
        }

        view.setList(orderMapper.selectViewList(query));
        view.setCount(orderMapper.selectCount(query));

        return view;
    }

    @RequestMapping(value = DETAIL + ID,method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public OrderView getById(@PathVariable Integer id){
        Order order = orderMapper.selectById(id);
        OrderView view = new OrderView();
        BeanUtils.copyProperties(order,view);
        return view;
    }

    @RequestMapping(value = "/validate",method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView validate(@Valid @RequestBody OrderValidateForm form){
        Order order = orderMapper.selectById(form.getId());

        if(Objects.isNull(order)){
            throw new ResourceNotFoundException("订单不存在");
        }

        if(!order.getStatus().equals(CREATE_STATUS)){
            throw new InvalidRequestException("订单状态错误");
        }

        if(Objects.isNull(form.getDriverFreight())){
            throw new ResourceNotFoundException("请填写司机运费");
        }

        if(Objects.isNull(form.getTransDepartmentId())){
            throw new ResourceNotFoundException("请选择下一个处理部门");
        }

        BeanUtils.copyProperties(form,order);
        order.setStatus(VALIDATE_STATUS);
        order.setTransDepartmentId(form.getTransDepartmentId());
        order.setUpdateBy(sessionContext.getUserId());

        orderMapper.update(order);

        return new SuccessView();
    }

    @RequestMapping(value = "/cancel",method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView cancel(@Valid @RequestBody OrderCancelForm form){
        Order order = orderMapper.selectById(form.getId());

        if(Objects.isNull(order)){
            throw new ResourceNotFoundException("订单不存在");
        }

        if(order.getStatus() == OrderConstants.CANCEL_STATUS ||
                order.getStatus() == OrderConstants.COMPLETE_STATUS){
            throw new InvalidRequestException("无效的订单");
        }

        if(!StringUtils.hasText(form.getValidateRemarks())){
            throw new ResourceNotFoundException("没有备注");
        }

        order.setValidateRemarks(form.getValidateRemarks());
        order.setStatus(CANCEL_STATUS);
        order.setUpdateBy(sessionContext.getUserId());

        orderMapper.update(order);

        try {
            weChatService.sendOrderCancelMsg(order);
        } catch (Exception e) {
            logger.error("weChat order transport msg fail:" + e.getMessage());
        }

        return new SuccessView();
    }

    @RequestMapping(value = "/transport",method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView transport(@Valid @RequestBody OrderStatusForm form){
        Order order = orderMapper.selectById(form.getId());

        if(Objects.isNull(order)){
            throw new ResourceNotFoundException("订单不存在");
        }

        if(order.getStatus() != OrderConstants.ACCEPT_STATUS){
            throw new InvalidRequestException("无效的订单");
        }

        if(Objects.isNull(form.getComDepartmentId())){
            throw new InvalidRequestException("没有卸货部门");
        }

        if(Objects.isNull(form.getComDepartmentId())){
            throw new ResourceNotFoundException("请选择下一个处理部门");
        }

        order.setStatus(TRANSPORT_STATUS);
        order.setUpdateBy(sessionContext.getUserId());
        order.setComDepartmentId(form.getComDepartmentId());
        order.setTransportTime(new Date());
        orderMapper.update(order);

        try {
            weChatService.sendOrderSendMsg(order);
        } catch (Exception e) {
            logger.error("weChat order transport msg fail:" + e.getMessage());
        }

        return new SuccessView();
    }

    @RequestMapping(value = "/complete",method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView complete(@Valid @RequestBody OrderStatusForm form){
        Order order = orderMapper.selectById(form.getId());

        if(Objects.isNull(order)){
            throw new ResourceNotFoundException("订单不存在");
        }

        if(order.getStatus() != OrderConstants.TRANSPORT_STATUS){
            throw new InvalidRequestException("无效的订单");
        }

        order.setStatus(COMPLETE_STATUS);
        order.setCompleteTime(new Date());
        order.setUpdateBy(sessionContext.getUserId());

        orderMapper.update(order);

        try {
            weChatService.sendOrderCompleteMsg(order);
        } catch (Exception e) {
            logger.error("weChat order transport msg fail:" + e.getMessage());
        }

        return new SuccessView();
    }

    @RequestMapping(value = "/department/transport",method = RequestMethod.GET)
    @LoginRequired
    public DepartmentListView transportList(){
        DepartmentListView view = new DepartmentListView();
        Map<String,Object> query = new HashMap<>();
        query.put("name","transportOrder");
        view.setList(departmentMapper.selectListByAuth(query));
        return view;
    }

    @RequestMapping(value = "/department/complete",method = RequestMethod.GET)
    @LoginRequired
    public DepartmentListView completeList(){
        DepartmentListView view = new DepartmentListView();
        Map<String,Object> query = new HashMap<>();
        query.put("name","completeOrder");
        view.setList(departmentMapper.selectListByAuth(query));
        return view;
    }
}
