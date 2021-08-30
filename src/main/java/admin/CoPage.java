package admin;

import java.util.List;

import org.springframework.stereotype.Component;

import common.PageVO;

@Component
public class CoPage extends PageVO{
	private List<CoVO> list;

	public List<CoVO> getList() {
		return list;
	}

	public void setList(List<CoVO> list) {
		this.list = list;
	}
	
	
	
	
}
