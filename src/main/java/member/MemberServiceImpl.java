package member;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class MemberServiceImpl implements MemberService {
	@Autowired private MemberDAO dao;
	
	@Override
	public boolean member_join(MemberVO vo) {
		return dao.member_join(vo);
	}
	
	@Override
	public boolean member_sjoin(MemberVO vo) {
		return dao.member_sjoin(vo);
	}

	@Override
	public MemberVO member_login(HashMap<String, String> map) {
		return dao.member_login(map);
	}

	@Override
	public boolean member_id_check(String id) {
		return dao.member_id_check(id);
	}

	@Override
	public int member_update(MemberVO vo) {
		return dao.member_update(vo);
	}


	@Override
	public boolean member_social_email(MemberVO vo) {
		return dao.member_social_email(vo);
	}

	@Override
	public boolean member_social_insert(MemberVO vo) {
		return dao.member_social_insert(vo);
	}

	@Override
	public boolean member_social_update(MemberVO vo) {
		return dao.member_social_update(vo);
	}
	
	@Override
	public List<MemberVO> member_list() {
		return dao.member_list();
	}
	
	@Override
	public void member_delete(String id) {
		dao.member_delete(id);
		
	}
	
	@Override
	public MemberVO member_detail(String id) {
		return dao.member_detail(id);
	}
	
	
	
	
	//==============================================안드로이드 -===============================
	
	//회원가입
	@Override
	public void And_member_insert(MemberVO vo) {
		dao.And_member_insert(vo);
	}
	
	//id 중복체크
	@Override
	public boolean join_idChk(String id) {
		return dao.join_idChk(id);
	}

	
	// 로그인 확인
	@Override
	public boolean login_Check(MemberVO vo) {
		
		return dao.login_Check(vo);
	}
	
	
	
	
	

}
