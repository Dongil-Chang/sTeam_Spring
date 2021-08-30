package review;

import java.util.List;

import org.springframework.stereotype.Component;

import common.PageVO;



@Component
public class ReviewPage extends PageVO{
	private List<ReviewVO> list;

	public List<ReviewVO> getList() {
		return list;
	}

	public void setList(List<ReviewVO> list) {
		this.list = list;
	}
	
}
