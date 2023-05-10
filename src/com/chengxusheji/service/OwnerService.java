package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Building;
import com.chengxusheji.po.Owner;

import com.chengxusheji.mapper.OwnerMapper;
@Service
public class OwnerService {

	@Resource OwnerMapper ownerMapper;
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

    /*添加业主记录*/
    public void addOwner(Owner owner) throws Exception {
    	ownerMapper.addOwner(owner);
    }

    /*按照查询条件分页查询业主记录*/
    public ArrayList<Owner> queryOwner(Building buildingObj,String roomNo,String ownerName,String telephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != buildingObj && buildingObj.getBuildingId()!= null && buildingObj.getBuildingId()!= 0)  where += " and t_owner.buildingObj=" + buildingObj.getBuildingId();
    	if(!roomNo.equals("")) where = where + " and t_owner.roomNo like '%" + roomNo + "%'";
    	if(!ownerName.equals("")) where = where + " and t_owner.ownerName like '%" + ownerName + "%'";
    	if(!telephone.equals("")) where = where + " and t_owner.telephone like '%" + telephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return ownerMapper.queryOwner(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Owner> queryOwner(Building buildingObj,String roomNo,String ownerName,String telephone) throws Exception  { 
     	String where = "where 1=1";
    	if(null != buildingObj && buildingObj.getBuildingId()!= null && buildingObj.getBuildingId()!= 0)  where += " and t_owner.buildingObj=" + buildingObj.getBuildingId();
    	if(!roomNo.equals("")) where = where + " and t_owner.roomNo like '%" + roomNo + "%'";
    	if(!ownerName.equals("")) where = where + " and t_owner.ownerName like '%" + ownerName + "%'";
    	if(!telephone.equals("")) where = where + " and t_owner.telephone like '%" + telephone + "%'";
    	return ownerMapper.queryOwnerList(where);
    }

    /*查询所有业主记录*/
    public ArrayList<Owner> queryAllOwner()  throws Exception {
        return ownerMapper.queryOwnerList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Building buildingObj,String roomNo,String ownerName,String telephone) throws Exception {
     	String where = "where 1=1";
    	if(null != buildingObj && buildingObj.getBuildingId()!= null && buildingObj.getBuildingId()!= 0)  where += " and t_owner.buildingObj=" + buildingObj.getBuildingId();
    	if(!roomNo.equals("")) where = where + " and t_owner.roomNo like '%" + roomNo + "%'";
    	if(!ownerName.equals("")) where = where + " and t_owner.ownerName like '%" + ownerName + "%'";
    	if(!telephone.equals("")) where = where + " and t_owner.telephone like '%" + telephone + "%'";
        recordNumber = ownerMapper.queryOwnerCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取业主记录*/
    public Owner getOwner(int ownerId) throws Exception  {
        Owner owner = ownerMapper.getOwner(ownerId);
        return owner;
    }

    /*更新业主记录*/
    public void updateOwner(Owner owner) throws Exception {
        ownerMapper.updateOwner(owner);
    }

    /*删除一条业主记录*/
    public void deleteOwner (int ownerId) throws Exception {
        ownerMapper.deleteOwner(ownerId);
    }

    /*删除多条业主信息*/
    public int deleteOwners (String ownerIds) throws Exception {
    	String _ownerIds[] = ownerIds.split(",");
    	for(String _ownerId: _ownerIds) {
    		ownerMapper.deleteOwner(Integer.parseInt(_ownerId));
    	}
    	return _ownerIds.length;
    }
}
