package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.LeaveWord;

public interface LeaveWordMapper {
	/*添加留言投诉信息*/
	public void addLeaveWord(LeaveWord leaveWord) throws Exception;

	/*按照查询条件分页查询留言投诉记录*/
	public ArrayList<LeaveWord> queryLeaveWord(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有留言投诉记录*/
	public ArrayList<LeaveWord> queryLeaveWordList(@Param("where") String where) throws Exception;

	/*按照查询条件的留言投诉记录数*/
	public int queryLeaveWordCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条留言投诉记录*/
	public LeaveWord getLeaveWord(int leaveWordId) throws Exception;

	/*更新留言投诉记录*/
	public void updateLeaveWord(LeaveWord leaveWord) throws Exception;

	/*删除留言投诉记录*/
	public void deleteLeaveWord(int leaveWordId) throws Exception;

}
