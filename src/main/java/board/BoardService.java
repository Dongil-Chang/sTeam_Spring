package board;

import java.util.HashMap;
import java.util.List;

public interface BoardService {
	int board_insert(BoardVO vo);			//커뮤니티 신규 저장
	BoardPage board_list(BoardPage page); 	//커뮤니티 목록 조회 - 페이지처리된
	BoardVO board_detail(int id); 			//커뮤니티 상세조회
	int board_read(int id);                 //커뮤니티 조회수처리
	int board_update(BoardVO vo);			//커뮤니티 변경 저장
	int board_delete(int id);               //커뮤니티 삭제
	
	int board_comment_insert(BoardCommentVO vo); //커뮤니티 댓글 신규저장처리
	int board_comment_update(BoardCommentVO vo);//커뮤니티 댓글 변경저장처리
	int board_comment_delete(int id); //커뮤니티 댓글 삭제처리
	List<BoardCommentVO> board_comment_list(int pid);//커뮤니티 댓글 목록조회
	
	// 테스트용
	BoardPage board_mc_list(HashMap<String, Object> map); // 내가 커뮤니티 글 전체 조회 (R)	
	
	
	// 메인 화면에 사용할 서비스
	List<BoardVO> main_board_list();
	
	
	
	
	//============================= 안드로이드 ====================
	   
	List<BoardVO> commuList();
	
	
	
}
