package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.front.Address;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface AddressMapper {
    Address selectById(Integer id);

    Address select(Map<String, Object> map);

    List<Address> selectList(Map<String, Object> map);

    int selectCount(Map<String, Object> map);

    default Address selectPrimary(Integer ownerId){
        Map<String,Object> map = new HashMap<>();
        map.put("ownerId",ownerId);
        map.put("status",1);
        map.put("primary",1);
        return select(map);
    }
    default List<Address> selectByOwnerId(Integer ownerId){
        Map<String,Object> map = new HashMap<>();
        map.put("ownerId",ownerId);
        map.put("status",1);
        return selectList(map);
    }

    int insert(Address address);

    int update(Address address);

    int setPrimary(Address address);

    int deleteById(Integer id);
}
