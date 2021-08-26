package com.hanul.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorController {
	
	
	
	// 페이지 오류 처리
	@RequestMapping("/error")
	public String error(Model model, HttpSession session, HttpServletRequest request) {
		session.setAttribute("category", "error");
		
		// 어떤 에러 메세지인지 알기 위해
		Throwable error = (Throwable) request.getAttribute("javax.servlet.error.exception");
		
		StringBuffer msg = new StringBuffer();
		while( error != null ) {
			msg.append("<p>").append( error.getMessage() ).append("</p>");
			error = error.getCause();
		}
		
		model.addAttribute("msg", msg.toString());
		
		// 어떤 에러코드인지 알기위해
		int code = (Integer)request.getAttribute("javax.servlet.error.status_code");
		
		return "error/" + ( code == 404 ? 404 : "common" );
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
