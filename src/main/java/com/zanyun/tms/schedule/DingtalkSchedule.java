package com.zanyun.tms.schedule;

import com.sug.core.platform.dingtalk.service.DingtalkCommonService;
import com.zanyun.tms.constants.DriverConstant;
import com.zanyun.tms.constants.OrderConstants;
import com.zanyun.tms.domain.background.Department;
import com.zanyun.tms.mapper.DepartmentMapper;
import com.zanyun.tms.mapper.DriverMapper;
import com.zanyun.tms.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.zanyun.tms.constants.background.MsgTemplates.*;

@Component
public class DingtalkSchedule {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private DriverMapper driverMapper;

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private DingtalkCommonService dingtalkCommonService;

    @Scheduled(cron = "0 */5 9-17 * * *")
//    @Scheduled(cron="0 */1 * * * *")
    public void orderValidateMsg() {
        Map<String, Object> orderQuery = new HashMap<>();
        orderQuery.put("status", OrderConstants.CREATE_STATUS);
        int unValidateCount = orderMapper.selectCount(orderQuery);
        if (unValidateCount > 0) {
            Map<String, Object> query = new HashMap<>();
            query.put("name", "validateOrder");
            List<Department> list = departmentMapper.selectListByAuth(query);
            list.forEach(d -> {
                if (StringUtils.hasText(d.getDingChatId())) {
                    dingtalkCommonService.sendMsg(d.getDingChatId(), String.format(ORDER_VALIDATE,unValidateCount));
                }
            });
        }
    }

    @Scheduled(cron = "0 */5 9-17 * * *")
//    @Scheduled(cron="0 */1 * * * *")
    public void driverValidateMsg() {
        Map<String, Object> driverQuery = new HashMap<>();
        driverQuery.put("status", DriverConstant.DRIVER_VALIDATE);
        int unValidateCount = driverMapper.selectCount(driverQuery);
        if (unValidateCount > 0) {
            Map<String, Object> query = new HashMap<>();
            query.put("name", "validateDriver");
            List<Department> list = departmentMapper.selectListByAuth(query);
            list.forEach(d -> {
                if (StringUtils.hasText(d.getDingChatId())) {
                    dingtalkCommonService.sendMsg(d.getDingChatId(), String.format(DRIVER_VALIDATE,unValidateCount));
                }
            });
        }

    }


    @Scheduled(cron = "0 */5 9-17 * * *")
//    @Scheduled(cron="0 */1 * * * *")
    public void orderTransportMsg() {
        Map<String, Object> query = new HashMap<>();
        query.put("name", "transportOrder");
        List<Department> list = departmentMapper.selectListByAuth(query);
        list.forEach(d -> {
            if (StringUtils.hasText(d.getDingChatId())) {
                Map<String,Object> orderQuery = new HashMap<>();
                orderQuery.put("status", OrderConstants.PAID_STATUS);
                orderQuery.put("transDepartmentId",d.getId());
                int count = orderMapper.selectCount(orderQuery);
                if(count > 0){
                    dingtalkCommonService.sendMsg(d.getDingChatId(), String.format(ORDER_TRANSPORT,count));
                }
            }
        });
    }

    @Scheduled(cron = "0 */5 9-17 * * *")
//    @Scheduled(cron="0 */1 * * * *")
    public void orderCompleteMsg() {
        Map<String, Object> query = new HashMap<>();
        query.put("name", "completeOrder");
        List<Department> list = departmentMapper.selectListByAuth(query);
        list.forEach(d -> {
            if (StringUtils.hasText(d.getDingChatId())) {
                Map<String,Object> orderQuery = new HashMap<>();
                orderQuery.put("status", OrderConstants.TRANSPORT_STATUS);
                orderQuery.put("comDepartmentId",d.getId());
                int count = orderMapper.selectCount(orderQuery);
                if(count > 0){
                    dingtalkCommonService.sendMsg(d.getDingChatId(), String.format(ORDER_COMPLETE,count));
                }
            }
        });
    }
}
