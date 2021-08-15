package com.hanul.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import customer.CustomerServiceImpl;

@Controller
public class CustomerController {
	
	@Autowired private CustomerServiceImpl service;
	
	// 회원관리 목록화면 요청
	@RequestMapping("/list.cu")
	public String list(HttpSession session, Model model, String admin) {
		
		// 셀렉트 박스에서 선택된 value값을 저장
		model.addAttribute("admin", admin);
		
		// 회원정보 테이블에서 admin 정보 가져오기
		model.addAttribute("admins", service.customer_admin());
		
		
		if (admin == null || admin.equals("all")) {
			// DB에서 회원목록을 조회해와서 JSP 화면에 출력
			session.setAttribute("category", "cu");
			model.addAttribute("list", service.customer_list() );
		} else {
			model.addAttribute("list", service.customer_list(admin) );
		}
		
		
		
		
		return "customer/list";
	}
	
	
	
	
	// 회원정보 삭제처리 요청
	@RequestMapping("/delete.cu")
	public String delete(String id) {
		// 해당 회원정보를 DB에서 삭제한 후 목록화면으로 연결
		service.customer_delete(id);
		
		return "redirect:list.cu";
	}
	
	
	
	
	
	
	

	
	
	
	
}  // class
