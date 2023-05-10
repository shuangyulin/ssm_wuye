package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Owner;

public interface OwnerMapper {
	/*添加业主信息*/
	public void addOwner(Owner owner) throws Exception;

	/*按照查询条件分页查询业主记录*/
	public ArrayList<Owner> queryOwner(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有业主记录*/
	public ArrayList<Owner> queryOwnerList(@Param("where") String where) throws Exception;

	/*按照查询条件的业主记录数*/
	public int queryOwnerCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条业主记录*/
	public Owner getOwner(int ownerId) throws Exception;

	/*更新业主记录*/
	public void updateOwner(Owner owner) throws Exception;

	/*删除业主记录*/
	public void deleteOwner(int ownerId) throws Exception;

}
