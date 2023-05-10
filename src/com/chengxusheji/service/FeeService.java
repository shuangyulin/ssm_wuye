package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.FeeType;
import com.chengxusheji.po.Owner;
import com.chengxusheji.po.Fee;

import com.chengxusheji.mapper.FeeMapper;
@Service
public class FeeService {

	@Resource FeeMapper feeMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加收费记录*/
    public void addFee(Fee fee) throws Exception {
    	feeMapper.addFee(fee);
    }

    /*按照查询条件分页查询收费记录*/
    public ArrayList<Fee> queryFee(FeeType feeTypeObj,Owner ownerObj,String feeDate,String feeContent,String opUser,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != feeTypeObj && feeTypeObj.getTypeId()!= null && feeTypeObj.getTypeId()!= 0)  where += " and t_fee.feeTypeObj=" + feeTypeObj.getTypeId();
    	if(null != ownerObj && ownerObj.getOwnerId()!= null && ownerObj.getOwnerId()!= 0)  where += " and t_fee.ownerObj=" + ownerObj.getOwnerId();
    	if(!feeDate.equals("")) where = where + " and t_fee.feeDate like '%" + feeDate + "%'";
    	if(!feeContent.equals("")) where = where + " and t_fee.feeContent like '%" + feeContent + "%'";
    	if(!opUser.equals("")) where = where + " and t_fee.opUser like '%" + opUser + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return feeMapper.queryFee(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Fee> queryFee(FeeType feeTypeObj,Owner ownerObj,String feeDate,String feeContent,String opUser) throws Exception  { 
     	String where = "where 1=1";
    	if(null != feeTypeObj && feeTypeObj.getTypeId()!= null && feeTypeObj.getTypeId()!= 0)  where += " and t_fee.feeTypeObj=" + feeTypeObj.getTypeId();
    	if(null != ownerObj && ownerObj.getOwnerId()!= null && ownerObj.getOwnerId()!= 0)  where += " and t_fee.ownerObj=" + ownerObj.getOwnerId();
    	if(!feeDate.equals("")) where = where + " and t_fee.feeDate like '%" + feeDate + "%'";
    	if(!feeContent.equals("")) where = where + " and t_fee.feeContent like '%" + feeContent + "%'";
    	if(!opUser.equals("")) where = where + " and t_fee.opUser like '%" + opUser + "%'";
    	return feeMapper.queryFeeList(where);
    }

    /*查询所有收费记录*/
    public ArrayList<Fee> queryAllFee()  throws Exception {
        return feeMapper.queryFeeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(FeeType feeTypeObj,Owner ownerObj,String feeDate,String feeContent,String opUser) throws Exception {
     	String where = "where 1=1";
    	if(null != feeTypeObj && feeTypeObj.getTypeId()!= null && feeTypeObj.getTypeId()!= 0)  where += " and t_fee.feeTypeObj=" + feeTypeObj.getTypeId();
    	if(null != ownerObj && ownerObj.getOwnerId()!= null && ownerObj.getOwnerId()!= 0)  where += " and t_fee.ownerObj=" + ownerObj.getOwnerId();
    	if(!feeDate.equals("")) where = where + " and t_fee.feeDate like '%" + feeDate + "%'";
    	if(!feeContent.equals("")) where = where + " and t_fee.feeContent like '%" + feeContent + "%'";
    	if(!opUser.equals("")) where = where + " and t_fee.opUser like '%" + opUser + "%'";
        recordNumber = feeMapper.queryFeeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取收费记录*/
    public Fee getFee(int feeId) throws Exception  {
        Fee fee = feeMapper.getFee(feeId);
        return fee;
    }

    /*更新收费记录*/
    public void updateFee(Fee fee) throws Exception {
        feeMapper.updateFee(fee);
    }

    /*删除一条收费记录*/
    public void deleteFee (int feeId) throws Exception {
        feeMapper.deleteFee(feeId);
    }

    /*删除多条收费信息*/
    public int deleteFees (String feeIds) throws Exception {
    	String _feeIds[] = feeIds.split(",");
    	for(String _feeId: _feeIds) {
    		feeMapper.deleteFee(Integer.parseInt(_feeId));
    	}
    	return _feeIds.length;
    }
}
