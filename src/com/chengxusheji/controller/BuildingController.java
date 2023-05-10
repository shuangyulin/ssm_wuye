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
import com.chengxusheji.service.BuildingService;
import com.chengxusheji.po.Building;

//Building管理控制层
@Controller
@RequestMapping("/Building")
public class BuildingController extends BaseController {

    /*业务层对象*/
    @Resource BuildingService buildingService;

	@InitBinder("building")
	public void initBinderBuilding(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("building.");
	}
	/*跳转到添加Building视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Building());
		return "Building_add";
	}

	/*客户端ajax方式提交添加楼栋信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Building building, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        buildingService.addBuilding(building);
        message = "楼栋添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询楼栋信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)buildingService.setRows(rows);
		List<Building> buildingList = buildingService.queryBuilding(page);
	    /*计算总的页数和总的记录数*/
	    buildingService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = buildingService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = buildingService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Building building:buildingList) {
			JSONObject jsonBuilding = building.getJsonObject();
			jsonArray.put(jsonBuilding);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询楼栋信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Building> buildingList = buildingService.queryAllBuilding();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Building building:buildingList) {
			JSONObject jsonBuilding = new JSONObject();
			jsonBuilding.accumulate("buildingId", building.getBuildingId());
			jsonBuilding.accumulate("buildingName", building.getBuildingName());
			jsonArray.put(jsonBuilding);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询楼栋信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<Building> buildingList = buildingService.queryBuilding(currentPage);
	    /*计算总的页数和总的记录数*/
	    buildingService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = buildingService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = buildingService.getRecordNumber();
	    request.setAttribute("buildingList",  buildingList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "Building/building_frontquery_result"; 
	}

     /*前台查询Building信息*/
	@RequestMapping(value="/{buildingId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer buildingId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键buildingId获取Building对象*/
        Building building = buildingService.getBuilding(buildingId);

        request.setAttribute("building",  building);
        return "Building/building_frontshow";
	}

	/*ajax方式显示楼栋修改jsp视图页*/
	@RequestMapping(value="/{buildingId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer buildingId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键buildingId获取Building对象*/
        Building building = buildingService.getBuilding(buildingId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonBuilding = building.getJsonObject();
		out.println(jsonBuilding.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新楼栋信息*/
	@RequestMapping(value = "/{buildingId}/update", method = RequestMethod.POST)
	public void update(@Validated Building building, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			buildingService.updateBuilding(building);
			message = "楼栋更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "楼栋更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除楼栋信息*/
	@RequestMapping(value="/{buildingId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer buildingId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  buildingService.deleteBuilding(buildingId);
	            request.setAttribute("message", "楼栋删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "楼栋删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条楼栋记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String buildingIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = buildingService.deleteBuildings(buildingIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出楼栋信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<Building> buildingList = buildingService.queryBuilding();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Building信息记录"; 
        String[] headers = { "楼栋id","楼栋名称","楼栋备注"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<buildingList.size();i++) {
        	Building building = buildingList.get(i); 
        	dataset.add(new String[]{building.getBuildingId() + "",building.getBuildingName(),building.getMemo()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Building.xls");//filename是下载的xls的名，建议最好用英文 
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
