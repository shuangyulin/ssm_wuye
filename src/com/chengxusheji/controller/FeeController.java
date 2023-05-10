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
import com.chengxusheji.service.FeeService;
import com.chengxusheji.po.Fee;
import com.chengxusheji.service.FeeTypeService;
import com.chengxusheji.po.FeeType;
import com.chengxusheji.service.OwnerService;
import com.chengxusheji.po.Owner;

//Fee管理控制层
@Controller
@RequestMapping("/Fee")
public class FeeController extends BaseController {

    /*业务层对象*/
    @Resource FeeService feeService;

    @Resource FeeTypeService feeTypeService;
    @Resource OwnerService ownerService;
	@InitBinder("feeTypeObj")
	public void initBinderfeeTypeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("feeTypeObj.");
	}
	@InitBinder("ownerObj")
	public void initBinderownerObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("ownerObj.");
	}
	@InitBinder("fee")
	public void initBinderFee(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("fee.");
	}
	/*跳转到添加Fee视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Fee());
		/*查询所有的FeeType信息*/
		List<FeeType> feeTypeList = feeTypeService.queryAllFeeType();
		request.setAttribute("feeTypeList", feeTypeList);
		/*查询所有的Owner信息*/
		List<Owner> ownerList = ownerService.queryAllOwner();
		request.setAttribute("ownerList", ownerList);
		return "Fee_add";
	}

	/*客户端ajax方式提交添加收费信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Fee fee, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        feeService.addFee(fee);
        message = "收费添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询收费信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("feeTypeObj") FeeType feeTypeObj,@ModelAttribute("ownerObj") Owner ownerObj,String feeDate,String feeContent,String opUser,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (feeDate == null) feeDate = "";
		if (feeContent == null) feeContent = "";
		if (opUser == null) opUser = "";
		if(rows != 0)feeService.setRows(rows);
		List<Fee> feeList = feeService.queryFee(feeTypeObj, ownerObj, feeDate, feeContent, opUser, page);
	    /*计算总的页数和总的记录数*/
	    feeService.queryTotalPageAndRecordNumber(feeTypeObj, ownerObj, feeDate, feeContent, opUser);
	    /*获取到总的页码数目*/
	    int totalPage = feeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = feeService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Fee fee:feeList) {
			JSONObject jsonFee = fee.getJsonObject();
			jsonArray.put(jsonFee);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询收费信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Fee> feeList = feeService.queryAllFee();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Fee fee:feeList) {
			JSONObject jsonFee = new JSONObject();
			jsonFee.accumulate("feeId", fee.getFeeId());
			jsonArray.put(jsonFee);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询收费信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("feeTypeObj") FeeType feeTypeObj,@ModelAttribute("ownerObj") Owner ownerObj,String feeDate,String feeContent,String opUser,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (feeDate == null) feeDate = "";
		if (feeContent == null) feeContent = "";
		if (opUser == null) opUser = "";
		List<Fee> feeList = feeService.queryFee(feeTypeObj, ownerObj, feeDate, feeContent, opUser, currentPage);
	    /*计算总的页数和总的记录数*/
	    feeService.queryTotalPageAndRecordNumber(feeTypeObj, ownerObj, feeDate, feeContent, opUser);
	    /*获取到总的页码数目*/
	    int totalPage = feeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = feeService.getRecordNumber();
	    request.setAttribute("feeList",  feeList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("feeTypeObj", feeTypeObj);
	    request.setAttribute("ownerObj", ownerObj);
	    request.setAttribute("feeDate", feeDate);
	    request.setAttribute("feeContent", feeContent);
	    request.setAttribute("opUser", opUser);
	    List<FeeType> feeTypeList = feeTypeService.queryAllFeeType();
	    request.setAttribute("feeTypeList", feeTypeList);
	    List<Owner> ownerList = ownerService.queryAllOwner();
	    request.setAttribute("ownerList", ownerList);
		return "Fee/fee_frontquery_result"; 
	}

     /*前台查询Fee信息*/
	@RequestMapping(value="/{feeId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer feeId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键feeId获取Fee对象*/
        Fee fee = feeService.getFee(feeId);

        List<FeeType> feeTypeList = feeTypeService.queryAllFeeType();
        request.setAttribute("feeTypeList", feeTypeList);
        List<Owner> ownerList = ownerService.queryAllOwner();
        request.setAttribute("ownerList", ownerList);
        request.setAttribute("fee",  fee);
        return "Fee/fee_frontshow";
	}

	/*ajax方式显示收费修改jsp视图页*/
	@RequestMapping(value="/{feeId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer feeId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键feeId获取Fee对象*/
        Fee fee = feeService.getFee(feeId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonFee = fee.getJsonObject();
		out.println(jsonFee.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新收费信息*/
	@RequestMapping(value = "/{feeId}/update", method = RequestMethod.POST)
	public void update(@Validated Fee fee, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			feeService.updateFee(fee);
			message = "收费更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "收费更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除收费信息*/
	@RequestMapping(value="/{feeId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer feeId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  feeService.deleteFee(feeId);
	            request.setAttribute("message", "收费删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "收费删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条收费记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String feeIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = feeService.deleteFees(feeIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出收费信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("feeTypeObj") FeeType feeTypeObj,@ModelAttribute("ownerObj") Owner ownerObj,String feeDate,String feeContent,String opUser, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(feeDate == null) feeDate = "";
        if(feeContent == null) feeContent = "";
        if(opUser == null) opUser = "";
        List<Fee> feeList = feeService.queryFee(feeTypeObj,ownerObj,feeDate,feeContent,opUser);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Fee信息记录"; 
        String[] headers = { "费用id","费用类别","住户信息","收费时间","收费金额","收费内容","操作员"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<feeList.size();i++) {
        	Fee fee = feeList.get(i); 
        	dataset.add(new String[]{fee.getFeeId() + "",fee.getFeeTypeObj().getTypeName(),fee.getOwnerObj().getOwnerName(),fee.getFeeDate(),fee.getFeeMoney() + "",fee.getFeeContent(),fee.getOpUser()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Fee.xls");//filename是下载的xls的名，建议最好用英文 
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
