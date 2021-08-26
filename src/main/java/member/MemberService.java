package member;

import java.util.HashMap;
import java.util.List;

public interface MemberService {
	boolean member_join(MemberVO vo); //회원가입시 회원정보 저장
	boolean member_sjoin(MemberVO vo); //회원가입시 회원정보 저장
	
	MemberVO member_login(HashMap<String, String> map); //아이디/비번 일치하는 회원정보 조회
	boolean member_id_check(String id); //회원가입시 아이디 중복확인 
	int member_update(MemberVO vo); //회원정보 변경저장
	//boolean member_delete(String id); //회원탈퇴시 회원정보 삭제
	boolean member_social_email(MemberVO vo);//소셜회원 정보 존재여부
	boolean member_social_insert(MemberVO vo); //소셜회원정보 신규저장
	boolean member_social_update(MemberVO vo); //소셜회원정보 변경저장
	MemberVO member_detail(String id); 
	List<MemberVO> member_list(); 
	void member_delete(String id);
	
	//========================안드로이드==================
	void And_member_insert(MemberVO vo);		//회원가입
	boolean join_idChk(String id);			//회원가입 아이디 체크
	boolean login_Check(MemberVO vo);		// 로그인 체크
	
	
	
}