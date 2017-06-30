package com.cgutech.meeting.controller;

import java.io.UnsupportedEncodingException;
import java.net.UnknownHostException;
import java.util.Base64;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cgutech.meeting.entity.User;
import com.cgutech.meeting.service.UserService;
import com.cgutech.meeting.utils.AjaxDone;
import com.cgutech.meeting.utils.HttpUtil;
import com.cgutech.meeting.utils.IPUtil;
import com.cgutech.meeting.utils.MD5;
import com.cgutech.meeting.utils.Page;
import com.cgutech.meeting.utils.ReadProperties;

@Controller
@RequestMapping("/admin")
public class LoginController {
	@Autowired
	private UserService userService;


	private Logger log = LoggerFactory.getLogger(LoginController.class);


	@RequestMapping("/login")
	public String login(@RequestParam(value = "username", defaultValue = "") String name,
			@RequestParam(value = "password", defaultValue = "") String password,
			 Model model, HttpServletRequest request)
			throws UnknownHostException {
		
		if(password != null && !password.isEmpty())
			password = MD5.encode(password);
		
		Page page = userService.getUsersPage(null,0,1);
		if (page.getList() == null || page.getList().size() == 0) {
			User user = new User();
			user.setName("admin");
			user.setPswd("admin");
			user.setRole("admin");
			userService.createUser(user);
			log.info("已创建用户admin，密码为admin");
			request.setAttribute("message", "已创建用户admin，密码为admin");
			return "login";
		}
		String userip = IPUtil.getIpAddress(request);
		log.info("客户端ip" + userip);
		User userEntity = userService.getUser(name);
		if (name == null || name.isEmpty() || password == null || password.isEmpty()) {
			request.setAttribute("message", "账号密码不能为空");
		} else {
			if (userEntity == null || !userEntity.getPswd().equals(password)) {
				request.setAttribute("message", "用户名或密码错误，请重新输入");
			} else {
					request.getSession().setAttribute("admin", userEntity);
					model.addAttribute("admin", userEntity);
					return "manager/admin";
			}
		}
		return "login";
	}
	
	@RequestMapping(value = "/change", method = RequestMethod.POST)
	public String changeAdminPass(
			@RequestParam("newpassword") String newpassword, @RequestParam("adminname") String adminname,
			HttpServletRequest request) {
		AjaxDone ajaxDone= new AjaxDone();
		String pass = userService.getPassword(adminname);
		if (pass.equals("")) {
			 ajaxDone.setStatusCode(300);
			 ajaxDone.setMessage("用户不存在");
		}  else {
			log.info("开始修改用户" + adminname + "的密码");
			userService.changePassword(adminname, newpassword);
			ajaxDone.setMessage("success");		
		}
		request.setAttribute("ajaxDone", ajaxDone);
		return "manager/adminchangepwd";
	}

	/**
	 * 用户注销
	 * 
	 * @return
	 */
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request) {
		if (null != request.getSession().getAttribute("admin")) {
			log.info("用户" + ((User)request.getSession().getAttribute("admin")).getName() + "已退出");
			request.getSession().invalidate();
		}
		return "login";
	}
	
	
	@RequestMapping(value = "/ddpush")
	@ResponseBody
	public String  ddpush(@RequestParam("name")String ddname,HttpServletRequest request) {
		String text = "";
		Random random= new Random();
		for(int i=0;i<4;i++){
			text=text+random.nextInt(10);
		}
		String code=text;
		try {
			text=Base64.getUrlEncoder().encodeToString(text.getBytes("UTF8"));
			log.info("钉钉推送服务url："+ReadProperties.read("dd_push_server")+"?text="+text+"&dname="+ddname);
			String res=HttpUtil.doGet(ReadProperties.read("dd_push_server")+"?text="+text+"&dname="+ddname);
			log.info("钉钉推送结果："+res);
			if(res.startsWith("success")){
				return "{\"message\":\"success\",\"code\":\""+code+"\"}";
			}
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "{\"message\":\"system error\"}";
		}
		return "{\"message\":\"系统生成动态码失败，请联系管理员\"}";
	}
	static class Test{
		public static void main(String[] args) throws UnsupportedEncodingException {
			System.out.println(Base64.getUrlEncoder().encodeToString("1234".getBytes("UTF8")));
		}
	}
	
}

