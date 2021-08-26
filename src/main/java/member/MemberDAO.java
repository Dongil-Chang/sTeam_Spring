package member;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO implements MemberService {
	@Autowired private SqlSession sql;

	@Override
	public boolean member_join(MemberVO vo) {
		return sql.insert("member.mapper.join", vo) == 1 ? true : false;
	}

	
	@Override
	public boolean member_sjoin(MemberVO vo) {
		return sql.insert("member.mapper.s_join", vo) == 1 ? true : false;
	}
	
	
	
	@Override
	public MemberVO member_login(HashMap<String, String> map) {
		return sql.selectOne("member.mapper.login", map);
	}

	@Override
	public boolean member_id_check(String id) {
		return (Integer)sql.selectOne("member.mapper.id_check", id) == 0 ? true : false;
	}

	
	
	@Override
	public MemberVO member_detail(String id) {
		return sql.selectOne("member.mapper.detail", id);
	}
	
	
	
	@Override
	public int member_update(MemberVO vo) {
		return sql.update("member.mapper.member_update", vo);
	}

	@Override
	public void member_delete(String id) {
		int cnt = sql.delete("member.mapper.delete", id);
		
	}

	@Override
	public boolean member_social_email(MemberVO vo) {
		return (Integer)sql.selectOne("member.mapper.social_email"
											, vo) == 0 ? false : true;
	}

	@Override
	public boolean member_social_insert(MemberVO vo) {
		return sql.insert("member.mapper.social_insert", vo) > 0 ? true : false;
	}

	@Override
	public boolean member_social_update(MemberVO vo) {
		return sql.update("member.mapper.social_update", vo) > 0 ? true : false;
	}

	
	@Override
	public List<MemberVO> member_list() {
		return sql.selectList("member.mapper.list");
	}
	
	
	
	
	//======================================================안드로이드 ======================================
	
	//회원가입
	@Override
	public void And_member_insert(MemberVO vo) {
		 sql.insert("member.mapper.And_insert", vo);
		
	}


	//id 중복체크
	@Override
	public boolean join_idChk(String id) {
		return (Integer) sql.selectOne("member.mapper.And_idCheck",id) == 0 ? true : false;
	}

	
	// 로그인 확인
	@Override
	public boolean login_Check(MemberVO vo) {
		
		return (Integer)sql.selectOne("member.mapper.And_login", vo) == 0? true : false;
	}
	
	
	
	
	
	
}
