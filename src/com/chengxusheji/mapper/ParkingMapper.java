package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Parking;

public interface ParkingMapper {
	/*添加停车位信息*/
	public void addParking(Parking parking) throws Exception;

	/*按照查询条件分页查询停车位记录*/
	public ArrayList<Parking> queryParking(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有停车位记录*/
	public ArrayList<Parking> queryParkingList(@Param("where") String where) throws Exception;

	/*按照查询条件的停车位记录数*/
	public int queryParkingCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条停车位记录*/
	public Parking getParking(int parkingId) throws Exception;

	/*更新停车位记录*/
	public void updateParking(Parking parking) throws Exception;

	/*删除停车位记录*/
	public void deleteParking(int parkingId) throws Exception;

}
