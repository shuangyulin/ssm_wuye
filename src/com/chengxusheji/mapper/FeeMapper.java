package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Fee;

public interface FeeMapper {
	/*添加收费信息*/
	public void addFee(Fee fee) throws Exception;

	/*按照查询条件分页查询收费记录*/
	public ArrayList<Fee> queryFee(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有收费记录*/
	public ArrayList<Fee> queryFeeList(@Param("where") String where) throws Exception;

	/*按照查询条件的收费记录数*/
	public int queryFeeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条收费记录*/
	public Fee getFee(int feeId) throws Exception;

	/*更新收费记录*/
	public void updateFee(Fee fee) throws Exception;

	/*删除收费记录*/
	public void deleteFee(int feeId) throws Exception;

}
