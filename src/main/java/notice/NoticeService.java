package notice;

import java.util.List;

public interface NoticeService {
	//CRUD
	void notice_insert(NoticeVO vo); 	//공지글 신규저장
	List<NoticeVO> notice_list();		//공지글 목록조회
	NoticePage notice_list(NoticePage page);//공지글 목록조회-페이지처리된
	NoticeVO notice_detail(int id);		//공지글 상세조회
	void notice_update(NoticeVO vo); 	//공지글 변경저장
	void notice_read(int id);			//공지글 조회시 조회수증가처리
	void notice_delete(int id);			//공지글 삭제
	void notice_reply_insert(NoticeVO vo);	//공지글에 대한 답글 신규저장
	void notice_reply_update(NoticeVO vo); //공지글에 대한 답글 변경저장
	
	// 메인 화면에 사용할 서비스
	List<NoticeVO> Main_notice_list();		//공지글 목록조회
	
}
