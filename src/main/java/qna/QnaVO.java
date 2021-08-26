package qna;

import java.sql.Date;

public class QnaVO {
	private String q_title, q_content, q_writer, q_type, q_filename, q_filepath, q_name;
	private int q_id, q_readcnt, q_root, q_step, q_indent, no;
	private Date q_writedate;
	
	
	
	
	public String getQ_name() {
		return q_name;
	}
	public void setQ_name(String q_name) {
		this.q_name = q_name;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
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
	public String getQ_type() {
		return q_type;
	}
	public void setQ_type(String q_type) {
		this.q_type = q_type;
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
	public Date getQ_writedate() {
		return q_writedate;
	}
	public void setQ_writedate(Date q_writedate) {
		this.q_writedate = q_writedate;
	}
	
	
	


}

	

