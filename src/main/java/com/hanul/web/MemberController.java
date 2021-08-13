package com.hanul.web;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import member.MemberServiceImpl;
import member.MemberVO;

@Controller
public class MemberController {
	@Autowired
	private MemberServiceImpl service;


	@ResponseBody
	@RequestMapping(value = "/join", produces = "text/html; charset=utf-8")
	public String join(MemberVO vo, HttpServletRequest request, HttpSession session) {
//회원가입화면에서 입력한 정보를 DB에 저장한 후 
//회원가입축하 메시지창을 띄운다
		StringBuffer msg = new StringBuffer("<script>");
		if (service.member_join(vo)) {

			msg.append("alert('회원가입을 축하합니다^^'); location='").append(request.getContextPath()).append("'");
		} else {
			msg.append("alert('회원가입 실패ㅠㅠ'); location='member'");
		}
		msg.append("</script>");
		return msg.toString();
	}

	// 아이디 중복확인 요청
	@ResponseBody
	@RequestMapping("/id_check")
	public boolean id_check(String id) {
		return service.member_id_check(id);
	}

	@RequestMapping("/member")
	public String member(HttpSession session) {
		session.setAttribute("category", "join");
		return "member/join";
	}

	@ResponseBody
	@RequestMapping("/webLogin")
	public boolean login(String id, String pw, HttpSession session) {
		// 화면에서 전송한 아이디,비밀번호가 일치하는 회원정보를 DB에서 조회해온다
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pw", pw);
		MemberVO vo = service.member_login(map);
		session.setAttribute("loginInfo", vo);
		return vo == null ? false : true;
	}

	@RequestMapping("/list.ou")
	public String logout(HttpSession session) {
		// 세션에 담긴 로그인정보를 삭제한다
		session.removeAttribute("loginInfo");
		return "redirect:/";
	}

	@RequestMapping("/list.lg")
	public String login(HttpSession session) {
		session.setAttribute("category", "lg");
		return "member/login";
	}
}
