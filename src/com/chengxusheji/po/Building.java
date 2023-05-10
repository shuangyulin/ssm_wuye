package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Building {
    /*楼栋id*/
    private Integer buildingId;
    public Integer getBuildingId(){
        return buildingId;
    }
    public void setBuildingId(Integer buildingId){
        this.buildingId = buildingId;
    }

    /*楼栋名称*/
    @NotEmpty(message="楼栋名称不能为空")
    private String buildingName;
    public String getBuildingName() {
        return buildingName;
    }
    public void setBuildingName(String buildingName) {
        this.buildingName = buildingName;
    }

    /*楼栋备注*/
    @NotEmpty(message="楼栋备注不能为空")
    private String memo;
    public String getMemo() {
        return memo;
    }
    public void setMemo(String memo) {
        this.memo = memo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonBuilding=new JSONObject(); 
		jsonBuilding.accumulate("buildingId", this.getBuildingId());
		jsonBuilding.accumulate("buildingName", this.getBuildingName());
		jsonBuilding.accumulate("memo", this.getMemo());
		return jsonBuilding;
    }}