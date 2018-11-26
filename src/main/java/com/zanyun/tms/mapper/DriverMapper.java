package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.front.Driver;
import com.zanyun.tms.view.background.DriverViewForList;
import com.zanyun.tms.view.front.TruckView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface DriverMapper {
    Driver selectById(Integer id);

    Driver select(Map<String, Object> map);

    List<Driver> selectList(Map<String, Object> map);

    List<DriverViewForList> selectViewList(Map<String, Object> map);

    int selectCount(Map<String, Object> map);

    default Driver selectByPhone(String phone){
        Map<String,Object> map = new HashMap<>();
        map.put("phone",phone);
        return select(map);
    }

    default Driver selectByOpenId(String openId){
        Map<String,Object> map = new HashMap<>();
        map.put("wechatPubOpenId",openId);
        return select(map);
    }

    int insert(Driver driver);

    int update(Driver driver);

    List<TruckView> selectTruckViewList(Map<String, Object> map);

    TruckView selectTruckViewById(Integer id);
}
