package com.hanul.web;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tiles.request.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import common.CommonService;
import member.MemberServiceImpl;
import member.MemberVO;
import notice.NoticeVO;
import qna.Q_QnaPage;
import qna.QnaServiceImpl;
import qna.QnaVO;

@Controller
public class QnaController {
	
	@Autowired private QnaServiceImpl service;
	@Autowired private CommonService common;
	
	
	//QnA글 수정저장처리 요청
	@RequestMapping("/update.qa")
	public String update(QnaVO vo, String attach
						, MultipartFile file, HttpSession session) {
		QnaVO qna = service.qna_detail(vo.getQ_id());
		String uuid = session.getServletContext().getRealPath("resources")
						+ "/" + qna.getQ_filepath();
		
		//첨부파일이 있는 경우
		if( ! file.isEmpty() ) {
			vo.setQ_filename( file.getOriginalFilename() );
			vo.setQ_filepath( common.fileUpload("qna", file, session));
			
			//원래 첨부된 파일이 있었다면 물리적인 디스크에서 해당 파일삭제
			if( qna.getQ_filename() !=null ) {
				File f = new File( uuid );
				if( f.exists() ) f.delete();
			}
		}else {
		//첨부파일이 없는 경우
			//원래 첨부된 파일을 삭제하는 경우
			if( attach.isEmpty() ) {
				if( qna.getQ_filename()!=null ) {
					File f = new File( uuid );
					if( f.exists() ) f.delete();
				}
				
			}else {
			//원래 첨부된 파일을 그대로 사용하는 경우
				vo.setQ_filename( qna.getQ_filename() );
				vo.setQ_filepath( qna.getQ_filepath() );
			}
		}
		
		//화면에서 변경입력한 정보를 DB에 변경저장한 후 상세화면으로 연결
		service.qna_update(vo);
		return "redirect:detail.qa?q_id=" + vo.getQ_id();
	}
	
	
	
	
	
	
	// 관리자 모드 QnA글 수정저장처리 요청
	@RequestMapping("/a_update.qa")
	public String a_update(QnaVO vo, String attach, MultipartFile file, HttpSession session
						,int curPage, String search, String keyword
										, String id, String name) throws Exception{
		
		QnaVO qna = service.qna_detail(vo.getQ_id());
		String uuid = session.getServletContext().getRealPath("resources")
						+ "/" + qna.getQ_filepath();
		
		//첨부파일이 있는 경우
		if( ! file.isEmpty() ) {
			vo.setQ_filename( file.getOriginalFilename() );
			vo.setQ_filepath( common.fileUpload("qna", file, session));
			
			//원래 첨부된 파일이 있었다면 물리적인 디스크에서 해당 파일삭제
			if( qna.getQ_filename() !=null ) {
				File f = new File( uuid );
				if( f.exists() ) f.delete();
			}
		}else {
		//첨부파일이 없는 경우
			//원래 첨부된 파일을 삭제하는 경우
			if( attach.isEmpty() ) {
				if( qna.getQ_filename()!=null ) {
					File f = new File( uuid );
					if( f.exists() ) f.delete();
				}
				
			}else {
			//원래 첨부된 파일을 그대로 사용하는 경우
				vo.setQ_filename( qna.getQ_filename() );
				vo.setQ_filepath( qna.getQ_filepath() );
			}
		}
		
		//화면에서 변경입력한 정보를 DB에 변경저장한 후 상세화면으로 연결
		service.qna_update(vo);
		return "redirect:a_detail.qa?q_id="+ vo.getQ_id() +"&id=" + id + "&name="+ URLEncoder.encode(name, "utf-8") +"&curPage="+ curPage+"&search="+search+"&keyword="+keyword;
	}
	
	
	
	
	
	
	
	//QnA글 수정화면 요청
	@RequestMapping("/modify.qa")
	public String modify(int q_id, Model model) {
		//해당 공지글정보를 DB에서 조회해와 수정화면에 출력
		model.addAttribute("vo", service.qna_detail(q_id));
		return "qna/modify";
	}
	
	
	
	
	// 관리자 모드 QnA글 수정화면 요청
	@RequestMapping("/a_modify.qa")
	public String a_modify(int q_id, Model model, int code, int curPage, String search
					, String keyword, String id, String name) {
		//해당 공지글정보를 DB에서 조회해와 수정화면에 출력
		model.addAttribute("curPage", curPage);
		model.addAttribute("search", search);
		model.addAttribute("keyword", keyword);
		model.addAttribute("id", id);
		model.addAttribute("name", name);
		model.addAttribute("code", code);
		model.addAttribute("vo", service.qna_detail(q_id));
		return "qna/modify";
	}
	
	
	
	
	
	//QnA글 삭제처리 요청
	@RequestMapping("/delete.qa")
	public String delete(int q_id, HttpSession session) {
		//첨부파일이 있는 글의 경우 디스크에서 첨부파일을 삭제한다
		QnaVO qna = service.qna_detail(q_id);
		String uuid =  session.getServletContext().getRealPath("resources") 
						+ "/" + qna.getQ_filepath();
		if( qna.getQ_filename()!=null ) {
			File file = new File(uuid);
			if( file.exists() ) file.delete();
		}
		
		//해당 QnA글 정보를 DB에서 삭제한 후 목록화면으로 연결
		service.qna_delete(q_id);
		return "redirect:list.qa";
	}
	
	
	
	// 관리자 모드 QnA글 삭제처리 요청
	@RequestMapping("/a_delete.qa")
	public String a_delete(int q_id, HttpSession session ,int curPage, String search
											, String keyword, String id, String name) throws Exception{
		//첨부파일이 있는 글의 경우 디스크에서 첨부파일을 삭제한다
		QnaVO qna = service.qna_detail(q_id);
		String uuid =  session.getServletContext().getRealPath("resources") 
						+ "/" + qna.getQ_filepath();
		if( qna.getQ_filename()!=null ) {
			File file = new File(uuid);
			if( file.exists() ) file.delete();
		}
		
		//해당 QnA글 정보를 DB에서 삭제한 후 목록화면으로 연결
		service.qna_delete(q_id);
		
		// 한글로된 데이터를 get방식으로 파라메터를 넘길때는 throws Exception를 하고 encode를 해서 보내줘야한다.
		return "redirect:qna_list.cu?id="+id+"&name="+ URLEncoder.encode(name, "utf-8") +"&curPage="+ curPage+"&search="+search+"&keyword="+keyword;     
		}
	
	
	
	//QnA글의 첨부파일 다운로드 요청
	@RequestMapping("/download.qa")
	public void download(int q_id, HttpSession session, HttpServletResponse response) {
		//해당 QnA글의 첨부파일 정보를 DB에서 조회해와 
		//해당 파일을 서버로부터 다운로드한다 
		QnaVO qna = service.qna_detail(q_id);
		common.fileDownload(qna.getQ_filename(), qna.getQ_filepath()
								, session, response);
	}
	
	
	//QnA글 상세화면 요청
	@RequestMapping("/detail.qa")
	public String detail(int q_id,  Model model) { 
		service.qna_read(q_id); //조회수 증가시키기
		//선택한 공지사항 정보를 DB에서 조회해 와 상세화면에 출력
		model.addAttribute("vo", service.qna_detail(q_id));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("page", page);
		return "qna/detail";
	}
	
	
	
	
	// 관리자 모드에서 QnA글 상세화면 요청
	@RequestMapping("/a_detail.qa")
	public String a_detail(int q_id,  Model model, int curPage, String search, String keyword, String id, String name) { 
		service.qna_read(q_id); //조회수 증가시키기
		//선택한 공지사항 정보를 DB에서 조회해 와 상세화면에 출력
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		
		int code = 1;
		
		model.addAttribute("vo", service.qna_detail(q_id));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("page", page);
		model.addAttribute("id", id);
		model.addAttribute("name", name);
		model.addAttribute("code", code);
		return "qna/detail";
	}
	
	
	
	
	
	
	//QnA글 저장처리 요청
	@RequestMapping("/insert.qa")
	public String insert(QnaVO vo, MultipartFile file
						, HttpSession session) {
		//MemberVO member = (MemberVO)session.getAttribute("loginInfo");
		//vo.setWriter( member.getId() );
		vo.setQ_writer( ((MemberVO)session.getAttribute("loginInfo")).getId() );
		if( ! file.isEmpty() ) {
			vo.setQ_filename( file.getOriginalFilename() );
			vo.setQ_filepath( common.fileUpload("qna", file, session) );
		}
		
		//화면에서 입력한 정보를 DB에 저장한 후 화면으로 연결
		service.qna_insert(vo);
		return "redirect:list.qa";
	}
	  
	
		
	
	
		//QnA 답글저장처리 요청
		@RequestMapping("/reply_insert.qa")
		public String reply_insert(QnaVO vo, MultipartFile file, HttpSession session) {
			if( ! file.isEmpty() ) {
				vo.setQ_filename(file.getOriginalFilename());
				vo.setQ_filepath( common.fileUpload("qna", file, session) );
			}
			vo.setQ_writer( ((MemberVO)session.getAttribute("loginInfo")).getId() );
			
			//화면에서 입력한 답글정보를 DB에 저장한 후 목록화면으로 연결
			service.qna_reply_insert(vo);
			return "redirect:list.qa";
		}
	  
		
		
		
		// 관리자 모드 QnA 답글저장처리 요청
		@RequestMapping("/a_reply_insert.qa")
		public String a_reply_insert(QnaVO vo, MultipartFile file, HttpSession session) {
			if( ! file.isEmpty() ) {
				vo.setQ_filename(file.getOriginalFilename());
				vo.setQ_filepath( common.fileUpload("qna", file, session) );
			}
			vo.setQ_writer( ((MemberVO)session.getAttribute("loginInfo")).getId() );
			
			//화면에서 입력한 답글정보를 DB에 저장한 후 목록화면으로 연결
			service.qna_reply_insert(vo);
			return "redirect:list.cu";
		}
		
		
		
		
	
	
	  //QnA 답글작성 화면 요청
	  @RequestMapping("/reply.qa")
	  public String reply(int q_id, Model model) {
	  model.addAttribute("vo", service.qna_detail(q_id)); 
	  return "qna/reply"; 
	  }
	  
	  
	  
	  // 관리자 모드 QnA 답글작성 화면 요청
	  @RequestMapping("/a_reply.qa")
	  public String a_reply(int q_id, Model model, int curPage, String search, String keyword, String id, String name) {
		  
	  int code = 1;
	  
	  model.addAttribute("code", code);
	  model.addAttribute("vo", service.qna_detail(q_id)); 
	  model.addAttribute("q_id", q_id);
	  model.addAttribute("curPage", curPage);
	  model.addAttribute("search", search);
	  model.addAttribute("keyword", keyword);
	  model.addAttribute("id", id);
	  model.addAttribute("name", name);
	  return "qna/reply"; 
	  }
	  
	  
	  
	  
	//QnA에 대한 답글 변경저장 요청
	@RequestMapping("/reply_update.qa")
	public String reply_update(QnaVO vo, MultipartFile file, HttpSession session) {
		if( ! file.isEmpty() ) {
			vo.setQ_filename(file.getOriginalFilename());
			vo.setQ_filepath( common.fileUpload("qna", file, session) );
		}
		vo.setQ_writer( ((MemberVO)session.getAttribute("loginInfo")).getId() );
		
		service.qna_reply_update(vo);
		return "redirect:list.qa";
	}
	  
	  
	  
	  
	  
	  //QnA 글작성 입력화면 요청 
	  @RequestMapping("/new.qa") 
	  public String qna() { 
		  return "qna/new"; 
	 }
	  
	  
	  
	  
	  
	  
	  
	  
	  @Autowired private MemberServiceImpl member;
	  @Autowired private Q_QnaPage page;
	
	//QnA 글목록 화면 요청
		@RequestMapping("/list.qa")
		public String list(HttpSession session, Model model
									,String search, String keyword
									,@RequestParam(defaultValue = "1") int curPage) {
				
			session.setAttribute("category", "qa");
			//DB에서 공지글 목록을 조회해와 목록화면에 출력
			
			//전체 모든글 목록조회
			//페이지 처리된 글 목록조회
			page.setCurPage(curPage);
			page.setSearch(search);
			page.setKeyword(keyword);
			page = service.qna_list(page);
			model.addAttribute("page", service.qna_list(page));
//			model.addAttribute("list", service.notice_list());
			
			return "qna/list";
		}
	
}