package com.hanul.web;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.CommonService;
import member.MemberVO;
import style.StylePage;
import style.StyleServiceImpl;
import style.StyleVO;

@Controller
public class StyleController {
	
	
	
	@Autowired private CommonService common;
	@Autowired private StylePage page;
	@Autowired private StyleServiceImpl service;
	
	
	
	
	
	
	//스타일 목록화면 요청
	@RequestMapping("/list.st")
	public String list(HttpSession session, Model model, String search, String keyword
					,@RequestParam(defaultValue = "10")int pageList
					,@RequestParam(defaultValue = "list") String viewType
					,@RequestParam(defaultValue = "1") int curPage) {
		session.setAttribute("category", "st");
		
		//DB에서 스타일 정보를 조회해 와 목록 화면에 출력
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		page.setPageList(pageList);
		page.setViewType(viewType);
		model.addAttribute("page",service.style_list(page));
		
		return "Style/list";
	}
	
	
	
	
	
	
	//스타일 신규작성 화면 요청
			@RequestMapping("/new.st")
			public String style() {
				return "Style/new";
			}
	
			
			
			
			
			
	//스타일 신규저장처리 요청
	@RequestMapping("/insert.st")		
	public String insert(StyleVO vo, MultipartFile file, HttpSession session) {
		vo.setWriter(((MemberVO) session.getAttribute("loginInfo")).getId());
		
		if(! file.isEmpty()) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(common.fileUpload("style", file, session));
		}
		service.style_insert(vo);
		return"redirect:list.st";
	}
	
	/*
	 * private MemberVO loginStatus(HttpSession session) { return
	 * (MemberVO)session.getAttribute("loginInfo"); }
	 */
	
	
	
	
	
	
	@RequestMapping("/download.st")
	public void download(int id, HttpSession session, HttpServletResponse response) {
		StyleVO vo = service.style_detail(id);
		common.fileDownload(vo.getFilename(), vo.getFilepath(), session, response);
	}
	
	
	
	
	
	
	
	
	@RequestMapping("/detail.st")
	public String detail(int id, Model model) {
		service.style_read(id);
		
		model.addAttribute("vo",service.style_detail(id));
		model.addAttribute("crlf","\r\n");
		model.addAttribute("page",page);
		return "Style/detail";
	}
	
	
	
	
	// 관리자 모드 Style 글 상세조회 요청
	@RequestMapping("/a_detail.st")
	public String a_detail(int id, Model model, int curPage, String search, String keyword, String u_id, String name) {
		service.style_read(id);
		
		
		
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		
		int code = 1;
		
		
		model.addAttribute("vo",service.style_detail(id));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("page", page); //목록으로 가는데 사용할 정보
		model.addAttribute("u_id", u_id);
		model.addAttribute("name", name);
		model.addAttribute("code", code);
		return "Style/detail";
	}
	
	
	
	
	//글 수정화면 요청
	@RequestMapping("/modify.st")
	public String modify(int id, Model model) {
		//해당 글의 정보를 DB에서 조회해와 수정화면 출력
		model.addAttribute("vo", service.style_detail(id));
		return "Style/modify";
	}
	
	
	
	
	
	@RequestMapping("/delete.st")
	public String delete(int id, Model model, HttpSession session) {
		StyleVO vo = service.style_detail(id);
		if(vo.getFilename() != null) {
			File file
				= new File(session.getServletContext().getRealPath("resources")
						+ "/" + vo.getFilepath() );
			if(file.exists()) file.delete();
		}
		//해당 스타일 글을 DB에서 삭제한 후 목록화면으로 연결
		service.style_delete(id);
		model.addAttribute("uri","list.st");
		model.addAttribute("page",page);
		return "Style/redirect";
		
	}

	
	
	// 관리자 권한으로 Style 글 삭제 처리
	@RequestMapping("/a_delete.st")
	public String a_delete(int id, Model model, HttpSession session, int curPage, String search
			, String keyword,  String name, String u_id) throws Exception{
		
		StyleVO vo = service.style_detail(id);
		if(vo.getFilename() != null) {
			File file
				= new File(session.getServletContext().getRealPath("resources")
						+ "/" + vo.getFilepath() );
			if(file.exists()) file.delete();
		}
		//해당 스타일 글을 DB에서 삭제한 후 목록화면으로 연결
		service.style_delete(id);
		
		return "redirect:st_list.cu?id="+u_id+"&name="+ URLEncoder.encode(name, "utf-8")+"&curPage="+ curPage+"&search="+search+"&keyword="+keyword;
	}
	
	
	
	
	// Style 게시글 디테일 화면에서 이미지파일 삽입 요청
   @RequestMapping(value="/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
   @ResponseBody
   public Object  uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,
		   HttpServletRequest request, HttpSession session )  {
      HashMap<String, Object> obj = new HashMap<String, Object>();
      
      obj.put("url", common.fileUpload("summernote", multipartFile, session));
      return obj;
   }
	
	
	
	
	
	
	
}
