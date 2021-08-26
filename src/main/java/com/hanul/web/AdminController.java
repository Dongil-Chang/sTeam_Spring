package com.hanul.web;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import admin.CoPage;
import admin.AdminPage;
import admin.AdminServiceImpl;
import admin.QnaPage;
import board.BoardPage;
import member.MemberVO;
import review.ReviewPage;
import style.StylePage;

@Controller
public class AdminController {
	
	@Autowired private AdminServiceImpl service;
	@Autowired private AdminPage page;
	@Autowired private QnaPage q_page;
	@Autowired private BoardPage b_page;
	@Autowired private ReviewPage r_page;
	@Autowired private StylePage s_page;
	 
	boolean count = true;
	
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	
	// 회원관리 목록화면 요청
	@RequestMapping("/list.cu")
	public String list(HttpSession session, Model model, String admin, String search, 
						String keyword, @RequestParam(defaultValue = "1") int curPage) {
		
		/*
		 * // 셀렉트 박스에서 선택된 value값을 저장 model.addAttribute("admin", admin);
		 * 
		 * // 회원정보 테이블에서 admin 정보 가져오기 model.addAttribute("admins",
		 * service.customer_admin());
		 * 
		 * 
		 * if (admin == null || admin.equals("all")) { // DB에서 회원목록을 조회해와서 JSP 화면에 출력
		 * session.setAttribute("category", "cu"); model.addAttribute("list",
		 * service.customer_list() ); } else { model.addAttribute("list",
		 * service.customer_list(admin) ); }
		 */
		
//		SearchVO vo = new SearchVO();
		
		session.setAttribute("category", "cu");
		
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		
		
		model.addAttribute("page", service.customer_list(page));
		
		count = true;
		return "admin/list";
	}
	
	
	
	
	// 회원정보 삭제처리 요청
	@RequestMapping("/delete.cu")
	public String delete(String id, int curPage, Model model) {
		// 해당 회원정보를 DB에서 삭제한 후 목록화면으로 연결
		service.customer_delete(id);
		
		
		return "redirect:list.cu?curPage=" + curPage;
	}
	
	
	
	
	// 해당 회원이 작성한 qna 글 목록 보기
	@RequestMapping("/qna_list.cu")
	public String qna_list(String name, String id, Model model, @RequestParam(defaultValue = "1") int curPage,
							 String search, String keyword) {
		
		
		
		
		if (count) {
			page.setKeyword(keyword);
			count = false;
			keyword = "";
		}
		
		
		
		// 페이징 처리 된 해당 회원이 작성한 QnA 글 목록 보기
		q_page.setCurPage(curPage);
		q_page.setSearch(search);
		q_page.setKeyword(keyword);
		
		
		map.put("q_page", q_page);
		map.put("id", id);
		
		model.addAttribute("page", page);
		model.addAttribute("QnaPage", service.qna_list(map));
		model.addAttribute("name", name);
		model.addAttribute("id", id);
		return "admin/qna_list";
	}
	
	
	
	
	
	 // 해당 회원이 작성한 커뮤니티 글 목록 보기
	 @RequestMapping("/co_list.cu") 
	 public String co_list(HttpSession session,String name, String id, Model model
						, @RequestParam(defaultValue = "1") int curPage, String search
						, @RequestParam(defaultValue = "10") int pageList
						, @RequestParam(defaultValue = "list") String viewType
																,String keyword) {
	  
		 session.setAttribute("category", "cu");
		 
		 if (count) { 
			 page.setKeyword(keyword); 
			 count = false; 
			 keyword = ""; 
		 }
	  
	  
		 // 페이징 처리 된 해당 회원이 작성한 커뮤니티 글 목록 보기
		 b_page.setCurPage(curPage);
		 b_page.setSearch(search);
		 b_page.setKeyword(keyword);
		 b_page.setPageList(pageList);
		 b_page.setViewType(viewType);
		  
		  
		 map.put("b_page", b_page); 
		 map.put("id", id);
		  
		 model.addAttribute("page", page); 
		 model.addAttribute("CoPage", service.community_list(map) ); 
		 model.addAttribute("name", name);
		 model.addAttribute("u_id", id);
		 
		 return "admin/co_list";
	 }
	 
	
	
	
	 
	// 해당 회원이 작성한 리뷰 글 목록 보기
	 @RequestMapping("/re_list.cu") 
	 public String re_list(String name, String id, Model model
					, @RequestParam(defaultValue = "1") int curPage, String search
					, @RequestParam(defaultValue = "10") int pageList
					, @RequestParam(defaultValue = "list") String viewType
															,String keyword) {
	  
		 if (count) { 
			 page.setKeyword(keyword); 
			 count = false; 
			 keyword = ""; 
		 }
	  
	  
		 // 페이징 처리 된 해당 회원이 작성한 리뷰 글 목록 보기
		 r_page.setCurPage(curPage);
		 r_page.setSearch(search);
		 r_page.setKeyword(keyword);
		 r_page.setPageList(pageList);
		 r_page.setViewType(viewType);
		  
		  
		 map.put("r_page", r_page); 
		 map.put("id", id);
		  
		 model.addAttribute("page", page); 
		 model.addAttribute("RePage", service.review_list(map) ); 
		 model.addAttribute("name", name);
		 model.addAttribute("u_id", id);
		 
		 return "admin/re_list";
	 }
	 
	 
	
	
	
	
	// 해당 회원이 작성한 커뮤니티 글 목록 보기
		 @RequestMapping("/st_list.cu") 
		 public String st_list(String name, String id, Model model
	 						, @RequestParam(defaultValue = "1") int curPage, String search
	 						, @RequestParam(defaultValue = "10") int pageList
							, @RequestParam(defaultValue = "list") String viewType
																	,String keyword) {
		  
			 if (count) { 
				 page.setKeyword(keyword); 
				 count = false; 
				 keyword = ""; 
			 }
		  
		  
			 // 페이징 처리 된 해당 회원이 작성한 커뮤니티 글 목록 보기
			 s_page.setCurPage(curPage);
			 s_page.setSearch(search);
			 s_page.setKeyword(keyword);
			 s_page.setPageList(pageList);
			 s_page.setViewType(viewType);
			  
			  
			 map.put("s_page", s_page); 
			 map.put("id", id);
			  
			 model.addAttribute("page", page); 
			 model.addAttribute("StPage", service.style_list(map) ); 
			 model.addAttribute("name", name);
			 model.addAttribute("u_id", id);
			 
			 return "admin/st_list";
		 }
	 
	 
	 
	 
	 
	 
	
	
	
}  // class
