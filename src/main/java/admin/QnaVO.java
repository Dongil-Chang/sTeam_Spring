package admin;

import java.sql.Date;

public class QnaVO {
	
	private int q_id, q_readcnt, no
	, q_root	  // 원글의 root를 그대로 담는다 ( 답글을 처리하기 위해서 사용)
	, q_step	  // 동일한 root를 갖는 글에 대해 원글의 step 보다 더 큰 step 을 가진 경우 step - 1 로 변경한 후
			  // 원글의 step + 1 로 저장한다 
	
	, q_indent; // 원글의 indent + 1 을 저장한다 ( 답글을 처리하기 위해서 사용)

	private String q_title, q_content, q_writer, q_filename, q_filepath, q_type, q_name;
	private Date q_writedate;
	
	
	
	public int getQ_id() {
		return q_id;
	}
	public void setQ_id(int q_id) {
		this.q_id = q_id;
	}
	public int getQ_readcnt() {
		return q_readcnt;
	}
	public void setQ_readcnt(int q_readcnt) {
		this.q_readcnt = q_readcnt;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getQ_root() {
		return q_root;
	}
	public void setQ_root(int q_root) {
		this.q_root = q_root;
	}
	public int getQ_step() {
		return q_step;
	}
	public void setQ_step(int q_step) {
		this.q_step = q_step;
	}
	public int getQ_indent() {
		return q_indent;
	}
	public void setQ_indent(int q_indent) {
		this.q_indent = q_indent;
	}
	public String getQ_title() {
		return q_title;
	}
	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}
	public String getQ_content() {
		return q_content;
	}
	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}
	public String getQ_writer() {
		return q_writer;
	}
	public void setQ_writer(String q_writer) {
		this.q_writer = q_writer;
	}
	public String getQ_filename() {
		return q_filename;
	}
	public void setQ_filename(String q_filename) {
		this.q_filename = q_filename;
	}
	public String getQ_filepath() {
		return q_filepath;
	}
	public void setQ_filepath(String q_filepath) {
		this.q_filepath = q_filepath;
	}
	public String getQ_type() {
		return q_type;
	}
	public void setQ_type(String q_type) {
		this.q_type = q_type;
	}
	public String getQ_name() {
		return q_name;
	}
	public void setQ_name(String q_name) {
		this.q_name = q_name;
	}
	public Date getQ_writedate() {
		return q_writedate;
	}
	public void setQ_writedate(Date q_writedate) {
		this.q_writedate = q_writedate;
	}
	
	
	
	
	
	
	
}
