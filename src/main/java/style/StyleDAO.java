package style;


import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;


@Repository
public class StyleDAO implements StyleService{
	@Autowired @Qualifier("steam") private SqlSession sql;
	
	@Override
	public int style_insert(StyleVO vo) {
		return sql.insert("style.mapper.insert", vo);
	}

	@Override
	public StylePage style_list(StylePage page) {
		page.setTotalList(sql.selectOne("style.mapper.totalList", page));
		page.setList(sql.selectList("style.mapper.list",page));
		return page;
	}

	@Override
	public StyleVO style_detail(int id) {
		return sql.selectOne("style.mapper.detail",id);
		
	}

	@Override
	public int style_read(int id) {
		return sql.update("style.mapper.update",id);
	}

	@Override
	public int style_update(StyleVO vo) {
		return sql.update("style.mapper.style_update",vo);
	}

	@Override
	public int style_delete(int id) {
		return sql.delete("style.mapper.delete",id);
	}
	
	@Override
	public StylePage style_ms_list(HashMap<String, Object> map) {
		StylePage s_page = (StylePage) map.get("s_page");
		s_page.setTotalList( sql.selectOne("style.mapper.ms_totalList", map) );
		s_page.setList( sql.selectList("style.mapper.ms_list", map) );

		return s_page;
	}

}
