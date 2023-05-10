package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Owner;
import com.chengxusheji.po.Parking;

import com.chengxusheji.mapper.ParkingMapper;
@Service
public class ParkingService {

	@Resource ParkingMapper parkingMapper;
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

    /*添加停车位记录*/
    public void addParking(Parking parking) throws Exception {
    	parkingMapper.addParking(parking);
    }

    /*按照查询条件分页查询停车位记录*/
    public ArrayList<Parking> queryParking(String parkingName,String plateNumber,Owner ownerObj,String opUser,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!parkingName.equals("")) where = where + " and t_parking.parkingName like '%" + parkingName + "%'";
    	if(!plateNumber.equals("")) where = where + " and t_parking.plateNumber like '%" + plateNumber + "%'";
    	if(null != ownerObj && ownerObj.getOwnerId()!= null && ownerObj.getOwnerId()!= 0)  where += " and t_parking.ownerObj=" + ownerObj.getOwnerId();
    	if(!opUser.equals("")) where = where + " and t_parking.opUser like '%" + opUser + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return parkingMapper.queryParking(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Parking> queryParking(String parkingName,String plateNumber,Owner ownerObj,String opUser) throws Exception  { 
     	String where = "where 1=1";
    	if(!parkingName.equals("")) where = where + " and t_parking.parkingName like '%" + parkingName + "%'";
    	if(!plateNumber.equals("")) where = where + " and t_parking.plateNumber like '%" + plateNumber + "%'";
    	if(null != ownerObj && ownerObj.getOwnerId()!= null && ownerObj.getOwnerId()!= 0)  where += " and t_parking.ownerObj=" + ownerObj.getOwnerId();
    	if(!opUser.equals("")) where = where + " and t_parking.opUser like '%" + opUser + "%'";
    	return parkingMapper.queryParkingList(where);
    }

    /*查询所有停车位记录*/
    public ArrayList<Parking> queryAllParking()  throws Exception {
        return parkingMapper.queryParkingList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String parkingName,String plateNumber,Owner ownerObj,String opUser) throws Exception {
     	String where = "where 1=1";
    	if(!parkingName.equals("")) where = where + " and t_parking.parkingName like '%" + parkingName + "%'";
    	if(!plateNumber.equals("")) where = where + " and t_parking.plateNumber like '%" + plateNumber + "%'";
    	if(null != ownerObj && ownerObj.getOwnerId()!= null && ownerObj.getOwnerId()!= 0)  where += " and t_parking.ownerObj=" + ownerObj.getOwnerId();
    	if(!opUser.equals("")) where = where + " and t_parking.opUser like '%" + opUser + "%'";
        recordNumber = parkingMapper.queryParkingCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取停车位记录*/
    public Parking getParking(int parkingId) throws Exception  {
        Parking parking = parkingMapper.getParking(parkingId);
        return parking;
    }

    /*更新停车位记录*/
    public void updateParking(Parking parking) throws Exception {
        parkingMapper.updateParking(parking);
    }

    /*删除一条停车位记录*/
    public void deleteParking (int parkingId) throws Exception {
        parkingMapper.deleteParking(parkingId);
    }

    /*删除多条停车位信息*/
    public int deleteParkings (String parkingIds) throws Exception {
    	String _parkingIds[] = parkingIds.split(",");
    	for(String _parkingId: _parkingIds) {
    		parkingMapper.deleteParking(Integer.parseInt(_parkingId));
    	}
    	return _parkingIds.length;
    }
}
