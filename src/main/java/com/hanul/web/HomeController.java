package com.hanul.web;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import board.BoardServiceImpl;
import notice.NoticeServiceImpl;
import review.ReviewServiceImpl;
import review.ReviewVO;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired private BoardServiceImpl b_service;
	@Autowired private NoticeServiceImpl n_service;
	@Autowired private ReviewServiceImpl r_service;
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		//session.setAttribute("category", "");
		session.removeAttribute("category");
		return "home";
	}
	
	
	
// home.jsp 메인 화면에서 사용할 부분을 처리하는 영역	
	
	@RequestMapping("/mainNotice.ad")
	public String mainNotice(Model model) {
		
		
		model.addAttribute("curPage", 1);	
		model.addAttribute("ad_list", n_service.Main_notice_list() );
		return "notice/home/recently";
	}
	
	
	@RequestMapping("/mainCommu.ad")
	public String mainCommu(Model model) {
		
		model.addAttribute("curPage", 1);	
		model.addAttribute("ad_list", b_service.main_board_list());
		return "board/home/recently";
	}
	
	
	
	@RequestMapping("/mainReview.ad")
	public String mainReview(Model model) {
		// git test
		model.addAttribute("curPage", 1);	
		model.addAttribute("ad_list", r_service.main_review_list());
		return "review/home/recently";
	}
	
	
	
// home.jsp 메인 화면에서 사용할 부분을 처리하는 영역	
	
	
	
	
	
	
	
	
}  // controller
