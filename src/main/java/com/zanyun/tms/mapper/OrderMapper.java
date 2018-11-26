package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.OrderCount;
import com.zanyun.tms.domain.front.Order;
import com.zanyun.tms.view.background.OrderViewForList;
import com.zanyun.tms.view.front.OrderListView;
import com.zanyun.tms.view.front.OrderStatusCount;
import com.zanyun.tms.view.front.OrderUnpaidListView;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface OrderMapper {
    Order selectById(Integer id);

    Order select(Map<String, Object> map);

    default Order selectUnfinished(Integer driverId){
        Map<String,Object> query = new HashMap<>();
        query.put("driverId",driverId);
        query.put("unfinished",true);

        return this.select(query);
    }

    List<OrderUnpaidListView> selectUnpaidListView(Map<String, Object> map);

    List<OrderListView> selectListView(Map<String, Object> map);

    List<Order> selectList(Map<String, Object> map);

    List<OrderViewForList> selectViewList(Map<String, Object> map);

    int selectCount(Map<String, Object> map);

    OrderStatusCount selectStatusCount(Map<String, Object> map);

    OrderCount selectReportCount(Date date);

    int insert(Order order);

    int update(Order order);

    int updateUnpaidOrder();
}
