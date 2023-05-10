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
import com.chengxusheji.service.SalaryService;
import com.chengxusheji.po.Salary;
import com.chengxusheji.service.EmployeeService;
import com.chengxusheji.po.Employee;

//Salary管理控制层
@Controller
@RequestMapping("/Salary")
public class SalaryController extends BaseController {

    /*业务层对象*/
    @Resource SalaryService salaryService;

    @Resource EmployeeService employeeService;
	@InitBinder("employeeObj")
	public void initBinderemployeeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("employeeObj.");
	}
	@InitBinder("salary")
	public void initBinderSalary(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("salary.");
	}
	/*跳转到添加Salary视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Salary());
		/*查询所有的Employee信息*/
		List<Employee> employeeList = employeeService.queryAllEmployee();
		request.setAttribute("employeeList", employeeList);
		return "Salary_add";
	}

	/*客户端ajax方式提交添加工资信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Salary salary, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        salaryService.addSalary(salary);
        message = "工资添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询工资信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("employeeObj") Employee employeeObj,String year,String month,String fafang,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (year == null) year = "";
		if (month == null) month = "";
		if (fafang == null) fafang = "";
		if(rows != 0)salaryService.setRows(rows);
		List<Salary> salaryList = salaryService.querySalary(employeeObj, year, month, fafang, page);
	    /*计算总的页数和总的记录数*/
	    salaryService.queryTotalPageAndRecordNumber(employeeObj, year, month, fafang);
	    /*获取到总的页码数目*/
	    int totalPage = salaryService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = salaryService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Salary salary:salaryList) {
			JSONObject jsonSalary = salary.getJsonObject();
			jsonArray.put(jsonSalary);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询工资信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Salary> salaryList = salaryService.queryAllSalary();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Salary salary:salaryList) {
			JSONObject jsonSalary = new JSONObject();
			jsonSalary.accumulate("salaryId", salary.getSalaryId());
			jsonArray.put(jsonSalary);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询工资信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("employeeObj") Employee employeeObj,String year,String month,String fafang,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (year == null) year = "";
		if (month == null) month = "";
		if (fafang == null) fafang = "";
		List<Salary> salaryList = salaryService.querySalary(employeeObj, year, month, fafang, currentPage);
	    /*计算总的页数和总的记录数*/
	    salaryService.queryTotalPageAndRecordNumber(employeeObj, year, month, fafang);
	    /*获取到总的页码数目*/
	    int totalPage = salaryService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = salaryService.getRecordNumber();
	    request.setAttribute("salaryList",  salaryList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("employeeObj", employeeObj);
	    request.setAttribute("year", year);
	    request.setAttribute("month", month);
	    request.setAttribute("fafang", fafang);
	    List<Employee> employeeList = employeeService.queryAllEmployee();
	    request.setAttribute("employeeList", employeeList);
		return "Salary/salary_frontquery_result"; 
	}

     /*前台查询Salary信息*/
	@RequestMapping(value="/{salaryId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer salaryId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键salaryId获取Salary对象*/
        Salary salary = salaryService.getSalary(salaryId);

        List<Employee> employeeList = employeeService.queryAllEmployee();
        request.setAttribute("employeeList", employeeList);
        request.setAttribute("salary",  salary);
        return "Salary/salary_frontshow";
	}

	/*ajax方式显示工资修改jsp视图页*/
	@RequestMapping(value="/{salaryId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer salaryId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键salaryId获取Salary对象*/
        Salary salary = salaryService.getSalary(salaryId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonSalary = salary.getJsonObject();
		out.println(jsonSalary.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新工资信息*/
	@RequestMapping(value = "/{salaryId}/update", method = RequestMethod.POST)
	public void update(@Validated Salary salary, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			salaryService.updateSalary(salary);
			message = "工资更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "工资更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除工资信息*/
	@RequestMapping(value="/{salaryId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer salaryId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  salaryService.deleteSalary(salaryId);
	            request.setAttribute("message", "工资删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "工资删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条工资记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String salaryIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = salaryService.deleteSalarys(salaryIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出工资信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("employeeObj") Employee employeeObj,String year,String month,String fafang, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(year == null) year = "";
        if(month == null) month = "";
        if(fafang == null) fafang = "";
        List<Salary> salaryList = salaryService.querySalary(employeeObj,year,month,fafang);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Salary信息记录"; 
        String[] headers = { "工资id","员工","工资年份","工资月份","工资金额","是否发放"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<salaryList.size();i++) {
        	Salary salary = salaryList.get(i); 
        	dataset.add(new String[]{salary.getSalaryId() + "",salary.getEmployeeObj().getName(),salary.getYear(),salary.getMonth(),salary.getSalaryMoney() + "",salary.getFafang()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Salary.xls");//filename是下载的xls的名，建议最好用英文 
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
