package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Employee;
import com.chengxusheji.po.Salary;

import com.chengxusheji.mapper.SalaryMapper;
@Service
public class SalaryService {

	@Resource SalaryMapper salaryMapper;
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

    /*添加工资记录*/
    public void addSalary(Salary salary) throws Exception {
    	salaryMapper.addSalary(salary);
    }

    /*按照查询条件分页查询工资记录*/
    public ArrayList<Salary> querySalary(Employee employeeObj,String year,String month,String fafang,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != employeeObj &&  employeeObj.getEmployeeNo() != null  && !employeeObj.getEmployeeNo().equals(""))  where += " and t_salary.employeeObj='" + employeeObj.getEmployeeNo() + "'";
    	if(!year.equals("")) where = where + " and t_salary.year like '%" + year + "%'";
    	if(!month.equals("")) where = where + " and t_salary.month like '%" + month + "%'";
    	if(!fafang.equals("")) where = where + " and t_salary.fafang like '%" + fafang + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return salaryMapper.querySalary(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Salary> querySalary(Employee employeeObj,String year,String month,String fafang) throws Exception  { 
     	String where = "where 1=1";
    	if(null != employeeObj &&  employeeObj.getEmployeeNo() != null && !employeeObj.getEmployeeNo().equals(""))  where += " and t_salary.employeeObj='" + employeeObj.getEmployeeNo() + "'";
    	if(!year.equals("")) where = where + " and t_salary.year like '%" + year + "%'";
    	if(!month.equals("")) where = where + " and t_salary.month like '%" + month + "%'";
    	if(!fafang.equals("")) where = where + " and t_salary.fafang like '%" + fafang + "%'";
    	return salaryMapper.querySalaryList(where);
    }

    /*查询所有工资记录*/
    public ArrayList<Salary> queryAllSalary()  throws Exception {
        return salaryMapper.querySalaryList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Employee employeeObj,String year,String month,String fafang) throws Exception {
     	String where = "where 1=1";
    	if(null != employeeObj &&  employeeObj.getEmployeeNo() != null && !employeeObj.getEmployeeNo().equals(""))  where += " and t_salary.employeeObj='" + employeeObj.getEmployeeNo() + "'";
    	if(!year.equals("")) where = where + " and t_salary.year like '%" + year + "%'";
    	if(!month.equals("")) where = where + " and t_salary.month like '%" + month + "%'";
    	if(!fafang.equals("")) where = where + " and t_salary.fafang like '%" + fafang + "%'";
        recordNumber = salaryMapper.querySalaryCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取工资记录*/
    public Salary getSalary(int salaryId) throws Exception  {
        Salary salary = salaryMapper.getSalary(salaryId);
        return salary;
    }

    /*更新工资记录*/
    public void updateSalary(Salary salary) throws Exception {
        salaryMapper.updateSalary(salary);
    }

    /*删除一条工资记录*/
    public void deleteSalary (int salaryId) throws Exception {
        salaryMapper.deleteSalary(salaryId);
    }

    /*删除多条工资信息*/
    public int deleteSalarys (String salaryIds) throws Exception {
    	String _salaryIds[] = salaryIds.split(",");
    	for(String _salaryId: _salaryIds) {
    		salaryMapper.deleteSalary(Integer.parseInt(_salaryId));
    	}
    	return _salaryIds.length;
    }
}
