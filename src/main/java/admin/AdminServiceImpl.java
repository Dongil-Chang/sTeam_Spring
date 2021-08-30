package admin;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.BoardPage;
import member.MemberVO;
import review.ReviewPage;
import style.StylePage;

@Service
public class AdminServiceImpl implements AdminService{
	
	@Autowired private AdminDAO dao;
	
	// 회원정보 삭제
	@Override
	public void customer_delete(String id) {
		dao.customer_delete(id);
		
	}
	
	
	
	
	
	
	// 고객목록 조회
	@Override
	public List<MemberVO> customer_list() {
		return dao.customer_list();
	}





	/*
	 * // 특정 admin에 따른 회원 목록 조회
	 * 
	 * @Override public List<MemberVO> customer_list(String admin) {
	 * 
	 * return dao.customer_list(admin); }
	 */





	// 회원테이블에서 admin 정보 조회
	@Override
	public List<AdminVO> customer_admin() {
		
		return dao.customer_admin();
	}





	// 특정 검색결과에 따른 회원 목록 조회(페이징 처리)
	@Override
	public AdminPage customer_list(AdminPage page) {
		
		return dao.customer_list(page);
	}





	// 특정 회원이 작성한 Qna글 목록 보기
	@Override
	public QnaPage qna_list(HashMap<String, Object> map) {
		
		
		
		return dao.qna_list(map);
	}





	// 특정 회원이 작성한 Community 게시판 글 목록 보기
	@Override
	public BoardPage community_list(HashMap<String, Object> map) {
		
		return dao.community_list(map);
	}





	// 특정 회원이 작성한 Review 게시판 글 목록 보기
	@Override
	public ReviewPage review_list(HashMap<String, Object> map) {
		
		return dao.review_list(map);
	}





	// 해당 관리자가 작성한 Style 글 목록 보기
	@Override
	public StylePage style_list(HashMap<String, Object> map) {
		
		return dao.style_list(map);
	}





	
	
	
	
	
		
	
	
	
}  // calss
