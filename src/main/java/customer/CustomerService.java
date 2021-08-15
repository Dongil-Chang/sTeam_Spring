package customer;

import java.util.List;

import member.MemberVO;

public interface CustomerService {
	// Create/Read/Update/Delete : CRUD
	List<MemberVO> customer_list();     	// 회원목록 조회
	
	List<MemberVO> customer_list(String admin);  // 특정 admin에 따른 회원 목록 조회
	
	List<AdminVO> customer_admin();			// 회원테이블에서 admin 정보 조회
	
	void customer_delete(String id);		// 회원정보 삭제
	
}  // interface
