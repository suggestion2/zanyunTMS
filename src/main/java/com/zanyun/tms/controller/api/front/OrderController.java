package com.zanyun.tms.controller.api.front;


import com.sug.core.platform.exception.ForbiddenException;
import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.web.pagination.PaginationForm;
import com.sug.core.platform.web.pagination.PaginationView;
import com.sug.core.platform.web.rest.exception.InvalidRequestException;
import com.sug.core.util.SequenceNumUtils;
import com.zanyun.tms.constants.DriverConstant;
import com.zanyun.tms.constants.OrderConstants;
import com.zanyun.tms.constants.PaymentConstants;
import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.front.*;
import com.zanyun.tms.interceptor.front.DriverLoginRequired;
import com.zanyun.tms.interceptor.front.OwnerLoginRequired;
import com.zanyun.tms.mapper.*;
import com.zanyun.tms.request.front.*;
import com.zanyun.tms.view.front.*;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.*;

import static com.zanyun.tms.constants.OrderConstants.LOCK_STATUS;
import static com.zanyun.tms.constants.OrderConstants.VALIDATE_STATUS;
import static com.zanyun.tms.constants.UrlConstants.*;

@RestController
@RequestMapping(API_ORDER)
public class OrderController {
    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OwnerMapper ownerMapper;

    @Autowired
    private DriverMapper driverMapper;

    @Autowired
    private PaymentMapper paymentMapper;

    @Autowired
    private StationMapper stationMapper;

    @Autowired
    private SessionContext sessionContext;

    @RequestMapping(value = CREATE, method = RequestMethod.POST)
    @OwnerLoginRequired
    public Order create(@Valid @RequestBody OrderCreateForm form) {
        if (form.getOwnerType().equals(OrderConstants.PERSON_TYPE)) {
            if (!StringUtils.hasText(form.getOwnerIdCardNum())) {
                throw new ResourceNotFoundException("owner id card number missing");
            }
        } else if (form.getOwnerType().equals(OrderConstants.COMPANY_TYPE)) {
            boolean missing =
                    !StringUtils.hasText(form.getCompanyName())
                            || !StringUtils.hasText(form.getCompanyLicenseCode())
                            || !StringUtils.hasText(form.getCompanyProvince())
                            || !StringUtils.hasText(form.getCompanyCity())
                            || !StringUtils.hasText(form.getCompanyCounty())
                            || !StringUtils.hasText(form.getCompanyAddr());

            if (missing) {
                throw new ResourceNotFoundException("company info missing");
            }
        } else {
            throw new InvalidRequestException("invalid owner type");
        }

        /*Station oriStation = stationMapper.selectById(form.getOriStationId());
        if(Objects.isNull(oriStation)){
            throw new ResourceNotFoundException("origin station not found");
        }

        Station arrStation = stationMapper.selectById(form.getArrStationId());
        if(Objects.isNull(arrStation)){
            throw new ResourceNotFoundException("arrived station not found");
        }*/

        Owner owner = ownerMapper.selectById(sessionContext.getOwnerId());

        Order order = new Order();
        BeanUtils.copyProperties(form, order);
        order.setOwnerFreight(Double.parseDouble(form.getOwnerFreight()));
        order.setNumber("ZL" + SequenceNumUtils.generateShortNum());
        order.setOwnerId(owner.getId());
        order.setOwnerPhone(owner.getPhone());
        if(Objects.isNull(form.getLoadTime())){
            order.setLoadTime(new Date(0));
        }
        if(Objects.isNull(form.getPieces())){
            order.setPieces(0);
        }
        if(Objects.isNull(form.getCube())){
            order.setCube(0);
        }
        if(Objects.isNull(form.getCargoValue())){
            order.setCargoValue(0.0d);
        }
        if(StringUtils.isEmpty(form.getDischargeCompany())){
            order.setDischargeCompany("未知");
        }

        orderMapper.insert(order);

        return order;
    }

    @RequestMapping(value = TAKE, method = RequestMethod.PUT)
    @DriverLoginRequired
    @Transactional
    public OrderTakeView take(@Valid @RequestBody OrderTakeForm form) {

        Driver driver = driverMapper.selectById(sessionContext.getDriverId());
        if (!driver.getStatus().equals(DriverConstant.DRIVER_COMPLETE)) {
            throw new InvalidRequestException("司机未审核通过");
        }

        Order existsOrder = orderMapper.selectUnfinished(sessionContext.getDriverId());
        if(Objects.nonNull(existsOrder) && !existsOrder.getId().equals(form.getId())){
            throw new InvalidRequestException("司机还有未支付或未完成的订单");
        }

        Order order = orderMapper.selectById(form.getId());
        if (Objects.isNull(order)) {
            throw new ResourceNotFoundException("订单不存在");
        }

        if (order.getStatus().equals(LOCK_STATUS) && order.getDriverId().equals(sessionContext.getDriverId())){
            Payment payment = paymentMapper.selectByOrderId(order.getId());

            OrderTakeView view = new OrderTakeView();
            view.setPaymentId(payment.getId());
            view.setOrderId(order.getId());

            return view;
        }

        if (order.getStatus() > VALIDATE_STATUS) {
            throw new InvalidRequestException("订单已被其他司机接单");
        } else if (!order.getStatus().equals(VALIDATE_STATUS)) {
            throw new InvalidRequestException("订单状态错误");
        }

        order.setDriverId(driver.getId());
        order.setDriverName(driver.getName());
        order.setDriverPhone(driver.getPhone());
        order.setStatus(LOCK_STATUS);

        Payment payment = new Payment();
        payment.setNumber("P" + SequenceNumUtils.generateNum());
        payment.setAmount(order.getInfoFee());
        payment.setType(PaymentConstants.PAY_TYPE);
        payment.setOrderId(order.getId());
        payment.setOrderNum(order.getNumber());
        payment.setUpdateBy(0);

        orderMapper.update(order);
        paymentMapper.insert(payment);

        OrderTakeView view = new OrderTakeView();
        view.setPaymentId(payment.getId());
        view.setOrderId(order.getId());

        return view;
    }

    @RequestMapping(value = LIST, method = RequestMethod.POST)
    @DriverLoginRequired
    public PaginationView<OrderUnpaidListView> createdList(@Valid @RequestBody OrderListForm form) {
        Map<String, Object> map = form.getQueryMap();
        map.put("status", VALIDATE_STATUS);

        Driver driver = driverMapper.selectById(sessionContext.getDriverId());
        map.put("province",driver.getProvince());
        map.put("city",driver.getCity());
        map.put("county",driver.getCounty());

        List<OrderUnpaidListView> list = orderMapper.selectUnpaidListView(map);
        int count = orderMapper.selectCount(map);

        PaginationView<OrderUnpaidListView> view = new PaginationView<>();
        view.setList(list);
        view.setCount(count);

        return view;
    }

    @RequestMapping(value = LIST + "/public", method = RequestMethod.POST)
    public PaginationView<OrderUnpaidListView> publicList(@Valid @RequestBody PaginationForm form) {
        if(sessionContext.getWeChatBrowser()){
            throw new ResourceNotFoundException("not found");
        }

        Map<String, Object> map = form.getQueryMap();
        map.put("status", VALIDATE_STATUS);

        List<OrderUnpaidListView> list = orderMapper.selectUnpaidListView(map);
        int count = orderMapper.selectCount(map);

        PaginationView<OrderUnpaidListView> view = new PaginationView<>();
        view.setList(list);
        view.setCount(count);

        return view;
    }

    @RequestMapping(value = LIST_DRIVER, method = RequestMethod.POST)
    @DriverLoginRequired
    public PaginationView<OrderListView> driverList(@Valid @RequestBody OrderListForm form) {
        Map<String, Object> map = form.getQueryMap();
        map.put("driverId", sessionContext.getDriverId());
        if(OrderConstants.CREATE_STATUS == form.getStatus()){
            map.put("created", form.getStatus());
            map.remove("status");
        }


        List<OrderListView> list = orderMapper.selectListView(map);
        int count = orderMapper.selectCount(map);

        PaginationView<OrderListView> view = new PaginationView<>();
        view.setList(list);
        view.setCount(count);

        return view;
    }

    @RequestMapping(value = LIST_OWNER, method = RequestMethod.POST)
    @OwnerLoginRequired
    public PaginationView<OrderListView> ownerList(@Valid @RequestBody OrderListForm form) {
        Map<String, Object> map = form.getQueryMap();
        map.put("ownerId", sessionContext.getOwnerId());
        if(OrderConstants.ALL_STATUS == form.getStatus()){
            map.remove("status");
        }
        else if(OrderConstants.CREATE_STATUS == form.getStatus()){
            map.put("created", form.getStatus());
            map.remove("status");
        }

        List<OrderListView> list = orderMapper.selectListView(map);
        int count = orderMapper.selectCount(map);

        PaginationView<OrderListView> view = new PaginationView<>();
        view.setList(list);
        view.setCount(count);

        return view;
    }

    @RequestMapping(value = ID, method = RequestMethod.GET)
    @DriverLoginRequired
    public OrderUnpaidView getById(@PathVariable Integer id) {
        Order order = orderMapper.selectById(id);

        if (Objects.isNull(order)) {
            throw new ResourceNotFoundException("order not found");
        }

        if (Objects.nonNull(order.getDriverId()) && !sessionContext.getDriverId().equals(order.getDriverId())) {
            throw new ForbiddenException("not auth");
        }

        OrderUnpaidView view = new OrderUnpaidView();
        BeanUtils.copyProperties(order,view);

        return view;
    }

    @RequestMapping(value = DRIVER_ID, method = RequestMethod.GET)
    @DriverLoginRequired
    public Order driverGet(@PathVariable Integer id) {
        Order order = orderMapper.selectById(id);

        if (Objects.isNull(order)) {
            throw new ResourceNotFoundException("order not found");
        }

        if (Objects.nonNull(order.getDriverId()) && !sessionContext.getDriverId().equals(order.getDriverId())) {
            throw new ForbiddenException("not auth");
        }

        order.setOwnerFreight(0d);

        return order;
    }

    @RequestMapping(value = OWNER_ID, method = RequestMethod.GET)
    @OwnerLoginRequired
    public Order ownerGet(@PathVariable Integer id) {
        Order order = orderMapper.selectById(id);

        if (Objects.isNull(order)) {
            throw new ResourceNotFoundException("order not found");
        }

        if (!sessionContext.getOwnerId().equals(order.getOwnerId())) {
            throw new ForbiddenException("not auth");
        }
        order.setDriverFreight(0d);
        return order;
    }

    @RequestMapping(value = DRIVER_COUNT, method = RequestMethod.GET)
    @DriverLoginRequired
    public OrderStatusCount driverCount() {
        Map<String, Object> map = new HashMap<>();
        map.put("driverId", sessionContext.getDriverId());
        map.put("cancel", OrderConstants.CANCEL_STATUS);
        map.put("accept", OrderConstants.ACCEPT_STATUS);
        map.put("transport", OrderConstants.TRANSPORT_STATUS);
        map.put("complete", OrderConstants.COMPLETE_STATUS);

        return orderMapper.selectStatusCount(map);
    }

    @RequestMapping(value = OWNER_COUNT, method = RequestMethod.GET)
    @OwnerLoginRequired
    public OrderStatusCount ownerCount() {
        Map<String, Object> map = new HashMap<>();
        map.put("ownerId", sessionContext.getOwnerId());
        map.put("cancel", OrderConstants.CANCEL_STATUS);
        map.put("accept", OrderConstants.ACCEPT_STATUS);
        map.put("transport", OrderConstants.TRANSPORT_STATUS);
        map.put("complete", OrderConstants.COMPLETE_STATUS);

        return orderMapper.selectStatusCount(map);
    }
}
