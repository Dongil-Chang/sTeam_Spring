package board;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired private BoardDAO dao;
	
	@Override
	public int board_insert(BoardVO vo) {
		return dao.board_insert(vo);
	}

	@Override
	public BoardPage board_list(BoardPage page) {
		return dao.board_list(page);
	}

	@Override
	public BoardVO board_detail(int id) {
		return dao.board_detail(id);
	}

	@Override
	public int board_read(int id) {
		return dao.board_read(id);
	}

	@Override
	public int board_update(BoardVO vo) {
		return dao.board_update(vo);
	}

	@Override
	public int board_delete(int id) {
		return dao.board_delete(id);
	}

	@Override
	public int board_comment_insert(BoardCommentVO vo) {
		return dao.board_comment_insert(vo);
	}

	@Override
	public int board_comment_update(BoardCommentVO vo) {
		return dao.board_comment_update(vo);
	}

	@Override
	public int board_comment_delete(int id) {
		return dao.board_comment_delete(id);
	}

	@Override
	public List<BoardCommentVO> board_comment_list(int pid) {
		return dao.board_comment_list(pid);
	}

	
	// test
	@Override
	public BoardPage board_mc_list(HashMap<String, Object> map) {
		return dao.board_mc_list(map);
	}

	
	
	// 메인화면에서 사용할 리스트
	@Override
	public List<BoardVO> main_board_list() {
		
		return dao.main_board_list();
	}
	
	
	
	
}
