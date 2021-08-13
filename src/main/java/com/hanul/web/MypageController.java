package com.hanul.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MypageController {
	
	@RequestMapping("/list.mp")
	public String login(HttpSession session) {
		session.setAttribute("category", "mp");
		return "Mypage/list";
	}

}
