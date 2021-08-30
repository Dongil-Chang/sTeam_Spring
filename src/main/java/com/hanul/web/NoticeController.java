package com.hanul.web;

import java.io.File;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import common.CommonService;
import member.MemberServiceImpl;
import member.MemberVO;
import notice.NoticePage;
import notice.NoticeServiceImpl;
import notice.NoticeVO;

@Controller
public class NoticeController {
	
	@Autowired private NoticeServiceImpl service;
	@Autowired private CommonService common;
	
	//공지글 수정저장처리 요청
	@RequestMapping("/update.no")
	public String update(NoticeVO vo, String attach
						, MultipartFile file, HttpSession session) {
		NoticeVO notice = service.notice_detail(vo.getId());
		String uuid = session.getServletContext().getRealPath("resources")
						+ "/" + notice.getFilepath();
		
		//첨부파일이 있는 경우
		if( ! file.isEmpty() ) {
			vo.setFilename( file.getOriginalFilename() );
			vo.setFilepath( common.fileUpload("notice", file, session));
			
			//원래 첨부된 파일이 있었다면 물리적인 디스크에서 해당 파일삭제
			if( notice.getFilename() !=null ) {
				File f = new File( uuid );
				if( f.exists() ) f.delete();
			}
		}else {
		//첨부파일이 없는 경우
			//원래 첨부된 파일을 삭제하는 경우
			if( attach.isEmpty() ) {
				if( notice.getFilename()!=null ) {
					File f = new File( uuid );
					if( f.exists() ) f.delete();
				}
				
			}else {
			//원래 첨부된 파일을 그대로 사용하는 경우
				vo.setFilename( notice.getFilename() );
				vo.setFilepath( notice.getFilepath() );
			}
		}
		
		//화면에서 변경입력한 정보를 DB에 변경저장한 후 상세화면으로 연결
		service.notice_update(vo);
		return "redirect:detail.no?id=" + vo.getId();
	}
	
	
	
	//공지글 수정화면 요청
	@RequestMapping("/modify.no")
	public String modify(int id, Model model) {
		//해당 공지글정보를 DB에서 조회해와 수정화면에 출력
		model.addAttribute("vo", service.notice_detail(id));
		return "notice/modify";
	}
	
	//공지글 삭제처리 요청
	@RequestMapping("/delete.no")
	public String delete(int id, HttpSession session) {
		//첨부파일이 있는 글의 경우 디스크에서 첨부파일을 삭제한다
		NoticeVO notice = service.notice_detail(id);
		String uuid =  session.getServletContext().getRealPath("resources") 
						+ "/" + notice.getFilepath();
		if( notice.getFilename()!=null ) {
			File file = new File(uuid);
			if( file.exists() ) file.delete();
		}
		
		//해당 공지글 정보를 DB에서 삭제한 후 목록화면으로 연결
		service.notice_delete(id);
		return "redirect:list.no";
	}
	
	
	//공지글의 첨부파일 다운로드 요청
	@RequestMapping("/download.no")
	public void download(int id, HttpSession session, HttpServletResponse response) {
		//해당 공지글의 첨부파일 정보를 DB에서 조회해와 
		//해당 파일을 서버로부터 다운로드한다 
		NoticeVO notice = service.notice_detail(id);
		common.fileDownload(notice.getFilename(), notice.getFilepath()
								, session, response);
	}
	
	
	//공지사항 상세화면 요청
	@RequestMapping("/detail.no")
	public String detail(int id, Model model, @RequestParam(required = false ) Integer curPage) {
//	public String detail(int id, Model model, @RequestParam(defaultValue = "0" ) int curPage) {
		service.notice_read(id); //조회수 증가시키기
		//선택한 공지사항 정보를 DB에서 조회해 와 상세화면에 출력
//		if(curPage==1) page.setCurPage(1); //홈에서 클릭한 경우
		if(curPage!=null) page.setCurPage(curPage); //홈에서 클릭한 경우
		
		model.addAttribute("vo", service.notice_detail(id));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("page", page);
		return "notice/detail";
	}
	
	
/*	// 메인화면에서 공지사항 상세화면 요청
	@RequestMapping("/a_detail.no")
	public String a_detail(int id, Model model, int curPage) {
		service.notice_read(id); //조회수 증가시키기
		//선택한 공지사항 정보를 DB에서 조회해 와 상세화면에 출력
		
		page.setCurPage(curPage);
		
		model.addAttribute("vo", service.notice_detail(id));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("page", page);
		return "notice/detail";
	} */
	
	
	
	
	//신규공지사항 저장처리 요청
	@RequestMapping("/insert.no")
	public String insert(NoticeVO vo, MultipartFile file
						, HttpSession session) {
//		MemberVO member = (MemberVO)session.getAttribute("loginInfo");
//		vo.setWriter( member.getId() );
		vo.setWriter( ((MemberVO)session.getAttribute("loginInfo")).getId() );
		if( ! file.isEmpty() ) {
			vo.setFilename( file.getOriginalFilename() );
			vo.setFilepath( common.fileUpload("notice", file, session) );
		}
		
		//화면에서 입력한 정보를 DB에 저장한 후 화면으로 연결
		service.notice_insert(vo);
		return "redirect:list.no";
	}
	
	
	//신규공지사항 입력화면 요청
	@RequestMapping("/new.no")
	public String notice() {
		return "notice/new";
	}
	
	@Autowired private MemberServiceImpl member;
	@Autowired private NoticePage page;
	
	//답글저장처리 요청
	@RequestMapping("/reply_insert.no")
	public String reply_insert(NoticeVO vo, MultipartFile file, HttpSession session) {
		if( ! file.isEmpty() ) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath( common.fileUpload("notice", file, session) );
		}
		vo.setWriter( ((MemberVO)session.getAttribute("loginInfo")).getId() );
		
		//화면에서 입력한 답글정보를 DB에 저장한 후 목록화면으로 연결
		service.notice_reply_insert(vo);
		return "redirect:list.no";
	}
	
	
	//답글작성 화면 요청
	@RequestMapping("/reply.no")
	public String reply(int id, Model model) {
		model.addAttribute("vo", service.notice_detail(id));
		return "notice/reply";
	}
	
	
	
	
	
	
	//공지글에 대한 답글 변경저장 요청
	@RequestMapping("/reply_update.no")
	public String reply_update(NoticeVO vo, MultipartFile file, HttpSession session) {
		if( ! file.isEmpty() ) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath( common.fileUpload("notice", file, session) );
		}
		vo.setWriter( ((MemberVO)session.getAttribute("loginInfo")).getId() );
		
		service.notice_reply_update(vo);
		return "redirect:list.no";
	}
	
	
	
	
	
	//공지사항 글목록 화면 요청
		@RequestMapping("/list.no")
		public String list(HttpSession session, Model model
									,String search, String keyword
									,@RequestParam(defaultValue = "1") int curPage) {
			//공지글 처리중 임의로 로그인해 두기 - 나중에 삭제할 것
//			HashMap<String, String> map = new HashMap<String, String>();
//			map.put("id", "admin");
//			map.put("pw", "Manager1");
//			map.put("id", "test4");
//			map.put("pw", "ssss");			
//			map.put("id", "hanul1");
//			map.put("pw", "Zx12312312");
//			session.setAttribute("loginInfo", member.member_login(map));
			
			
			session.setAttribute("category", "no");
			//DB에서 공지글 목록을 조회해와 목록화면에 출력
			
			//전체 모든글 목록조회
			//페이지 처리된 글 목록조회
			page.setCurPage(curPage);
			page.setSearch(search);
			page.setKeyword(keyword);
			page = service.notice_list(page);
			model.addAttribute("page", service.notice_list(page));
//			model.addAttribute("list", service.notice_list());
			
			return "notice/list";
		}
	
}