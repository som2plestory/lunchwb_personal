package com.lunchwb.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.lunchwb.service.UserService;
import com.lunchwb.vo.UserVo;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	UserService userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("authUser");
		System.out.println("obj = " + obj);
		if ( obj == null) {
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			System.out.println("loginCookie = " + loginCookie);
			if(loginCookie != null) {
				String sessionId = loginCookie.getValue();
				UserVo userVo = userService.selectSession(sessionId);
				
				System.out.println("userVo = " + userVo);
				if(userVo != null) {
					session.setAttribute("authUser", userVo);
					return true;
				}
			}
			
			response.sendRedirect("../login");
			return false;
		}
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}

	

}
