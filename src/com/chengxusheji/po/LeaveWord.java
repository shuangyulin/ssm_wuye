package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class LeaveWord {
    /*记录id*/
    private Integer leaveWordId;
    public Integer getLeaveWordId(){
        return leaveWordId;
    }
    public void setLeaveWordId(Integer leaveWordId){
        this.leaveWordId = leaveWordId;
    }

    /*标题*/
    @NotEmpty(message="标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*内容*/
    @NotEmpty(message="内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*发布时间*/
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    /*提交住户*/
    private Owner ownerObj;
    public Owner getOwnerObj() {
        return ownerObj;
    }
    public void setOwnerObj(Owner ownerObj) {
        this.ownerObj = ownerObj;
    }

    /*回复内容*/
    private String replyContent;
    public String getReplyContent() {
        return replyContent;
    }
    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    /*回复时间*/
    private String replyTime;
    public String getReplyTime() {
        return replyTime;
    }
    public void setReplyTime(String replyTime) {
        this.replyTime = replyTime;
    }

    /*回复人*/
    @NotEmpty(message="回复人不能为空")
    private String opUser;
    public String getOpUser() {
        return opUser;
    }
    public void setOpUser(String opUser) {
        this.opUser = opUser;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonLeaveWord=new JSONObject(); 
		jsonLeaveWord.accumulate("leaveWordId", this.getLeaveWordId());
		jsonLeaveWord.accumulate("title", this.getTitle());
		jsonLeaveWord.accumulate("content", this.getContent());
		jsonLeaveWord.accumulate("addTime", this.getAddTime());
		jsonLeaveWord.accumulate("ownerObj", this.getOwnerObj().getOwnerName());
		jsonLeaveWord.accumulate("ownerObjPri", this.getOwnerObj().getOwnerId());
		jsonLeaveWord.accumulate("replyContent", this.getReplyContent());
		jsonLeaveWord.accumulate("replyTime", this.getReplyTime());
		jsonLeaveWord.accumulate("opUser", this.getOpUser());
		return jsonLeaveWord;
    }}