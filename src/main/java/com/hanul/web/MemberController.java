package com.hanul.web;

import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import common.CommonService;
import member.MemberServiceImpl;
import member.MemberVO;

@Controller
public class MemberController {
	@Autowired private MemberServiceImpl service;
	
	private String naver_client_id = "jgGAi1P8OHn33LGZhbsI";
	private String kakao_client_id = "12b60c345c4e4903ef2487f6c3a7e11d";
	

	
	//회원가입처리 요청
	@ResponseBody @RequestMapping(value="/join"
								, produces = "text/html; charset=utf-8")
	public String join(MemberVO vo, HttpServletRequest request
						, HttpSession session) {
		//회원가입화면에서 입력한 정보를 DB에 저장한 후 
		//회원가입축하 메시지창을 띄운다
		StringBuffer msg = new StringBuffer("<script>");
		if( service.member_join(vo) ) {
			
			msg.append( "alert('회원가입을 축하합니다^^'); location='")
			.append( request.getContextPath() )
			.append("'" );
		}else {
			msg.append( "alert('회원가입 실패ㅠㅠ'); location='member'");
		}
		msg.append("</script>");
		return msg.toString();
	}
	//회원가입처리 요청
	@ResponseBody @RequestMapping(value="/s_join"
			, produces = "text/html; charset=utf-8")
	public String s_join(MemberVO vo, HttpServletRequest request
			, HttpSession session) {
		//회원가입화면에서 입력한 정보를 DB에 저장한 후 
		//회원가입축하 메시지창을 띄운다
		StringBuffer msg = new StringBuffer("<script>");
		if( service.member_sjoin(vo) ) {
			
			msg.append( "alert('회원가입을 축하합니다^^'); location='")
			.append( request.getContextPath() )
			.append("'" );
		}else {
			msg.append( "alert('회원가입 실패ㅠㅠ'); location='member'");
		}
		msg.append("</script>");
		return msg.toString();
	}
	
	
	//회원가입화면 요청
	@RequestMapping("/member")
	public String member(HttpSession session) {
		session.setAttribute("category", "join");
		return "member/join";
	}
	
	//회원가입화면 요청
		@RequestMapping("/exmember")
		public String exmember(HttpSession session) {
			session.setAttribute("category", "join");
			return "member/exjoin";
		}
	
	//아이디 중복확인 요청
	@ResponseBody @RequestMapping("/id_check")
	public boolean id_check(String id) {
		return service.member_id_check(id);
	}
	
	//카카오로그인요청
	  @RequestMapping(value="/kakaoLogin")
	    public String kakaoLogin(HttpSession session) {
//	        StringBuffer loginUrl = new StringBuffer();
//	        loginUrl.append("https://kauth.kakao.com/oauth/authorize?client_id=");
//	        loginUrl.append("3a5fc5678034a31a4a50212f089a8cf7"); 
//	        loginUrl.append("&redirect_uri=");
//	        loginUrl.append("http://localhost/web/kakaocallback"); 
//	        loginUrl.append("&response_type=code");
			String state = UUID.randomUUID().toString();
			session.setAttribute("state", state);
			
	        StringBuffer url = new StringBuffer(
	        		"https://kauth.kakao.com/oauth/authorize?response_type=code");
	        url.append("&client_id=").append("	12b60c345c4e4903ef2487f6c3a7e11d");
	        url.append("&redirect_uri=http://localhost/web/kakaocallback");
	        url.append("&state=").append(state);
	        
//	        return "redirect:"+loginUrl.toString();
	        return "redirect:"+url.toString();
	    }
	
	  
	  
	  @RequestMapping("/kakaocallback")
		public String kakaocallback(@RequestParam(required = false) String code
				, String state, HttpSession session
									, @RequestParam(required = false) String error) {
			if ( !state.equals( session.getAttribute("state") ) || error!=null ) {
				return "redirect:/";
			}
			
			StringBuffer url = new StringBuffer(
				"https://kauth.kakao.com/oauth/token?grant_type=authorization_code");
			url.append("&client_id=").append(kakao_client_id);
			//url.append("&client_secret=FZn2ljqDGsK4MyRotzIhV8kd169VMWom");
			url.append("&code=").append(code);
			url.append("&state=").append(state);
			
			
			JSONObject json = new JSONObject( common.requestAPI(url) );
			String token = json.getString("access_token");
			String type = json.getString("token_type");
			
			url = new StringBuffer("https://kapi.kakao.com/v2/user/me");
			json = new JSONObject( common.requestAPI(url, type + " " + token) );
			
			JSONObject top = json;
			
			MemberVO vo = new MemberVO();
			vo.setSocial_type("kakao");
			vo.setId( json.get("id").toString() );
			
			json = json.getJSONObject("kakao_account");
			vo.setSocial_email( json.has("email") ? json.getString("email") : "");
			vo.setGender( json.has("gender") && json.getString("gender").equals("female") ? "여" : "남" );
			json = json.getJSONObject("profile");
			vo.setName( json.getString("nickname") );
			
			if( service.member_social_email(vo) )
				service.member_social_update(vo);
			else 
				service.member_social_insert(vo);
			
			session.setAttribute("loginInfo", vo);
			
			return "redirect:/";
		}
	  	
	
	
	//네이버로그인요청
	@RequestMapping("/naverLogin")
	public String naverLogin(HttpSession session) {
		
		//세션상태 토큰으로 사용할 문자열 생성
		String state = UUID.randomUUID().toString();
		session.setAttribute("state", state);
		
		StringBuffer url = new StringBuffer(
				"https://nid.naver.com/oauth2.0/authorize?response_type=code");
		url.append("&client_id=").append(naver_client_id);
		url.append("&state=").append(state);
		url.append("&redirect_uri=http://localhost/web/navercallback");
		
		return "redirect:" + url.toString();
	}
	
	@RequestMapping("/navercallback")
	public String navercallback(@RequestParam(required = false) String code
								, String state, HttpSession session
								, @RequestParam(required = false) String error) {
		if( !state.equals( session.getAttribute("state") ) || error!=null ) {
			return "redirect:/";
		}
		
		StringBuffer url = new StringBuffer(
			"https://nid.naver.com/oauth2.0/token?grant_type=authorization_code");
		url.append("&client_id=").append(naver_client_id);
		url.append("&client_secret=UOYBSMvgNB");
		url.append("&code=").append(code);
		url.append("&state=").append(state);

		JSONObject json = new JSONObject( common.requestAPI(url) );
		String token = json.getString("access_token");
		String type = json.getString("token_type");
		
		url = new StringBuffer("https://openapi.naver.com/v1/nid/me");
		json = new JSONObject( common.requestAPI(url, type + " " + token) );
		if( json.getString("resultcode").equals("00") ) {
			json = json.getJSONObject("response");
			
			MemberVO vo = new MemberVO();
			vo.setSocial_type("naver");
			vo.setId( json.getString("id") );
			vo.setSocial_email( json.getString("email") );
			vo.setName( json.getString("name") );
			vo.setGender( json.has("gender") && json.getString("gender").equals("F") ? "여" : "남" );
			
			if( service.member_social_email(vo) )
				service.member_social_update(vo);
			else 
				service.member_social_insert(vo);
			
			session.setAttribute("loginInfo", vo);
		}
		
		return "redirect:/";
	}
	
	@Autowired private CommonService common;
	
	//로그아웃처리 요청
	@RequestMapping("/list.ou")
	public String logout(HttpSession session) {
		// 세션에 담긴 로그인정보를 삭제한다
		session.removeAttribute("loginInfo");
		return "redirect:/";
	}
	
	//로그인처리 요청
	@ResponseBody @RequestMapping("/webLogin")
	public boolean login(String id, String pw, HttpSession session) {
		//화면에서 전송한 아이디,비밀번호가 일치하는 회원정보를 DB에서 조회해온다
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pw", pw);
		MemberVO vo = service.member_login(map);
		session.setAttribute("loginInfo", vo);
		return vo==null ? false : true;
	}
	
	//로그인화면 요청
	@RequestMapping("/list.lg")
	public String login(HttpSession session) {
		session.setAttribute("category", "login");
		return "member/login";
	}
	
	@RequestMapping("/login.ml")
	public String mlogin(HttpSession session) {
		session.setAttribute("category", "login");
		return "member/memberLogin";
	}
	@RequestMapping("/login.el")
	public String elogin(HttpSession session) {
		session.setAttribute("category", "login");
		return "member/exlogin";
	}
	
}
