package style;

import java.util.List;

import org.springframework.stereotype.Component;

import common.PageVO;

@Component
public class StylePage extends PageVO{
	private List<StyleVO> list;
	
	public List<StyleVO> getList(){
		return list;
	}
	public void setList(List<StyleVO> list) {
		this.list = list;
	}
	

}
