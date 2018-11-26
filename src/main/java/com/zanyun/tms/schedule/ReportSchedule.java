package com.zanyun.tms.schedule;

import com.zanyun.tms.domain.background.CustomerCount;
import com.zanyun.tms.domain.background.OrderCount;
import com.zanyun.tms.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class ReportSchedule {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private DriverMapper driverMapper;

    @Autowired
    private OwnerMapper ownerMapper;

    @Autowired
    private OrderCountMapper orderCountMapper;

    @Autowired
    private CustomerCountMapper customerCountMapper;

    @Scheduled(cron="0 59 23 * * *")
    //@Scheduled(cron="0 * * * * *")
    public void orderReportTask(){
        OrderCount count = orderMapper.selectReportCount(new Date());
        orderCountMapper.insert(count);
    }

    @Scheduled(cron="0 59 23 * * *")
    //@Scheduled(cron="0 * * * * *")
    public void customerReportTask(){
        Map<String,Object> query = new HashMap<>();
        query.put("date",new Date());
        Integer driverCount = driverMapper.selectCount(query);
        Integer ownerCount = ownerMapper.selectCount(query);

        CustomerCount customerCount = new CustomerCount();
        customerCount.setDriverCount(driverCount);
        customerCount.setOwnerCount(ownerCount);
        customerCountMapper.insert(customerCount);
    }
}
