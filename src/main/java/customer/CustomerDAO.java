package customer;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import member.MemberVO;

@Repository
public class CustomerDAO implements CustomerService{
	
	@Autowired  SqlSession sql;
	
	
	
	// 회원정보 삭제
	@Override
	public void customer_delete(String id) {
		int cnt = sql.delete("customer.mapper.delete", id);
		
	}
	
				
	
	
	
	
	
	// 회원목록 조회
	@Override
	public List<MemberVO> customer_list() {
		return sql.selectList("customer.mapper.list");
	}






	// 특정 admin에 따른 회원 목록 조회
	@Override
	public List<MemberVO> customer_list(String admin) {
		
		return sql.selectList("customer.mapper.admin_list", admin);
	}






	// 회원테이블에서 admin 정보 조회
	@Override
	public List<AdminVO> customer_admin() {
		
		return sql.selectList("customer.mapper.admin");
	}
	
	
	
	
	
	
}  // calss
