package common;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.MultiPartEmail;
import org.apache.commons.mail.SimpleEmail;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class CommonService {
	
	
	//파일다운로드처리
	public void fileDownload(String filename, String filepath
							, HttpSession session, HttpServletResponse response) {
		File file = new File( session.getServletContext()
							.getRealPath("resources") + "/" + filepath );
		String mime = session.getServletContext().getMimeType(filename);
		response.setContentType(mime);
		
		try {
			filename = URLEncoder.encode(filename, "utf-8").replaceAll("\\+", "%20");
			response.setHeader("content-disposition"
								, "attachment; filename=" + filename);
			ServletOutputStream out = response.getOutputStream();
			FileCopyUtils.copy( new FileInputStream(file), out);
			out.flush();
			
		}catch(Exception e) { }
	}
	
	
	//파일업로드처리
	public String fileUpload(String category, MultipartFile file, HttpSession session ) {
		//업로드할 위치
		String resources = session.getServletContext().getRealPath("resources");
		//  D:\Study_Spring\WorkSpace\.metadata\.plugins\....\iot\resources
		String folder = resources + "/upload/" + category + "/" 
					+ new SimpleDateFormat("yyyy/MM/dd").format(new Date());
		String uuid = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
		
		File dir = new File( folder );
		if( ! dir.exists() ) dir.mkdirs();
		try {
			file.transferTo( new File(folder, uuid) );
		}catch(Exception e) { }
		//upload/notice/2021/07/27/afdbhk32ggh_abc.txt
		return folder.substring( resources.length()+1 ) + "/" + uuid ;
	}
	
	
	
	public Map<String, Object> json_requestAPI(StringBuffer url) {
		JSONObject json = new JSONObject( requestAPI(url) );
		json = json.getJSONObject("response");
		json = json.getJSONObject("body");
		int count = 0;
		if( json.has("totalCount") ) count = json.getInt("totalCount");
		if( json.get("items") instanceof JSONObject ) {
			json = json.getJSONObject("items");
		}
		json.put("count", count);
		return json.toMap();
	}
	
	public String requestAPI(StringBuffer url, String property) {
		String result = "";
	    try {
	        HttpURLConnection con 
	        	= (HttpURLConnection)new URL(url.toString()).openConnection();
	        con.setRequestMethod("GET");
	        con.setRequestProperty("Authorization", property);
	        
	        int responseCode = con.getResponseCode();
	        BufferedReader br;
	        if(responseCode >= 200 && responseCode <= 300)  { // 정상 호출
	          br = new BufferedReader(
	        		  new InputStreamReader(con.getInputStream(), "utf-8" ));
	        } else {  // 에러 발생
	          br = new BufferedReader(
	        		  new InputStreamReader(con.getErrorStream(), "utf-8"));
	        }
	        String inputLine;
	        StringBuffer res = new StringBuffer();
	        while ((inputLine = br.readLine()) != null) {
	          res.append(inputLine);
	        }
	        br.close();
	        con.disconnect();
	        result = res.toString();
	        
	      } catch (Exception e) {
	        System.out.println(e.getMessage());
	      }
	    return result;
	}
	
	public String requestAPI(StringBuffer url) {
		String result = "";
		try {
			HttpURLConnection con 
			= (HttpURLConnection)new URL(url.toString()).openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode >= 200 && responseCode <= 300) { // 정상 호출
				br = new BufferedReader(
						new InputStreamReader(con.getInputStream(), "utf-8" ));
			} else {  // 에러 발생
				br = new BufferedReader(
						new InputStreamReader(con.getErrorStream(), "utf-8"));
			}
			String inputLine;
			StringBuffer res = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			con.disconnect();
			result = res.toString();
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
}
