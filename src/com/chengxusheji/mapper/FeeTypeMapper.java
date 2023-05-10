package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.FeeType;

public interface FeeTypeMapper {
	/*添加费用类别信息*/
	public void addFeeType(FeeType feeType) throws Exception;

	/*按照查询条件分页查询费用类别记录*/
	public ArrayList<FeeType> queryFeeType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有费用类别记录*/
	public ArrayList<FeeType> queryFeeTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的费用类别记录数*/
	public int queryFeeTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条费用类别记录*/
	public FeeType getFeeType(int typeId) throws Exception;

	/*更新费用类别记录*/
	public void updateFeeType(FeeType feeType) throws Exception;

	/*删除费用类别记录*/
	public void deleteFeeType(int typeId) throws Exception;

}
