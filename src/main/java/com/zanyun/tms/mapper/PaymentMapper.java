package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.front.Payment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.zanyun.tms.constants.PaymentConstants.*;

public interface PaymentMapper {
    Payment selectById(Integer id);

    Payment select(Map<String, Object> map);

    List<Payment> selectList(Map<String, Object> map);

    int selectCount(Map<String, Object> map);

    default Payment selectByNum(String number){
        Map<String,Object> map = new HashMap<>();
        map.put("number",number);

        return this.select(map);
    }

    default Payment selectByOrderId(Integer orderId){
        Map<String,Object> map = new HashMap<>();
        map.put("orderId",orderId);
        map.put("type",PAY_TYPE);
        map.put("status",UNPAID_STATUS);

        return this.select(map);
    }

    int insert(Payment payment);

    int update(Payment payment);

    int updateUnpaidPayment();
}
