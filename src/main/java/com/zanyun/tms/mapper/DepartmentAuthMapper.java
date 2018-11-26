package com.zanyun.tms.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DepartmentAuthMapper {

    int insert(@Param("departmentId") Integer departmentId, @Param("authIdList") List<Integer> list);

    int update(@Param("departmentId") Integer departmentId, @Param("authIdList") List<Integer> list);

    int delete(Integer departmentId);
}
