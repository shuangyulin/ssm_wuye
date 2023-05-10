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
import com.chengxusheji.service.ParkingService;
import com.chengxusheji.po.Parking;
import com.chengxusheji.service.OwnerService;
import com.chengxusheji.po.Owner;

//Parking管理控制层
@Controller
@RequestMapping("/Parking")
public class ParkingController extends BaseController {

    /*业务层对象*/
    @Resource ParkingService parkingService;

    @Resource OwnerService ownerService;
	@InitBinder("ownerObj")
	public void initBinderownerObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("ownerObj.");
	}
	@InitBinder("parking")
	public void initBinderParking(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("parking.");
	}
	/*跳转到添加Parking视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Parking());
		/*查询所有的Owner信息*/
		List<Owner> ownerList = ownerService.queryAllOwner();
		request.setAttribute("ownerList", ownerList);
		return "Parking_add";
	}

	/*客户端ajax方式提交添加停车位信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Parking parking, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        parkingService.addParking(parking);
        message = "停车位添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询停车位信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String parkingName,String plateNumber,@ModelAttribute("ownerObj") Owner ownerObj,String opUser,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (parkingName == null) parkingName = "";
		if (plateNumber == null) plateNumber = "";
		if (opUser == null) opUser = "";
		if(rows != 0)parkingService.setRows(rows);
		List<Parking> parkingList = parkingService.queryParking(parkingName, plateNumber, ownerObj, opUser, page);
	    /*计算总的页数和总的记录数*/
	    parkingService.queryTotalPageAndRecordNumber(parkingName, plateNumber, ownerObj, opUser);
	    /*获取到总的页码数目*/
	    int totalPage = parkingService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = parkingService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Parking parking:parkingList) {
			JSONObject jsonParking = parking.getJsonObject();
			jsonArray.put(jsonParking);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询停车位信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Parking> parkingList = parkingService.queryAllParking();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Parking parking:parkingList) {
			JSONObject jsonParking = new JSONObject();
			jsonParking.accumulate("parkingId", parking.getParkingId());
			jsonParking.accumulate("parkingName", parking.getParkingName());
			jsonArray.put(jsonParking);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询停车位信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String parkingName,String plateNumber,@ModelAttribute("ownerObj") Owner ownerObj,String opUser,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (parkingName == null) parkingName = "";
		if (plateNumber == null) plateNumber = "";
		if (opUser == null) opUser = "";
		List<Parking> parkingList = parkingService.queryParking(parkingName, plateNumber, ownerObj, opUser, currentPage);
	    /*计算总的页数和总的记录数*/
	    parkingService.queryTotalPageAndRecordNumber(parkingName, plateNumber, ownerObj, opUser);
	    /*获取到总的页码数目*/
	    int totalPage = parkingService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = parkingService.getRecordNumber();
	    request.setAttribute("parkingList",  parkingList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("parkingName", parkingName);
	    request.setAttribute("plateNumber", plateNumber);
	    request.setAttribute("ownerObj", ownerObj);
	    request.setAttribute("opUser", opUser);
	    List<Owner> ownerList = ownerService.queryAllOwner();
	    request.setAttribute("ownerList", ownerList);
		return "Parking/parking_frontquery_result"; 
	}

     /*前台查询Parking信息*/
	@RequestMapping(value="/{parkingId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer parkingId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键parkingId获取Parking对象*/
        Parking parking = parkingService.getParking(parkingId);

        List<Owner> ownerList = ownerService.queryAllOwner();
        request.setAttribute("ownerList", ownerList);
        request.setAttribute("parking",  parking);
        return "Parking/parking_frontshow";
	}

	/*ajax方式显示停车位修改jsp视图页*/
	@RequestMapping(value="/{parkingId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer parkingId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键parkingId获取Parking对象*/
        Parking parking = parkingService.getParking(parkingId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonParking = parking.getJsonObject();
		out.println(jsonParking.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新停车位信息*/
	@RequestMapping(value = "/{parkingId}/update", method = RequestMethod.POST)
	public void update(@Validated Parking parking, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			parkingService.updateParking(parking);
			message = "停车位更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "停车位更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除停车位信息*/
	@RequestMapping(value="/{parkingId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer parkingId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  parkingService.deleteParking(parkingId);
	            request.setAttribute("message", "停车位删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "停车位删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条停车位记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String parkingIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = parkingService.deleteParkings(parkingIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出停车位信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String parkingName,String plateNumber,@ModelAttribute("ownerObj") Owner ownerObj,String opUser, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(parkingName == null) parkingName = "";
        if(plateNumber == null) plateNumber = "";
        if(opUser == null) opUser = "";
        List<Parking> parkingList = parkingService.queryParking(parkingName,plateNumber,ownerObj,opUser);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Parking信息记录"; 
        String[] headers = { "车位id","车位名称","车牌号","车主","操作员"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<parkingList.size();i++) {
        	Parking parking = parkingList.get(i); 
        	dataset.add(new String[]{parking.getParkingId() + "",parking.getParkingName(),parking.getPlateNumber(),parking.getOwnerObj().getOwnerName(),parking.getOpUser()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Parking.xls");//filename是下载的xls的名，建议最好用英文 
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
