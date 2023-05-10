package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Fee {
    /*费用id*/
    private Integer feeId;
    public Integer getFeeId(){
        return feeId;
    }
    public void setFeeId(Integer feeId){
        this.feeId = feeId;
    }

    /*费用类别*/
    private FeeType feeTypeObj;
    public FeeType getFeeTypeObj() {
        return feeTypeObj;
    }
    public void setFeeTypeObj(FeeType feeTypeObj) {
        this.feeTypeObj = feeTypeObj;
    }

    /*住户信息*/
    private Owner ownerObj;
    public Owner getOwnerObj() {
        return ownerObj;
    }
    public void setOwnerObj(Owner ownerObj) {
        this.ownerObj = ownerObj;
    }

    /*收费时间*/
    @NotEmpty(message="收费时间不能为空")
    private String feeDate;
    public String getFeeDate() {
        return feeDate;
    }
    public void setFeeDate(String feeDate) {
        this.feeDate = feeDate;
    }

    /*收费金额*/
    @NotNull(message="必须输入收费金额")
    private Float feeMoney;
    public Float getFeeMoney() {
        return feeMoney;
    }
    public void setFeeMoney(Float feeMoney) {
        this.feeMoney = feeMoney;
    }

    /*收费内容*/
    @NotEmpty(message="收费内容不能为空")
    private String feeContent;
    public String getFeeContent() {
        return feeContent;
    }
    public void setFeeContent(String feeContent) {
        this.feeContent = feeContent;
    }

    /*操作员*/
    @NotEmpty(message="操作员不能为空")
    private String opUser;
    public String getOpUser() {
        return opUser;
    }
    public void setOpUser(String opUser) {
        this.opUser = opUser;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonFee=new JSONObject(); 
		jsonFee.accumulate("feeId", this.getFeeId());
		jsonFee.accumulate("feeTypeObj", this.getFeeTypeObj().getTypeName());
		jsonFee.accumulate("feeTypeObjPri", this.getFeeTypeObj().getTypeId());
		jsonFee.accumulate("ownerObj", this.getOwnerObj().getOwnerName());
		jsonFee.accumulate("ownerObjPri", this.getOwnerObj().getOwnerId());
		jsonFee.accumulate("feeDate", this.getFeeDate().length()>19?this.getFeeDate().substring(0,19):this.getFeeDate());
		jsonFee.accumulate("feeMoney", this.getFeeMoney());
		jsonFee.accumulate("feeContent", this.getFeeContent());
		jsonFee.accumulate("opUser", this.getOpUser());
		return jsonFee;
    }}