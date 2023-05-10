package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.OwnerService;
import com.chengxusheji.po.Owner;
import com.chengxusheji.service.BuildingService;
import com.chengxusheji.po.Building;

//Owner管理控制层
@Controller
@RequestMapping("/Owner")
public class OwnerController extends BaseController {

    /*业务层对象*/
    @Resource OwnerService ownerService;

    @Resource BuildingService buildingService;
	@InitBinder("buildingObj")
	public void initBinderbuildingObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("buildingObj.");
	}
	@InitBinder("owner")
	public void initBinderOwner(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("owner.");
	}
	/*跳转到添加Owner视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Owner());
		/*查询所有的Building信息*/
		List<Building> buildingList = buildingService.queryAllBuilding();
		request.setAttribute("buildingList", buildingList);
		return "Owner_add";
	}

	/*客户端ajax方式提交添加业主信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Owner owner, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        ownerService.addOwner(owner);
        message = "业主添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询业主信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("buildingObj") Building buildingObj,String roomNo,String ownerName,String telephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (roomNo == null) roomNo = "";
		if (ownerName == null) ownerName = "";
		if (telephone == null) telephone = "";
		if(rows != 0)ownerService.setRows(rows);
		List<Owner> ownerList = ownerService.queryOwner(buildingObj, roomNo, ownerName, telephone, page);
	    /*计算总的页数和总的记录数*/
	    ownerService.queryTotalPageAndRecordNumber(buildingObj, roomNo, ownerName, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = ownerService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = ownerService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Owner owner:ownerList) {
			JSONObject jsonOwner = owner.getJsonObject();
			jsonArray.put(jsonOwner);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询业主信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Owner> ownerList = ownerService.queryAllOwner();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Owner owner:ownerList) {
			JSONObject jsonOwner = new JSONObject();
			jsonOwner.accumulate("ownerId", owner.getOwnerId());
			jsonOwner.accumulate("ownerName", owner.getOwnerName());
			jsonArray.put(jsonOwner);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询业主信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("buildingObj") Building buildingObj,String roomNo,String ownerName,String telephone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (roomNo == null) roomNo = "";
		if (ownerName == null) ownerName = "";
		if (telephone == null) telephone = "";
		List<Owner> ownerList = ownerService.queryOwner(buildingObj, roomNo, ownerName, telephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    ownerService.queryTotalPageAndRecordNumber(buildingObj, roomNo, ownerName, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = ownerService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = ownerService.getRecordNumber();
	    request.setAttribute("ownerList",  ownerList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("buildingObj", buildingObj);
	    request.setAttribute("roomNo", roomNo);
	    request.setAttribute("ownerName", ownerName);
	    request.setAttribute("telephone", telephone);
	    List<Building> buildingList = buildingService.queryAllBuilding();
	    request.setAttribute("buildingList", buildingList);
		return "Owner/owner_frontquery_result"; 
	}

     /*前台查询Owner信息*/
	@RequestMapping(value="/{ownerId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer ownerId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键ownerId获取Owner对象*/
        Owner owner = ownerService.getOwner(ownerId);

        List<Building> buildingList = buildingService.queryAllBuilding();
        request.setAttribute("buildingList", buildingList);
        request.setAttribute("owner",  owner);
        return "Owner/owner_frontshow";
	}

	/*ajax方式显示业主修改jsp视图页*/
	@RequestMapping(value="/{ownerId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer ownerId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键ownerId获取Owner对象*/
        Owner owner = ownerService.getOwner(ownerId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonOwner = owner.getJsonObject();
		out.println(jsonOwner.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新业主信息*/
	@RequestMapping(value = "/{ownerId}/update", method = RequestMethod.POST)
	public void update(@Validated Owner owner, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			ownerService.updateOwner(owner);
			message = "业主更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "业主更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除业主信息*/
	@RequestMapping(value="/{ownerId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer ownerId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  ownerService.deleteOwner(ownerId);
	            request.setAttribute("message", "业主删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "业主删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条业主记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String ownerIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = ownerService.deleteOwners(ownerIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出业主信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("buildingObj") Building buildingObj,String roomNo,String ownerName,String telephone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(roomNo == null) roomNo = "";
        if(ownerName == null) ownerName = "";
        if(telephone == null) telephone = "";
        List<Owner> ownerList = ownerService.queryOwner(buildingObj,roomNo,ownerName,telephone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Owner信息记录"; 
        String[] headers = { "业主id","楼栋名称","房间号","户主","房屋面积","联系方式"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<ownerList.size();i++) {
        	Owner owner = ownerList.get(i); 
        	dataset.add(new String[]{owner.getOwnerId() + "",owner.getBuildingObj().getBuildingName(),owner.getRoomNo(),owner.getOwnerName(),owner.getArea(),owner.getTelephone()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Owner.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
