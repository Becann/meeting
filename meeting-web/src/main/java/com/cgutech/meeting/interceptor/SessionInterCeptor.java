package com.cgutech.meeting.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class SessionInterCeptor implements HandlerInterceptor{
	private List<String> allowPaths;
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		if(request.getSession().getAttribute("admin")!=null){
			return true;
		}
		for (String path : allowPaths) {
			if(request.getRequestURI().endsWith(path)){
				return true;
			}
		}
		response.sendRedirect(request.getContextPath() + "/views/login.jsp");
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
		
	}

	public List<String> getAllowPaths() {
		return allowPaths;
	}

	public void setAllowPaths(List<String> allowPaths) {
		this.allowPaths = allowPaths;
	}


}

