package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Manager;

public interface ManagerMapper {
	/*添加管理员信息*/
	public void addManager(Manager manager) throws Exception;

	/*按照查询条件分页查询管理员记录*/
	public ArrayList<Manager> queryManager(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有管理员记录*/
	public ArrayList<Manager> queryManagerList(@Param("where") String where) throws Exception;

	/*按照查询条件的管理员记录数*/
	public int queryManagerCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条管理员记录*/
	public Manager getManager(String manageUserName) throws Exception;

	/*更新管理员记录*/
	public void updateManager(Manager manager) throws Exception;

	/*删除管理员记录*/
	public void deleteManager(String manageUserName) throws Exception;

}
