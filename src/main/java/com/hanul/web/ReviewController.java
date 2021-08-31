package com.hanul.web;

import java.io.File;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.CommonService;
import member.MemberVO;
import review.ReviewPage;
import review.ReviewReplyVO;
import review.ReviewServiceImpl;
import review.ReviewVO;

	@Controller
public class ReviewController {
		
	@Autowired private ReviewServiceImpl service;
	@Autowired private ReviewPage page;
	@Autowired private CommonService common;
		


	//리뷰 글에 대한 댓글삭제처리 요청
	@ResponseBody @RequestMapping("/review/reply/delete/{id}")
	public void review_delete(@PathVariable int id) {
		//해당글을 DB에서 삭제한다
		service.review_reply_delete(id);
	}
		
	
	
	//리뷰 글에 대한 댓글 수정처리 요청
	@ResponseBody @RequestMapping(value = "/review/reply/update", produces="application/text; charset=utf-8")  // 이 자체가 응답이다  | value랑 produces는 리턴에 문자가 안깨지게 하는것
	public String reply_update(@RequestBody ReviewReplyVO vo) {
		//화면에서 입력한 수정 댓글 정보를 DB에 변경 저장한 후 저장 여부를 반환
		return service.review_reply_update(vo) == 1 ?  "성공" : "실패";
	}
	
	
	
	
	//리뷰 글에 대한 댓글 목록조회 요청
	@RequestMapping("/review/reply/list/{pid}")
	public String comment_list(@PathVariable int pid, Model model) {
		//해당 글에 대한 댓글들을 DB에서 조회해온다
		model.addAttribute("list", service.review_reply_list(pid));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("lf", "\n"); //그냥엔터
		return "review/reply/reply_list";
		
	}
	
	
	
	
	
	//리뷰 글에 대한 댓글저장 처리 요청
	//이 자체가 응답이니 ResponseBody
	@ResponseBody @RequestMapping("/review/reply/regist")
	public boolean reply_regist(ReviewReplyVO vo, HttpSession session) {
		//화면에서 입력한 댓글정보를 DB에 저장한 후 저장여부를 반환
		MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		vo.setRp_writer(member.getId());
		
		return service.review_reply_insert(vo) == 1 ? true : false;
	}
	
	
	
	
	
	//리뷰 신규저장처리 요청
	@RequestMapping("/insert.re")
	public String insert(ReviewVO vo, MultipartFile file, HttpSession session, Model model) {
		MemberVO member = loginStatus(session);
		if(member == null) {
			return "redirect:list.re";
		}//if
		
		if( ! file.isEmpty()) {
			vo.setRv_filename(file.getOriginalFilename());		//db에 저장
			vo.setRv_filepath(common.fileUpload("review", file, session));	//저장시키는 위치
		}//if
		
		//화면에서 입력한 정보를 DB에 신규저장한 후 목록화면 연결
		vo.setRv_writer( member.getId() );
		service.review_insert(vo);
		model.addAttribute("shop_list", service.review_shop_list());
		return "redirect:list.re";
	}//insert
	
	
	
	
	
	private MemberVO loginStatus(HttpSession session) {
		 return (MemberVO) session.getAttribute("loginInfo");
	}//loginStatus() 
	
	
	
	
	
	
	//리뷰 신규작성 화면 요청
	@RequestMapping("/new.re")
	public String review(String data, Model model, int code ) {
		
		model.addAttribute("code", code);
		model.addAttribute("shopName" , data==null ? null : service.review_shopName(data));
		//model.addAttribute("shop_list", service.review_shop_list());
		return "review/new";
	}//new
	
	
	
	
	
	
	//리뷰 첨부파일 다운로드 요청
	@RequestMapping("/download.re")
	public void download(int id, HttpSession session, HttpServletResponse response) {
		ReviewVO vo = service.review_detail(id);
		common.fileDownload(vo.getRv_filename(), vo.getRv_filepath(), session, response);

	}
	
	
	
	
	
	
	//리뷰 글 수정 저장 처리 요청
	@RequestMapping("/update.re")
	public String update(Model model, ReviewVO vo, MultipartFile file, String attach, HttpSession session) {
		ReviewVO review = service.review_detail(vo.getRv_id());
		String uuid = session.getServletContext().getRealPath("resources") + "/" + review.getRv_filepath();
		
		//파일을 첨부하지 않은 경우
		if( file.isEmpty() ) {
			//원래부터 첨부된 파일이 없는 경우, 
			//원래 첨부된 파일이 있었는데 삭제한 경우
			if(attach.isEmpty()) {
				//원래 첨부되어 있는 파일을 서버의 물리적영역에서 삭제
				if( review.getRv_filename() != null) {
					File f = new File(uuid);
					if(f.exists()) {
						f.delete();
					}//if
				}//if
			}else {
				//원래 첨부된 파일을 그대로 사용하는 경우
				vo.setRv_filename( review.getRv_filename());
				vo.setRv_filepath( review.getRv_filepath());
			}//if
		}else {
		//파일을 첨부한 경우
			vo.setRv_filename( file.getOriginalFilename() );
			vo.setRv_filepath( common.fileUpload("review", file, session) );
			
			if(review.getRv_filename() != null) {
				File f = new File(uuid);
				if(f.exists()) {
					f.delete();
				}//if
			}//if
		}//if
		
		
		//화면에서 수정한 정보들을 DB에서 저장한 상세화면 연결
		service.review_update(vo);
		
		model.addAttribute("uri", "detail.re");
		model.addAttribute("id", vo.getRv_id());
		return "review/redirect";
	}
	
	
	
	
	
	
	
	//리뷰 상세화면 요청
	@RequestMapping("/detail.re")
	public String detail(int id, Model model, @RequestParam(required = false)Integer curPage) {
		service.review_read(id);
		
		if(curPage!=null) page.setCurPage(curPage); //홈에서 클릭한 경우
		
		//해당 리뷰 글을 DB에서 조회해와 상세화면에 출력
		model.addAttribute("vo", service.review_detail(id));
		model.addAttribute("crlf", "\r\n"); //\r\n 엔터
		model.addAttribute("page", page); //목록으로 가는데 사용할 정보 
		return "review/details";
	}
	
	
	
	// 관리자 모드 리뷰 상세화면 요청
	@RequestMapping("/a_detail.re")
	public String a_detail(int id, Model model, int curPage, String search, String keyword, String u_id, String name, String viewType, int pageList) {
		service.review_read(id);
		
		page.setPageList(pageList);
		page.setViewType(viewType);
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		
		int code = 1;
		
		
		
		//해당 리뷰 글을 DB에서 조회해와 상세화면에 출력
		model.addAttribute("vo", service.review_detail(id));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("page", page); //목록으로 가는데 사용할 정보
		model.addAttribute("u_id", u_id);
		model.addAttribute("name", name);
		model.addAttribute("code", code);
		return "review/details";
	}

	
	
	
	
	
	//리뷰 글 수정화면 요청
	@RequestMapping("/modify.re")
	public String modify(int id, Model model) {
		//해당 글의 정보를 DB에서 조회해와야함 수정화면에 출력하도록 해야함
		model.addAttribute("vo", service.review_detail(id));
		return "review/modify";
	}
	
	
	
	
	
	//리뷰 글 삭제처리 요청
	@RequestMapping("/delete.re")
	public String delete(int id, Model model, HttpSession session) {
		//첨부파일이 있는 글에 대해서는 해당 파일을 서버의 물리적 영역에서 삭제
		ReviewVO vo = service.review_detail(id);
		if(vo.getRv_filename() != null) {
			File file = new File(session.getServletContext().getRealPath("resources") + "/" + vo.getRv_filepath() );
			
			if(file.exists() ) {
				file.delete();
			}//if
		}//if
		
		//해당 리뷰 글을 DB에서 삭제한 후 목록화면으로 연결
		service.review_delete(id);
		//return "redirect:list.bo";
		model.addAttribute("uri", "list.re");
		model.addAttribute("page", page);
		return "review/redirect";
	}
	
	
	
	
	
	// 관리자 모드에서 리뷰 글 삭제처리 요청
	@RequestMapping("/a_delete.re")
	public String a_delete(int id, Model model, HttpSession session, int curPage, String search
			, String keyword,  String name, String u_id, int pageList, String viewType) throws Exception{
		
		//첨부파일이 있는 글에 대해서는 해당 파일을 서버의 물리적 영역에서 삭제
		ReviewVO vo = service.review_detail(id);
		if(vo.getRv_filename() != null) {
			File file = new File(session.getServletContext().getRealPath("resources") + "/" + vo.getRv_filepath() );
			
			if(file.exists() ) {
				file.delete();
			}//if
		}//if
		
		//해당 리뷰 글을 DB에서 삭제한 후 목록화면으로 연결
		service.review_delete(id);
		//return "redirect:list.bo";
		
		return "redirect:re_list.cu?id="+u_id+"&name="+ URLEncoder.encode(name, "utf-8")+"&curPage="+ curPage+"&search="+search+"&keyword="+keyword+"&pageList="+pageList+"&viewType="+viewType;
	}
	
	
	
	
		//마이페이지 리뷰 삭제
	   @RequestMapping("/mdelete.re")
	   public String mdelete(int id, Model model, HttpSession session) {
	      //첨부파일이 있는 글에 대해서는 해당 파일을 서버의 물리적 영역에서 삭제
	      ReviewVO vo = service.review_detail(id);
	      if(vo.getRv_filename() != null) {
	         File file = new File(session.getServletContext().getRealPath("resources") + "/" + vo.getRv_filepath() );
	         
	         if(file.exists() ) {
	            file.delete();
	         }//if
	      }//if
	      
	      //해당 리뷰 글을 DB에서 삭제한 후 목록화면으로 연결
	      service.review_delete(id);
	      //return "redirect:list.bo";
	      model.addAttribute("uri", "mrlist.mp");
	      model.addAttribute("page", page);
	      return "review/redirect";}
	
	
	   
	   //마이페이지 상세화면 요청
	   @RequestMapping("/mdetail.re")
	   public String mdetail(int id, Model model, @RequestParam(required = false)Integer curPage) {
	      service.review_read(id);
	      
	      if(curPage!=null) page.setCurPage(curPage); //홈에서 클릭한 경우
	      
	      //해당 리뷰 글을 DB에서 조회해와 상세화면에 출력
	      model.addAttribute("vo", service.review_detail(id));
	      model.addAttribute("crlf", "\r\n"); //\r\n 엔터
	      model.addAttribute("page", page); //목록으로 가는데 사용할 정보 
	      return "review/m_details";
	   }
	   
	   
	
	
	
	
	//리뷰 목록화면 요청
	@RequestMapping("/list.re")								//현재 페이지																			//기본값 10개
	public String list(HttpSession session, @RequestParam(defaultValue = "1") int curPage, Model model, String search, String keyword, @RequestParam(defaultValue = "10") int pageList
						,@RequestParam(defaultValue = "list") String viewType) {
		session.setAttribute("category", "re");
		
		int code = 1;
		
		model.addAttribute("code", code);
		//DB에서 리뷰 정보를 조회해와 목록화면에 출력
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		page.setPageList(pageList);
		page.setViewType(viewType);
		model.addAttribute("page", service.review_list(page));
		model.addAttribute("shop_list", service.review_shop_list());
		return "review/list";
	}//aa
		
}
