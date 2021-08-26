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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import board.BoardCommentVO;
import board.BoardPage;
import board.BoardServiceImpl;
import board.BoardVO;
import common.CommonService;
import member.MemberVO;

@Controller
public class BoardController {
	@Autowired private BoardServiceImpl service;
	@Autowired private BoardPage page;
	@Autowired private CommonService common;
	
	
	
	
	
	
	
	//커뮤니티 글에 대한 댓글수정처리 요청
	@ResponseBody @RequestMapping(value="/board/comment/update"
								, produces="application/text; charset=utf-8")
	public String comment_update(@RequestBody BoardCommentVO vo) {
		//화면에서 입력한 수정댓글정보를 DB에 변경저장한 후 저장여부를 반환
		return service.board_comment_update(vo) == 1 ?  "성공^^" : "실패ㅠㅠ";
	}
		
		
		
		
		
	//커뮤니티 글에 대한 댓글 목록조회 요청
	@RequestMapping("/board/comment/list/{pid}")
	public String comment_list(@PathVariable int pid, Model model) {
		//해당 글에 대한 댓글들을 DB에서 조회해온다
		model.addAttribute("list", service.board_comment_list(pid));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("lf", "\n");
		return "board/comment/comment_list";
	}
	
	
	
	
	//커뮤니티 글에 대한 댓글삭제처리 요청
	@ResponseBody @RequestMapping("/board/comment/delete/{id}")
	public void comment_delete(@PathVariable int id) {
		//해당 댓글을 DB에서 삭제한다
		service.board_comment_delete(id);
	}
	
	
	
	
	//커뮤니티 글에 대한 댓글저장처리 요청
	@ResponseBody @RequestMapping("/board/comment/regist")
	public boolean comment_regist(BoardCommentVO vo, HttpSession session) {
		//화면에서 입력한 댓글정보를 DB에 저장한 후 저장여부를 반환
		MemberVO member = (MemberVO)session.getAttribute("loginInfo");
		vo.setWriter( member.getId() ); 
		return service.board_comment_insert(vo) == 1 ? true : false;
	}
		
	
	
		
		
		
	//커뮤니티 신규저장처리 요청
	@RequestMapping("/insert.fb")
	public String insert(BoardVO vo, MultipartFile file, HttpSession session) {
		MemberVO member = loginStatus(session);
		if( member == null ) return "redirect:list.fb";
			
		if( ! file.isEmpty() ) {
			vo.setFilename( file.getOriginalFilename() );
			vo.setFilepath( common.fileUpload("board", file, session));
		}
		//화면에서 입력한 정보를 DB에 신규저장한 후 목록화면 연결
		vo.setWriter(  member.getId() );
		service.board_insert(vo);
		return "redirect:list.fb";
	}
	
	private MemberVO loginStatus(HttpSession session) {
		 return (MemberVO)session.getAttribute("loginInfo");
	}
		
		
		
		
		
		
		
	//커뮤니티 신규작성 화면 요청
	@RequestMapping("/new.fb")
	public String board() {
		return "board/new";
	}
		
		
		
		
		
	//커뮤니티 첨부파일 다운로드 요청
	@RequestMapping("/download.fb")
	public void download(int id, HttpSession session, HttpServletResponse response) {
		BoardVO vo = service.board_detail(id);
		common.fileDownload(vo.getFilename(), vo.getFilepath(), session, response);
	}
		
		
		
		
		
		
	//커뮤니티 상세화면 요청
	@RequestMapping("/detail.fb")
	public String detail(int id, Model model) {
		service.board_read(id);
	
		
		//해당 방명록 글을 DB에서 조회해와 상세화면에 출력
		model.addAttribute("vo", service.board_detail(id));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("page", page); //목록으로 가는데 사용할 정보
		return "board/detail";
	}
		
		
	
	// 관리자 모드 커뮤니티 상세화면 요청
	@RequestMapping("/a_detail.fb")
	public String a_detail(int id, Model model, int curPage, String search, String keyword, String u_id, String name) {
		
		service.board_read(id);
		
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		
		int code = 1;
		
		//해당 커뮤니티 글을 DB에서 조회해와 상세화면에 출력
		model.addAttribute("vo", service.board_detail(id));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("page", page); //목록으로 가는데 사용할 정보
		model.addAttribute("u_id", u_id);
		model.addAttribute("name", name);
		model.addAttribute("code", code);
		return "board/detail";
	}
	
	
	
		
		
		
	//커뮤니티 글 수정 저장처리 요청
	@RequestMapping("/update.fb")
	public String update(Model model, BoardVO vo, HttpSession session
						, MultipartFile file, String attach) {
		BoardVO board = service.board_detail( vo.getId() );
		String uuid = session.getServletContext().getRealPath("resources") 
						+ "/" + board.getFilepath();
		//파일을 첨부하지 않은 경우
		if( file.isEmpty() ) {
			//원래부터 첨부된 파일이 없는 경우,
			//원래 첨부된 파일이 있었는데 삭제한 경우
			if( attach.isEmpty() ) {
				//원래 첨부되어 있던 파일을 서버의 물리적영역에서 삭제
				if( board.getFilename() != null ) {
					File f = new File( uuid );
					if( f.exists() ) f.delete();
				}
				
			}else {
				//원래 첨부된 파일을 그대로 사용하는 경우
				vo.setFilename( board.getFilename() );
				vo.setFilepath( board.getFilepath() );
			}
			
		}else {
		//파일을 첨부한 경우
			vo.setFilename( file.getOriginalFilename() );
			vo.setFilepath( common.fileUpload("board", file, session) );
			
			//원래 첨부되어 있는 파일이 있었다면 서버의 물리적영역에서 삭제
			if( board.getFilename() != null ) {
				File f = new File( uuid );
				if( f.exists() ) f.delete();
			}
		}
		
		//화면에서 수정한 정보들을 DB에서 저장한 상세화면 연결
		service.board_update(vo);
		
		model.addAttribute("uri", "detail.fb");
		model.addAttribute("id", vo.getId());
		return "board/redirect";
	}
		
		
		
		
		
	//커뮤니티 글 수정화면 요청
	@RequestMapping("/modify.fb")
	public String modify(int id, Model model) {
		//해당 글의 정보를 DB에서 조회해와 수정화면 출력
		model.addAttribute("vo", service.board_detail(id));
		return "board/modify";
	}
		
		
		
		
	//커뮤니티 글 삭제처리 요청
	@RequestMapping("/delete.fb")
	public String delete(int id, Model model, HttpSession session) {
		//첨부파일이 있는 글에 대해서는 해당 파일을 서버의 물리적 영역에서 삭제
		BoardVO vo = service.board_detail(id);
		if( vo.getFilename() != null ) {
			File file 
				= new File( session.getServletContext().getRealPath("resources") 
						+ "/" + vo.getFilepath() );
			if( file.exists() ) file.delete();
		}
		
		//해당 커뮤니티 글을 DB에서 삭제한 후 목록화면으로 연결
		service.board_delete(id);
		//return "redirect:list.bo";
		model.addAttribute("uri", "list.fb");
		model.addAttribute("page", page);
		return "board/redirect";
	}
		
	
	
	
	// 관리자 모드에서 커뮤니티 글 삭제처리 요청
	@RequestMapping("/a_delete.fb")
	public String a_delete(int id, Model model, HttpSession session, int curPage, String search
							, String keyword,  String name, String u_id) throws Exception{
		//첨부파일이 있는 글에 대해서는 해당 파일을 서버의 물리적 영역에서 삭제
		BoardVO vo = service.board_detail(id);
		if( vo.getFilename() != null ) {
			File file 
				= new File( session.getServletContext().getRealPath("resources") 
						+ "/" + vo.getFilepath() );
			if( file.exists() ) file.delete();
		}
		
		
		//해당 커뮤니티 글을 DB에서 삭제한 후 목록화면으로 연결
		service.board_delete(id);
		//return "redirect:list.bo";
		// 한글로된 데이터를 get방식으로 파라메터를 넘길때는 throws Exception를 하고 encode를 해서 보내줘야한다.
		return "redirect:co_list.cu?id="+u_id+"&name="+ URLEncoder.encode(name, "utf-8")+"&curPage="+ curPage+"&search="+search+"&keyword="+keyword;
		}
	
	
		
		
		
	//커뮤니티 목록화면 요청
	@RequestMapping("/list.fb")
	public String list(HttpSession session, Model model
						, String search, String keyword
						, @RequestParam(defaultValue = "10") int pageList
						, @RequestParam(defaultValue = "list") String viewType
						, @RequestParam(defaultValue = "1") int curPage) {
		session.setAttribute("category", "fb");
		
		//DB에서 커뮤니티 정보를 조회해와 목록화면에 출력
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		page.setPageList(pageList);
		page.setViewType(viewType);
		model.addAttribute("page", service.board_list(page));
		return "board/list";
	}
	
	

}
