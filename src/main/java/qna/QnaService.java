package qna;

import java.util.HashMap;
import java.util.List;

public interface QnaService {
	//CRUD
	void qna_insert(QnaVO vo); 			//qna 신규저장
	List<QnaVO> qna_list();				//qna 목록조회
	Q_QnaPage qna_list(Q_QnaPage page);		//qna 목록조회-페이지처리된
	QnaVO qna_detail(int id);			//qna 상세조회
	void qna_update(QnaVO vo); 			//qna 변경저장
	void qna_read(int id);				//qna 조회시 조회수증가처리
	void qna_delete(int id);			//qna 삭제
	void qna_reply_insert(QnaVO vo);	//qna에 대한 답글 신규저장
	void qna_reply_update(QnaVO vo); 	//qna에 대한 답글 변경저장
	
	Q_QnaPage qna_mq_list(HashMap<String, Object> map);
}
