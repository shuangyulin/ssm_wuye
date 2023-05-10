package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Facility {
    /*设施id*/
    private Integer facilityId;
    public Integer getFacilityId(){
        return facilityId;
    }
    public void setFacilityId(Integer facilityId){
        this.facilityId = facilityId;
    }

    /*设施名称*/
    @NotEmpty(message="设施名称不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*数量*/
    @NotNull(message="必须输入数量")
    private Integer count;
    public Integer getCount() {
        return count;
    }
    public void setCount(Integer count) {
        this.count = count;
    }

    /*开始使用时间*/
    @NotEmpty(message="开始使用时间不能为空")
    private String startTime;
    public String getStartTime() {
        return startTime;
    }
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    /*设施状态*/
    @NotEmpty(message="设施状态不能为空")
    private String facilityState;
    public String getFacilityState() {
        return facilityState;
    }
    public void setFacilityState(String facilityState) {
        this.facilityState = facilityState;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonFacility=new JSONObject(); 
		jsonFacility.accumulate("facilityId", this.getFacilityId());
		jsonFacility.accumulate("name", this.getName());
		jsonFacility.accumulate("count", this.getCount());
		jsonFacility.accumulate("startTime", this.getStartTime().length()>19?this.getStartTime().substring(0,19):this.getStartTime());
		jsonFacility.accumulate("facilityState", this.getFacilityState());
		return jsonFacility;
    }}