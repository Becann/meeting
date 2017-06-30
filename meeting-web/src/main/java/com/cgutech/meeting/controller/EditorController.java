package com.cgutech.meeting.controller;


import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cgutech.meeting.entity.MeetingMinutes;
import com.cgutech.meeting.entity.User;
import com.cgutech.meeting.model.MeetingModel;
import com.cgutech.meeting.service.MinutesService;
import com.cgutech.meeting.utils.AjaxDone;
import com.cgutech.meeting.utils.JsonUtil;
import com.cgutech.meeting.utils.Page;





@Controller
@RequestMapping("/meet")
public class EditorController {
	@Autowired
	private MinutesService minutesService;
	private Logger log = LoggerFactory.getLogger(EditorController.class);

	@RequestMapping("/edit1")
	public String  edit1(){
				return "editor";

	}
	@RequestMapping("/edit")
	@ResponseBody
	public String  edit(@RequestParam(value = "description") String  content,
			@RequestParam(value = "title") String  title,
			@RequestParam(value = "author") String  author,
			HttpServletRequest request,
			 HttpServletResponse response){	
			log.info("开始提交会议记录："+title);
				AjaxDone ajaxDone=new AjaxDone();
				try {
					minutesService.saveMinutes(content, author, title);
					ajaxDone.setMessage("提交成功");
					
				} catch (Exception e) {
					e.printStackTrace();
					ajaxDone.setMessage("系统错误！");
					ajaxDone.setStatusCode(300);
				}
				return JsonUtil.toJson(ajaxDone);

	}
	
	@RequestMapping("/list")
	public ModelAndView userlist(@RequestParam(value="pageNum",defaultValue="1")String pageNum,
			@RequestParam(value="numPerPage",defaultValue="5")String numPerPage,
			@RequestParam(value="author",defaultValue="")String author,
			@RequestParam(value="title",defaultValue="")String title,
			@RequestParam(value="before",defaultValue="")String before,
			@RequestParam(value="after",defaultValue="")String after,
			@RequestParam(value="key",defaultValue="")String key,
			Model model,HttpServletRequest request,
			HttpServletResponse response) throws ParseException, ServletException, IOException{
		User user=(User)request.getSession().getAttribute("admin");
		if(user.getRole().equals("user")){
			author=user.getName();
		}
		log.info(String.format("pageNum:%s, numPerPage:%s, author:%s, title:%s, before:%s, after:%s, key:%s", pageNum, numPerPage, author, title, before, after, key));
		MeetingMinutes minutes= new MeetingMinutes(title, author,key,null);
		Page page= minutesService.getMeetingsPage(minutes, before, after, Integer.parseInt(pageNum), Integer.parseInt(numPerPage));
		//List<MeetingMinutes> meets=minutesService.getMeetings( minutes,before,after);
		log.info("page:  " + JsonUtil.toJson(page));
		model.addAttribute("meetings",page);
		page=(Page) model.asMap().get("meetings");
		log.info("page:  " + JsonUtil.toJson(page));
		//request.getSession().setAttribute("meetings",page);
		/*List<MeetingModel> models = new ArrayList<>();
		for (MeetingMinutes m : meets) {
			MeetingModel mmodel = new MeetingModel(m.getId().toString(),
					m.getTitle(),m.getAuthor(),
					m.getCtime().substring(0, m.getCtime().length()-2));
			models.add(mmodel);
		}
		String jsonStr = JsonUtil.toJson(models);
		jsonStr=jsonStr.replaceAll("\"id\"", "id")
				.replaceAll("\"title\"", "title")
				.replaceAll("\"author\"", "author")
				.replaceAll("\"ctime\"", "ctime");
		model.addAttribute("meetingJsonStr", jsonStr);*/
		
		return new ModelAndView("manager/meeting/minutes","",null );
	}
	
	@RequestMapping("/preview")
	public String  viewContent(@RequestParam(value = "id") String id,ModelMap model,
			HttpServletRequest request){		
				MeetingMinutes minutes=minutesService.getMinutesByid(Integer.parseInt(id));
				model.addAttribute("minutes",minutes);
				User user=(User)request.getSession().getAttribute("admin");
				if(user.getRole().equals("admin")){
					return "editor";
				}
				return "manager/meeting/preview";

	}
	@RequestMapping("/delete")
	@ResponseBody
	public String deleteupload(
			@RequestParam(value="id",defaultValue="")String id,
			HttpServletRequest request){
		log.info("被删除的id："+id);
		AjaxDone ajaxDone=new AjaxDone();
		try {
			minutesService.delete(id);
			ajaxDone.setMessage("删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			ajaxDone.setStatusCode(300);
			ajaxDone.setMessage("系统错误，请联系管理员");
		}
		
		return JsonUtil.toJson(ajaxDone);
	}
}
