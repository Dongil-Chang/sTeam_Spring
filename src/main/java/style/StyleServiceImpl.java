package style;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class StyleServiceImpl implements StyleService{
	@Autowired private StyleDAO dao;

	@Override
	public StylePage style_list(StylePage page) {
		return dao.style_list(page);
	}

	@Override
	public StyleVO style_detail(int id) {
		return dao.style_detail(id);
	}

	@Override
	public int style_read(int id) {
		return dao.style_read(id);
	}

	@Override
	public int style_update(StyleVO vo) {
		return dao.style_update(vo);
	}


	@Override
	public int style_insert(StyleVO vo) {
		return dao.style_insert(vo);
	}

	@Override
	public int style_delete(int id) {
		return dao.style_delete(id);
	}
	
	@Override
	public StylePage style_ms_list(HashMap<String, Object> map) {
		return dao.style_ms_list(map);
	}

}
