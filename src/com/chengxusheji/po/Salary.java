package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Salary {
    /*工资id*/
    private Integer salaryId;
    public Integer getSalaryId(){
        return salaryId;
    }
    public void setSalaryId(Integer salaryId){
        this.salaryId = salaryId;
    }

    /*员工*/
    private Employee employeeObj;
    public Employee getEmployeeObj() {
        return employeeObj;
    }
    public void setEmployeeObj(Employee employeeObj) {
        this.employeeObj = employeeObj;
    }

    /*工资年份*/
    @NotEmpty(message="工资年份不能为空")
    private String year;
    public String getYear() {
        return year;
    }
    public void setYear(String year) {
        this.year = year;
    }

    /*工资月份*/
    @NotEmpty(message="工资月份不能为空")
    private String month;
    public String getMonth() {
        return month;
    }
    public void setMonth(String month) {
        this.month = month;
    }

    /*工资金额*/
    @NotNull(message="必须输入工资金额")
    private Float salaryMoney;
    public Float getSalaryMoney() {
        return salaryMoney;
    }
    public void setSalaryMoney(Float salaryMoney) {
        this.salaryMoney = salaryMoney;
    }

    /*是否发放*/
    @NotEmpty(message="是否发放不能为空")
    private String fafang;
    public String getFafang() {
        return fafang;
    }
    public void setFafang(String fafang) {
        this.fafang = fafang;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSalary=new JSONObject(); 
		jsonSalary.accumulate("salaryId", this.getSalaryId());
		jsonSalary.accumulate("employeeObj", this.getEmployeeObj().getName());
		jsonSalary.accumulate("employeeObjPri", this.getEmployeeObj().getEmployeeNo());
		jsonSalary.accumulate("year", this.getYear());
		jsonSalary.accumulate("month", this.getMonth());
		jsonSalary.accumulate("salaryMoney", this.getSalaryMoney());
		jsonSalary.accumulate("fafang", this.getFafang());
		return jsonSalary;
    }}