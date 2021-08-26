package review;

public class ReviewReplyVO {
	private int rp_id, rp_pid;
	private String rp_writer, rp_content, rp_writedate, name;
	
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getRp_id() {
		return rp_id;
	}
	public void setRp_id(int rp_id) {
		this.rp_id = rp_id;
	}
	public int getRp_pid() {
		return rp_pid;
	}
	public void setRp_pid(int rp_pid) {
		this.rp_pid = rp_pid;
	}
	public String getRp_writer() {
		return rp_writer;
	}
	public void setRp_writer(String rp_writer) {
		this.rp_writer = rp_writer;
	}
	public String getRp_content() {
		return rp_content;
	}
	public void setRp_content(String rp_content) {
		this.rp_content = rp_content;
	}
	public String getRp_writedate() {
		return rp_writedate;
	}
	public void setRp_writedate(String rp_writedate) {
		this.rp_writedate = rp_writedate;
	}
	
	
}

