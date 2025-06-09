package com.spring.springProject3.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level0Interceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 3 : (int) session.getAttribute("sLevel");
		
		String viewPage = "";
		// 0:관리자, 1:사업자회원, 2:일반회원
		if(level > 2) {
			viewPage = "/message/loginRequired";
			request.getRequestDispatcher(viewPage).forward(request, response);
			return false;
		}
		else if(level != 0) {
			viewPage = "/message/levelError0";
			request.getRequestDispatcher(viewPage).forward(request, response);
			return false;
		}
		return true;
	}
	
}
