package review;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired private ReviewDAO dao;
	
	@Override
	public int review_insert(ReviewVO vo) {
		return dao.review_insert(vo);
	}

	@Override
	public ReviewPage review_list(ReviewPage page) {
		return dao.review_list(page);
	}

	@Override
	public ReviewVO review_detail(int id) {
		return dao.review_detail(id);
	}

	@Override
	public int review_read(int id) {
		return dao.review_read(id);
	}

	@Override
	public int review_update(ReviewVO vo) {
		return dao.review_update(vo);
	}

	@Override
	public int review_delete(int id) {
		return dao.review_delete(id);
	}

	@Override
	public int review_reply_insert(ReviewReplyVO vo) {
		return dao.review_reply_insert(vo);
	}

	@Override
	public int review_reply_update(ReviewReplyVO vo) {
		return dao.review_reply_update(vo);
	}

	@Override
	public int review_reply_delete(int id) {
		return dao.review_reply_delete(id);
	}

	@Override
	public List<ReviewReplyVO> review_reply_list(int pid) {
		return dao.review_reply_list(pid);
	}

	
	  @Override public List<ShopVO> review_shop_list() { return
	  dao.review_shop_list(); }
	 

	
	  @Override public ReviewVO review_shopName(String data) { 
		  return dao.review_shopName(data); 
	  }
	 

	  @Override
	  public ReviewPage review_mr_list(HashMap<String, Object> map) {
			return dao.review_mr_list(map);
	 }

	  
	  
	 // 메인 화면에서 사용할 리스트 조회 
	@Override
	public List<ReviewVO> main_review_list() {
		
		return dao.main_review_list();
	}
	

}
