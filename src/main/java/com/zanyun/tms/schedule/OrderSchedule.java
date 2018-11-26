package com.zanyun.tms.schedule;

import com.zanyun.tms.mapper.OrderMapper;
import com.zanyun.tms.mapper.PaymentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class OrderSchedule {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private PaymentMapper paymentMapper;

    @Scheduled(cron="0 */3 * * * *")
    //@Scheduled(cron="0 * * * * *")
    public void autoCancelOrderAndPayment(){
        orderMapper.updateUnpaidOrder();
        paymentMapper.updateUnpaidPayment();
    }
}
