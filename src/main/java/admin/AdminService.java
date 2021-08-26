package admin;

import java.util.HashMap;
import java.util.List;

import board.BoardPage;
import member.MemberVO;
import review.ReviewPage;
import style.StylePage;

public interface AdminService {
	// Create/Read/Update/Delete : CRUD
	List<MemberVO> customer_list();     	// 회원목록 조회
	
//	List<MemberVO> customer_list(String admin);  // 특정 admin에 따른 회원 목록 조회
	
	AdminPage customer_list(AdminPage page);  // 특정 검색결과에 따른 회원 목록 조회
	
	QnaPage qna_list(HashMap<String, Object> map);	// 특정 회원이 작성한 Qna글 목록 보기
	
	BoardPage community_list(HashMap<String, Object> map); 	// 특정 회원이 작성한 Community 글 목록 보기
	
	ReviewPage review_list(HashMap<String, Object> map); 	// 특정 회원이 작성한 Review 글 목록 보기
	
	StylePage style_list(HashMap<String, Object> map); 	// 관리자가 작성한 Style 글 목록 보기
	
	List<AdminVO> customer_admin();			// 회원테이블에서 admin 정보 조회
	
	void customer_delete(String id);		// 회원정보 삭제
	
}  // interface
