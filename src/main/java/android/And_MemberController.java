package android;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import member.MemberServiceImpl;
import member.MemberVO;

@Controller
public class And_MemberController {
	   @Autowired
	   private MemberServiceImpl service;

       @ResponseBody
	   @RequestMapping("/And_Signup")
	   public void And_member_insert(MemberVO vo, HttpServletResponse res) throws Exception {
    	   System.out.println("/And_Signup");    	   
    	   
    	   String name = vo.getName();
    	   String id = vo.getId();
		   String pw = vo.getPw();
		   String addr = vo.getAddr();
		   String tel = vo.getTel();
		   String gender = vo.getGender(); 
		   String email = vo.getEmail();
		   String post = vo.getPost();
		   vo = new MemberVO(name, id, pw, addr, tel, gender, email, post);
		   service.And_member_insert(vo);
		      
		   common_gson(res, vo);
	   }
       
       
       
       @ResponseBody
       @RequestMapping("/And_IdChk")
       public String join_idChk(String id, HttpServletResponse res) throws Exception {
          
    	 System.out.printf("id [%s] :  [%s] \n" , id,  String.valueOf(service.join_idChk(id)) );
          return String.valueOf(service.join_idChk(id));

    // 아래 2줄 추가 주석 (08/03 18:45)      
//           MemberVO vo = service.member_id_check(id);
//          
//           common_gson(res, vo);
           
       }

       
       @ResponseBody
       @RequestMapping("/And_loginChk")
       public String login_Check(String id, String pw, HttpServletResponse res) throws Exception {
    	   System.out.println("/And_loginChk");
    	   
    	   MemberVO vo = new MemberVO();
    	   vo.setId(id);
    	   vo.setPw(pw);
    	   
    	   return String.valueOf(service.login_Check(vo));
    	   
    	   
       }
       
       
	
	
	 public void common_gson(HttpServletResponse res, MemberVO vo) throws Exception {
	      Gson gson = new Gson(); 
	      String json = gson.toJson(vo);
	      PrintWriter out;
	      out = res.getWriter();
	      out.println(json);
	   }
	   //	   
	   public void common_gson(HttpServletResponse res, List<MemberVO> vo) throws Exception {
	      Gson gson = new Gson(); 
	      String json = gson.toJson(vo);
	      PrintWriter out;
	      out = res.getWriter();
	      out.println(json);
	   }


}



