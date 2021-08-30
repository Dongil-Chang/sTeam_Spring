package com.hanul.web;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import board.BoardPage;
import board.BoardServiceImpl;
import member.MemberService;
import member.MemberServiceImpl;
import member.MemberVO;
import qna.Q_QnaPage;
import qna.QnaServiceImpl;
import review.ReviewPage;
import review.ReviewServiceImpl;
import style.StylePage;
import style.StyleServiceImpl;

@Controller
public class MypageController {
	
	@Autowired private	MemberServiceImpl service;
	@Autowired private BoardServiceImpl mc_service;
	@Autowired private BoardPage b_page;
	@Autowired private ReviewServiceImpl mr_service;
	@Autowired private ReviewPage r_page;
	@Autowired private QnaServiceImpl mq_service;
	@Autowired private Q_QnaPage q_page;
	
	@Autowired private StyleServiceImpl ms_service;
	@Autowired private StylePage s_page;
	/*
	 * @RequestMapping("/modify.mp") public String modify(Model model, String id) {
	 * //화면의 해당 고객정보를 조회해와 수정화면에 출력 model.addAttribute("vo",
	 * service.member_detail(id)); return "Mypage/modify"; }*/
	  
	 
	//마이페이지
	@RequestMapping("/list.mp")
	public String login(HttpSession session) {
		session.setAttribute("category", "mp");
		return "Mypage/list" 
		+ ( ((MemberVO)session.getAttribute("loginInfo")).getAdmin().equals("S") ? "_s" : "" );
	}
	
	
	@RequestMapping("/mslist.mp")
	public String msl(HttpSession session, String id, Model model, @RequestParam(defaultValue = "1") int curPage) {
		session.setAttribute("category", "mp");
		HashMap<String, Object> map = new HashMap<String, Object>();
		s_page.setCurPage(curPage);
		map.put("s_page", s_page);
		map.put("id", id);
				
		model.addAttribute("page", ms_service.style_ms_list(map));
		return "Style/list";
	}
	
	@RequestMapping("/mqlist.mp")
	public String mql(HttpSession session, String id, Model model, @RequestParam(defaultValue = "1") int curPage) {
		session.setAttribute("category", "mp");
		HashMap<String, Object> map = new HashMap<String, Object>();
		q_page.setCurPage(curPage);
		map.put("q_page", q_page);
		map.put("id", id);
				
		model.addAttribute("page", mq_service.qna_mq_list(map));
		return "qna/list";
	}

	/*
	 * @RequestMapping("/mclist.mp") public String mcl(HttpSession session) {
	 * session.setAttribute("category", "mp"); return "Mypage/mcList"; }
	 */
	@RequestMapping("/mclist.mp")
	public String mcl(HttpSession session, String id, Model model, @RequestParam(defaultValue = "1") int curPage) {
		session.setAttribute("category", "mp");
		HashMap<String, Object> map = new HashMap<String, Object>();
		b_page.setCurPage(curPage);
		map.put("b_page", b_page);
		map.put("id", id);
				
		model.addAttribute("page", mc_service.board_mc_list(map));
		return "board/list";
	}
	
	@RequestMapping("/mrlist.mp")
	public String mrl(HttpSession session, String id, Model model, @RequestParam(defaultValue = "1") int curPage) {
		session.setAttribute("category", "mp");
		HashMap<String, Object> map = new HashMap<String, Object>();
		r_page.setCurPage(curPage);
		map.put("r_page", r_page);
		map.put("id", id);
				
		model.addAttribute("page", mr_service.review_mr_list(map));
		return "review/list";
	}
	
	@RequestMapping("/delete.mp")
	public String delete(String id, HttpSession session) {
		// 해당 회원정보를 DB에서 삭제한 후 목록화면으로 연결
		service.member_delete( ((MemberVO)session.getAttribute("loginInfo")).getId() );
		session.removeAttribute("loginInfo");
		return "redirect:/";
	}

	@RequestMapping("/detail.mp")
	public String detail(HttpSession session, Model
			model) {
		session.setAttribute("category", "mp");
		model.addAttribute("vo",service.member_detail( ((MemberVO)session.getAttribute("loginInfo")).getId()  ));
		
		return "Mypage/detail" 
			+ ( ((MemberVO)session.getAttribute("loginInfo")).getAdmin().equals("S") ? "_s" : "" );
	}
	
	@RequestMapping("/modify.mp")
	public String modify(String id, Model model, HttpSession session) {
		//해당 글의 정보를 DB에서 조회해와 수정화면 출력
		session.setAttribute("category", "mp");
		model.addAttribute("vo", service.member_detail(id));
		return "Mypage/modify";
	}
	
	@RequestMapping("/update.mp")
	public String update(String id, Model model, MemberVO vo, HttpSession session) {
		MemberVO member = service.member_detail(vo.getId());
		
		//화면에서 수정한 정보들을 DB에서 저장한 상세화면 연결
		service.member_update(vo);
		
		model.addAttribute("uri", "detail.mp");
		model.addAttribute("id", vo.getId());
		return "Mypage/redirect";

		}
	
		
	/*	@RequestMapping("/mclist.mp") public String write_list(String name,
		  String id, Model model, @RequestParam(defaultValue = "1") int curPage ,
		 String search, String keyword) {
		  
		  
		  // 페이징 처리 된 해당 회원이 작성한 QnA 글 목록 보기 b_page.setCurPage(curPage);
		  b_page.setSearch(search); b_page.setKeyword(keyword);
		  
		  HashMap<String, Object> map = new HashMap<String, Object>();
		  map.put("b_page", b_page); map.put("id", id);
		  
		  model.addAttribute("BoardPage", service.list(map));
		  model.addAttribute("name", name); return "Board/list"; } */
		 
}
