package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Manager;

import com.chengxusheji.mapper.ManagerMapper;
@Service
public class ManagerService {

	@Resource ManagerMapper managerMapper;
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

    /*添加管理员记录*/
    public void addManager(Manager manager) throws Exception {
    	managerMapper.addManager(manager);
    }

    /*按照查询条件分页查询管理员记录*/
    public ArrayList<Manager> queryManager(String manageUserName,String manageType,String name,String telephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!manageUserName.equals("")) where = where + " and t_manager.manageUserName like '%" + manageUserName + "%'";
    	if(!manageType.equals("")) where = where + " and t_manager.manageType like '%" + manageType + "%'";
    	if(!name.equals("")) where = where + " and t_manager.name like '%" + name + "%'";
    	if(!telephone.equals("")) where = where + " and t_manager.telephone like '%" + telephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return managerMapper.queryManager(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Manager> queryManager(String manageUserName,String manageType,String name,String telephone) throws Exception  { 
     	String where = "where 1=1";
    	if(!manageUserName.equals("")) where = where + " and t_manager.manageUserName like '%" + manageUserName + "%'";
    	if(!manageType.equals("")) where = where + " and t_manager.manageType like '%" + manageType + "%'";
    	if(!name.equals("")) where = where + " and t_manager.name like '%" + name + "%'";
    	if(!telephone.equals("")) where = where + " and t_manager.telephone like '%" + telephone + "%'";
    	return managerMapper.queryManagerList(where);
    }

    /*查询所有管理员记录*/
    public ArrayList<Manager> queryAllManager()  throws Exception {
        return managerMapper.queryManagerList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String manageUserName,String manageType,String name,String telephone) throws Exception {
     	String where = "where 1=1";
    	if(!manageUserName.equals("")) where = where + " and t_manager.manageUserName like '%" + manageUserName + "%'";
    	if(!manageType.equals("")) where = where + " and t_manager.manageType like '%" + manageType + "%'";
    	if(!name.equals("")) where = where + " and t_manager.name like '%" + name + "%'";
    	if(!telephone.equals("")) where = where + " and t_manager.telephone like '%" + telephone + "%'";
        recordNumber = managerMapper.queryManagerCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取管理员记录*/
    public Manager getManager(String manageUserName) throws Exception  {
        Manager manager = managerMapper.getManager(manageUserName);
        return manager;
    }

    /*更新管理员记录*/
    public void updateManager(Manager manager) throws Exception {
        managerMapper.updateManager(manager);
    }

    /*删除一条管理员记录*/
    public void deleteManager (String manageUserName) throws Exception {
        managerMapper.deleteManager(manageUserName);
    }

    /*删除多条管理员信息*/
    public int deleteManagers (String manageUserNames) throws Exception {
    	String _manageUserNames[] = manageUserNames.split(",");
    	for(String _manageUserName: _manageUserNames) {
    		managerMapper.deleteManager(_manageUserName);
    	}
    	return _manageUserNames.length;
    }
}
