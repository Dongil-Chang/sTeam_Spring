package admin;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import board.BoardPage;
import member.MemberVO;
import review.ReviewPage;
import style.StylePage;

@Repository
public class AdminDAO implements AdminService{
	
	@Autowired  SqlSession sql;
	
	
	
	// 회원정보 삭제
	@Override
	public void customer_delete(String id) {
		int cnt = sql.delete("admin.mapper.delete", id);
		
	}
	
				
	
	
	
	
	
	// 회원목록 조회
	@Override
	public List<MemberVO> customer_list() {
		return sql.selectList("admin.mapper.list");
	}






	/*
	 * // 특정 admin에 따른 회원 목록 조회
	 * 
	 * @Override public List<MemberVO> customer_list(String admin) {
	 * 
	 * return sql.selectList("customer.mapper.admin_list", admin); }
	 */






	// 회원테이블에서 admin 정보 조회
	@Override
	public List<AdminVO> customer_admin() {
		
		return sql.selectList("admin.mapper.admin");
	}






	// 특정 검색결과에 따른 회원 목록 조회(페이징처리)
	@Override
	public AdminPage customer_list(AdminPage page) {
		page.setTotalList(sql.selectOne("admin.mapper.totalList", page));
		page.setList(sql.selectList("admin.mapper.page_list", page));
		
		
		return page;
	}





	// 특정 회원이 작성한 Qna글 목록 보기
	@Override
	public QnaPage qna_list(HashMap<String, Object> map) {
			
			QnaPage q_page = (QnaPage) map.get("q_page");
			q_page.setTotalList( sql.selectOne("admin.mapper.q_totalList", map) );
			q_page.setList( sql.selectList("admin.mapper.qna_list", map) );

		return q_page;
	}






	// 특정 회원이 작성한 Community 게시판 글 목록 보기
	@Override
	public BoardPage community_list(HashMap<String, Object> map) {
			
			BoardPage b_page = (BoardPage)map.get("b_page");
			b_page.setTotalList( sql.selectOne("admin.mapper.c_totalList", map) );
			b_page.setList( sql.selectList("admin.mapper.c_list", map) );
			
		return b_page;
	}






	// 특정 회원이 작성한 Review 게시판 글 목록 보기
	@Override
	public ReviewPage review_list(HashMap<String, Object> map) {
		
		ReviewPage r_page = (ReviewPage)map.get("r_page");
		r_page.setTotalList( sql.selectOne("admin.mapper.r_totalList", map) );
		r_page.setList( sql.selectList("admin.mapper.r_list", map) );
		
		return r_page;
	}





	
	// 특정 관리자가 작성한 Style 글 목록 보기
	@Override
	public StylePage style_list(HashMap<String, Object> map) {
		
		
		StylePage s_page = (StylePage)map.get("s_page");
		s_page.setTotalList( sql.selectOne("admin.mapper.s_totalList", map) );
		s_page.setList( sql.selectList("admin.mapper.s_list", map) );
		
		return s_page;
	}






	
	
	
	
	
	
	
	
}  // calss
