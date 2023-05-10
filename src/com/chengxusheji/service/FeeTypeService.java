package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.FeeType;

import com.chengxusheji.mapper.FeeTypeMapper;
@Service
public class FeeTypeService {

	@Resource FeeTypeMapper feeTypeMapper;
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

    /*添加费用类别记录*/
    public void addFeeType(FeeType feeType) throws Exception {
    	feeTypeMapper.addFeeType(feeType);
    }

    /*按照查询条件分页查询费用类别记录*/
    public ArrayList<FeeType> queryFeeType(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return feeTypeMapper.queryFeeType(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<FeeType> queryFeeType() throws Exception  { 
     	String where = "where 1=1";
    	return feeTypeMapper.queryFeeTypeList(where);
    }

    /*查询所有费用类别记录*/
    public ArrayList<FeeType> queryAllFeeType()  throws Exception {
        return feeTypeMapper.queryFeeTypeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = feeTypeMapper.queryFeeTypeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取费用类别记录*/
    public FeeType getFeeType(int typeId) throws Exception  {
        FeeType feeType = feeTypeMapper.getFeeType(typeId);
        return feeType;
    }

    /*更新费用类别记录*/
    public void updateFeeType(FeeType feeType) throws Exception {
        feeTypeMapper.updateFeeType(feeType);
    }

    /*删除一条费用类别记录*/
    public void deleteFeeType (int typeId) throws Exception {
        feeTypeMapper.deleteFeeType(typeId);
    }

    /*删除多条费用类别信息*/
    public int deleteFeeTypes (String typeIds) throws Exception {
    	String _typeIds[] = typeIds.split(",");
    	for(String _typeId: _typeIds) {
    		feeTypeMapper.deleteFeeType(Integer.parseInt(_typeId));
    	}
    	return _typeIds.length;
    }
}
