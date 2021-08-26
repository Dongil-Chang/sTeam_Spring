package review;

import java.util.HashMap;
import java.util.List;

public interface ReviewService {
	int review_insert(ReviewVO vo);							//리뷰 신규 저장
	ReviewPage review_list(ReviewPage page); 				//리뷰 목록 조회 - 페이지처리된
	ReviewVO review_detail(int id); 						//리뷰 상세조회
	int review_read(int id);                		        //리뷰 조회수처리
	int review_update(ReviewVO vo);							//리뷰 변경 저장
	int review_delete(int id);               				//리뷰 삭제
	ReviewVO review_shopName(String data);
	List<ShopVO> review_shop_list();
	int review_reply_insert(ReviewReplyVO vo); 				//리뷰 댓글 신규저장처리
	int review_reply_update(ReviewReplyVO vo);				//리뷰 댓글 변경저장처리
	int review_reply_delete(int id);						//리뷰 댓글 삭제처리
	List<ReviewReplyVO> review_reply_list(int pid); 		//리뷰 댓글 목록조회
	
	
	ReviewPage  review_mr_list(HashMap<String, Object> map);
	
	
	// 메인화면에서 사용할 리스트 목록 조회
	List<ReviewVO> main_review_list();
	
	
}
