package android;

import java.io.PrintWriter;
import java.security.Provider.Service;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import board.BoardService;
import board.BoardServiceImpl;
import board.BoardVO;


@Controller
public class And_CommunityController {
   @Autowired BoardServiceImpl service;
   
   
      //커뮤니티 목록화면 요청
      @ResponseBody
      @RequestMapping("/And_commuSelect")
      public void community(HttpServletResponse res) throws Exception {
            
         List<BoardVO> list = service.commuList();
               
          common_gson(res, list);
      

      }
   
      
      
      
      
	  public void common_gson(HttpServletResponse res, BoardVO vo) throws Exception {
	       Gson gson = new Gson(); 
	       String json = gson.toJson(vo);
	       PrintWriter out;
	       out = res.getWriter();
	       out.println(json);
	  }
           
	   
     public void common_gson(HttpServletResponse res, List<BoardVO> list) throws Exception {
        Gson gson = new Gson(); 
        String json = gson.toJson(list);
        PrintWriter out;
        res.setCharacterEncoding("UTF-8");
        res.setContentType("text/html; charset=utf-8"); 
        out = res.getWriter();
        out.println(json);
     }
         
         
         
         
         
         
         
         
         
         
}


