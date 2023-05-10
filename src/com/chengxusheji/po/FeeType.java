package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class FeeType {
    /*类别id*/
    private Integer typeId;
    public Integer getTypeId(){
        return typeId;
    }
    public void setTypeId(Integer typeId){
        this.typeId = typeId;
    }

    /*类别名称*/
    @NotEmpty(message="类别名称不能为空")
    private String typeName;
    public String getTypeName() {
        return typeName;
    }
    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonFeeType=new JSONObject(); 
		jsonFeeType.accumulate("typeId", this.getTypeId());
		jsonFeeType.accumulate("typeName", this.getTypeName());
		return jsonFeeType;
    }}