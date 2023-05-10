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
import com.chengxusheji.service.FacilityService;
import com.chengxusheji.po.Facility;

//Facility管理控制层
@Controller
@RequestMapping("/Facility")
public class FacilityController extends BaseController {

    /*业务层对象*/
    @Resource FacilityService facilityService;

	@InitBinder("facility")
	public void initBinderFacility(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("facility.");
	}
	/*跳转到添加Facility视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Facility());
		return "Facility_add";
	}

	/*客户端ajax方式提交添加设施信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Facility facility, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        facilityService.addFacility(facility);
        message = "设施添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询设施信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String name,String startTime,String facilityState,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (name == null) name = "";
		if (startTime == null) startTime = "";
		if (facilityState == null) facilityState = "";
		if(rows != 0)facilityService.setRows(rows);
		List<Facility> facilityList = facilityService.queryFacility(name, startTime, facilityState, page);
	    /*计算总的页数和总的记录数*/
	    facilityService.queryTotalPageAndRecordNumber(name, startTime, facilityState);
	    /*获取到总的页码数目*/
	    int totalPage = facilityService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = facilityService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Facility facility:facilityList) {
			JSONObject jsonFacility = facility.getJsonObject();
			jsonArray.put(jsonFacility);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询设施信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Facility> facilityList = facilityService.queryAllFacility();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Facility facility:facilityList) {
			JSONObject jsonFacility = new JSONObject();
			jsonFacility.accumulate("facilityId", facility.getFacilityId());
			jsonFacility.accumulate("name", facility.getName());
			jsonArray.put(jsonFacility);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询设施信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String name,String startTime,String facilityState,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (name == null) name = "";
		if (startTime == null) startTime = "";
		if (facilityState == null) facilityState = "";
		List<Facility> facilityList = facilityService.queryFacility(name, startTime, facilityState, currentPage);
	    /*计算总的页数和总的记录数*/
	    facilityService.queryTotalPageAndRecordNumber(name, startTime, facilityState);
	    /*获取到总的页码数目*/
	    int totalPage = facilityService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = facilityService.getRecordNumber();
	    request.setAttribute("facilityList",  facilityList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("name", name);
	    request.setAttribute("startTime", startTime);
	    request.setAttribute("facilityState", facilityState);
		return "Facility/facility_frontquery_result"; 
	}

     /*前台查询Facility信息*/
	@RequestMapping(value="/{facilityId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer facilityId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键facilityId获取Facility对象*/
        Facility facility = facilityService.getFacility(facilityId);

        request.setAttribute("facility",  facility);
        return "Facility/facility_frontshow";
	}

	/*ajax方式显示设施修改jsp视图页*/
	@RequestMapping(value="/{facilityId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer facilityId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键facilityId获取Facility对象*/
        Facility facility = facilityService.getFacility(facilityId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonFacility = facility.getJsonObject();
		out.println(jsonFacility.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新设施信息*/
	@RequestMapping(value = "/{facilityId}/update", method = RequestMethod.POST)
	public void update(@Validated Facility facility, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			facilityService.updateFacility(facility);
			message = "设施更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "设施更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除设施信息*/
	@RequestMapping(value="/{facilityId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer facilityId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  facilityService.deleteFacility(facilityId);
	            request.setAttribute("message", "设施删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "设施删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条设施记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String facilityIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = facilityService.deleteFacilitys(facilityIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出设施信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String name,String startTime,String facilityState, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(name == null) name = "";
        if(startTime == null) startTime = "";
        if(facilityState == null) facilityState = "";
        List<Facility> facilityList = facilityService.queryFacility(name,startTime,facilityState);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Facility信息记录"; 
        String[] headers = { "设施id","设施名称","数量","开始使用时间","设施状态"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<facilityList.size();i++) {
        	Facility facility = facilityList.get(i); 
        	dataset.add(new String[]{facility.getFacilityId() + "",facility.getName(),facility.getCount() + "",facility.getStartTime(),facility.getFacilityState()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Facility.xls");//filename是下载的xls的名，建议最好用英文 
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
