package customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import member.MemberVO;

@Service
public class CustomerServiceImpl implements CustomerService{
	
	@Autowired private CustomerDAO dao;
	
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





	// 특정 admin에 따른 회원 목록 조회
	@Override
	public List<MemberVO> customer_list(String admin) {
		
		return dao.customer_list(admin);
	}





	// 회원테이블에서 admin 정보 조회
	@Override
	public List<AdminVO> customer_admin() {
		
		return dao.customer_admin();
	}
	
	
	
		
	
	
	
}  // calss
