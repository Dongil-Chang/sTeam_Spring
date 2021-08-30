package com.hanul.web;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MapController {

	
/* ==================================         JSON 테스트 컨트롤러 */
	
	
//	@ResponseBody
	@RequestMapping("/data")
	public Object data(HttpSession session, Model model, int  pageNo, int pageList) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		JSONObject json = new JSONObject();
		try {
			
			BufferedReader reader = new BufferedReader(new FileReader(session.getServletContext().getRealPath("resources/json")+"/data.json"));
		  String line;
		  StringBuffer buf = new StringBuffer();
  
		  while ((line = reader.readLine()) != null) {
			  buf.append(line);
		  }
		  reader.close();
		  JSONArray total = new JSONArray( buf.toString() );
		  json.put("item", total);
		  json.put("count", total.length() );
			
		  /*                 begin    end(pageNo*pageList)
		   1: 1~10            1        10    
		   2: 11~20          11        20
		   3: 21~30          21        30
		   17: 161 ~ 168   161          170
		   * */
		  
		  int endList = pageNo * pageList - 1;
			
		  // 시작 목록 번호 = 끝 목록번호 - (페이지당 보여질 목록 - 1)
		  int beginList = endList - (pageList - 1);
		  
		  if( endList > total.length() ) endList = total.length() - 1; 
		  
		  json.put("beginList", beginList);
		  json.put("endList", endList);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
//		return json.toMap();
		model.addAttribute("list", json.toMap());
		return "map/list";
	}
	
	
	
	
	
	@RequestMapping(value = "/list.ma")
	public String home(HttpSession session, Model model) {
		session.setAttribute("category", "map");
		
		return "map/data";
	}
	
	
	/* ==================================         JSON 테스트 컨트롤러 */
	
	
}














