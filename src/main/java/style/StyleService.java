package style;

import java.util.HashMap;


public interface StyleService {
	StylePage style_list(StylePage page); 	//스타일 목록 조회 - 페이지처리된
	StyleVO style_detail(int id);			//스타일 상세조회
	int style_read(int id);					//스타일 조회수처리
	int style_update(StyleVO vo);			//스타일 변경 저장
	int style_delete(int id);				//스타일 삭제
	int style_insert(StyleVO vo);			//스타일 신규 저장
	
	StylePage style_ms_list(HashMap<String, Object> map);

}
