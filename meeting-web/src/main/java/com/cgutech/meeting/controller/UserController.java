package com.cgutech.meeting.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cgutech.meeting.entity.User;
import com.cgutech.meeting.service.UserService;
import com.cgutech.meeting.utils.AjaxDone;
import com.cgutech.meeting.utils.JsonUtil;
import com.cgutech.meeting.utils.Page;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	private Logger log= LoggerFactory.getLogger(UserController.class);
		@RequestMapping(value="/list")
		public String userlist(@RequestParam(value="pageNum",defaultValue="1")String pageNum,
				@RequestParam(value="numPerPage",defaultValue="10")String numPerPage,
				@RequestParam(value="user",defaultValue="")String user,
				Model model){
			if("".equals(user)||user==null||user.isEmpty()){
				user=null;
			}
			//Page page=userService.getUsersPage(user, Integer.parseInt(pageNum), Integer.parseInt(numPerPage));
			List<User> users =userService.getUsers(user);
			model.addAttribute("userlist",users);
			return "manager/user/users";
		}
		@RequestMapping("/register")
		public String  register(@RequestParam("name")String name,
				@RequestParam("role")String role,
				@RequestParam("newpassword")String pass,
				Model model,
				HttpServletRequest request) {
			if(userService.getUser(name)!=null){
				model.addAttribute("message","用户"+name+"已经存在！");
				log.info("用户名"+name+" 已经存在！");
				return "register";
			}
			User userEntity=new User();
			userEntity.setName(name);
			userEntity.setPswd(pass);
			userEntity.setRole(role);
			try {
				userService.createUser(userEntity);
				model.addAttribute("message","注册成功");
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				return "500";
			}
			return "/manager/Success";
		}
		@RequestMapping("/adduser")
		@ResponseBody
		public String  addUser(@RequestParam("name")String name,
				@RequestParam("role")String role,
				@RequestParam("password")String pass,
				Model model,
				HttpServletRequest request,
				HttpServletResponse response) {
			if(userService.getUser(name)!=null){
				model.addAttribute("message","用户"+name+"已经存在！");
				log.info("用户名"+name+" 已经存在！");
				//response.setStatus(400);
				return "{\"message\":\"用户名已经存在\",\"code\":\"400\"}";
			}
			User userEntity=new User();
			userEntity.setName(name);
			userEntity.setPswd(pass);
			userEntity.setRole(role);
			try {
				userService.createUser(userEntity);
				model.addAttribute("message","添加成功");
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				//response.setStatus(500);
				return "{\"message\":\"服务器挂啦，找管理员看看\",\"code\":\"500\"}";
			}
			return "{\"message\":\"添加成功\",\"code\":\"200\"}";
		}
		/*@RequestMapping("/change")
		public String change(@RequestParam("user")String name,Model model){
			User userEntity=userService.getUser(name);
			model.addAttribute("id", userEntity.getId());
			model.addAttribute("user",name);
			model.addAttribute("role",userEntity.getRole());
			return "manager/user/changestatus";
		}
		
		@RequestMapping("/changestatus")
		public String changeStatus(@RequestParam("user")String name,
				@RequestParam("status")String status,
				@RequestParam("role")String role,
				HttpServletRequest request){
			AjaxDone ajaxDone = new AjaxDone();
			try {
				userService.updateUser(name, role, status);
				ajaxDone.setMessage("修改成功");
				ajaxDone.setCallbackType("closeCurrent");
			} catch (Exception e) {
				e.printStackTrace();
				ajaxDone.setStatusCode(300);
				ajaxDone.setMessage("system error");
			}
			ajaxDone.setNavTabId("cguUser");
			request.setAttribute("ajaxDone", ajaxDone);
			return "ajaxDone";
		}
		*/
		@RequestMapping("/delete")
		@ResponseBody
		public String deleteUser(@RequestParam("id")String id,
				HttpServletRequest request){
			AjaxDone ajaxDone = new AjaxDone();
			try {
				userService.deleteUser(Integer.parseInt(id));
				ajaxDone.setMessage("删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				ajaxDone.setStatusCode(300);
				ajaxDone.setMessage("系统错误，请联系管理员");
			}
			return JsonUtil.toJson(ajaxDone);
		}
		
		
}

