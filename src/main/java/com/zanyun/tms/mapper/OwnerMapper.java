package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.front.Owner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface OwnerMapper {
    Owner selectById(Integer id);

    Owner select(Map<String, Object> map);

    List<Owner> selectList(Map<String, Object> map);

    int selectCount(Map<String, Object> map);

    default Owner selectByPhone(String phone){
        Map<String,Object> map = new HashMap<>();
        map.put("phone",phone);
        return select(map);
    }
    default Owner selectByOpenId(String openId){
        Map<String,Object> map = new HashMap<>();
        map.put("wechatPubOpenId",openId);
        return select(map);
    }

    int insert(Owner owner);

    int update(Owner owner);
}
