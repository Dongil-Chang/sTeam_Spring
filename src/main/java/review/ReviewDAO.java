package review;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAO implements ReviewService {
	@Autowired @Qualifier("steam") private SqlSession sql;

	@Override
	public int review_insert(ReviewVO vo) {
		return sql.insert("review.mapper.insert", vo);
	}

	@Override
	public ReviewPage review_list(ReviewPage page) {
		page.setTotalList( sql.selectOne("review.mapper.totalList", page) );
		page.setList( sql.selectList("review.mapper.list", page) );
		return page;
	}

	@Override
	public ReviewVO review_detail(int id) {
		return sql.selectOne("review.mapper.detail", id);
	}

	@Override
	public int review_read(int id) {
		return sql.update("review.mapper.update", id);
	}

	@Override
	public int review_update(ReviewVO vo) {
		return sql.update("review.mapper.review_update", vo);
	}

	@Override
	public int review_delete(int id) {
		return sql.delete("review.mapper.delete", id);
	}

	@Override
	public int review_reply_insert(ReviewReplyVO vo) {
		return sql.insert("review.mapper.reply_insert", vo);
	}

	@Override
	public int review_reply_update(ReviewReplyVO vo) {
		return sql.update("review.mapper.reply_update", vo);
	}

	@Override
	public int review_reply_delete(int id) {
		return sql.delete("review.mapper.reply_delete", id);
	}

	@Override
	public List<ReviewReplyVO> review_reply_list(int pid) {
		return sql.selectList("review.mapper.reply_list" , pid);
	}

	
	@Override public List<ShopVO> review_shop_list() { 
		return sql.selectList("review.mapper.shop_list"); 
	}
	 

	@Override public ReviewVO review_shopName(String data) { 
		return sql.selectOne("review.mapper.shopName", data); 
	}

	
	@Override
	public ReviewPage review_mr_list(HashMap<String, Object> map) {
		ReviewPage r_page = (ReviewPage) map.get("r_page");
		r_page.setTotalList( sql.selectOne("review.mapper.mr_totalList", map) );
		r_page.setList( sql.selectList("review.mapper.mr_list", map) );

		return r_page;
	}

	
	
	
	 // 메인 화면에서 사용할 리스트 조회
	@Override
	public List<ReviewVO> main_review_list() {
		
		return sql.selectList("review.mapper.main_list");
	}
	
	
}
