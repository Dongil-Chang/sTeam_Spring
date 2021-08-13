package com.hanul.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

	@Controller
public class ReviewController {
		@RequestMapping("/list.re")
		public String list(HttpSession session) {
			session.setAttribute("category", "re");
			return "Review/list";
		}
		
}
