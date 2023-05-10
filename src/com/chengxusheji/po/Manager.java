package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Manager {
    /*用户名*/
    @NotEmpty(message="用户名不能为空")
    private String manageUserName;
    public String getManageUserName(){
        return manageUserName;
    }
    public void setManageUserName(String manageUserName){
        this.manageUserName = manageUserName;
    }

    /*登录密码*/
    @NotEmpty(message="登录密码不能为空")
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*管理员类别*/
    @NotEmpty(message="管理员类别不能为空")
    private String manageType;
    public String getManageType() {
        return manageType;
    }
    public void setManageType(String manageType) {
        this.manageType = manageType;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String sex;
    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonManager=new JSONObject(); 
		jsonManager.accumulate("manageUserName", this.getManageUserName());
		jsonManager.accumulate("password", this.getPassword());
		jsonManager.accumulate("manageType", this.getManageType());
		jsonManager.accumulate("name", this.getName());
		jsonManager.accumulate("sex", this.getSex());
		jsonManager.accumulate("telephone", this.getTelephone());
		return jsonManager;
    }}