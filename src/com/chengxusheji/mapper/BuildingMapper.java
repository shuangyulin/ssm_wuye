package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Building;

public interface BuildingMapper {
	/*添加楼栋信息*/
	public void addBuilding(Building building) throws Exception;

	/*按照查询条件分页查询楼栋记录*/
	public ArrayList<Building> queryBuilding(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有楼栋记录*/
	public ArrayList<Building> queryBuildingList(@Param("where") String where) throws Exception;

	/*按照查询条件的楼栋记录数*/
	public int queryBuildingCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条楼栋记录*/
	public Building getBuilding(int buildingId) throws Exception;

	/*更新楼栋记录*/
	public void updateBuilding(Building building) throws Exception;

	/*删除楼栋记录*/
	public void deleteBuilding(int buildingId) throws Exception;

}
