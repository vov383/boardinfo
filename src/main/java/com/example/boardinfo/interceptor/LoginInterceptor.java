package com.example.boardinfo.interceptor;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session=request.getSession();
		//세션이 없으면
		if(session.getAttribute("userid")==null && session.getAttribute("admin_id")==null) {
			if(isAjaxRequest(request)){
				response.sendError(999);
				return false;
			}
			else{
				response.sendRedirect(request.getContextPath()+"/member/member_login.do?message=nologin");
				return false; //메인 액션으로 가지 않음
			}

		}else {//정상로그인하면
			return true; //메인 액션으로 이동
		}
	}

	private boolean isAjaxRequest(HttpServletRequest req) {
		String header = req.getHeader("x-requested-with");
		if ("XMLHttpRequest".equals(header)){
			return true;
		}else{
			return false;
		}
	}
	
	//메인 액션이 실행된 후
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
	
}
