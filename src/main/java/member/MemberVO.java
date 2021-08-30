package member;



public class MemberVO {
	private int no;		// 고객관리 페이지 row num 을 사용하기위해 선언
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	
	private String name, id, pw, addr, tel, gender, email, post, admin;
	private String birth, social_email, social_type;
	
	
	/* 안드로이드 ==========================================================================================*/
	
	public MemberVO (){};	//안드로이드 사용을 위한 기본생성자

	//안드로이드 사용을 위한 생성자
	public MemberVO(String name, String id, String pw, String addr, String tel, String gender, String email,
			String post) {
		super();
		this.name = name;
		this.id = id;
		this.pw = pw;
		this.addr = addr;
		this.tel = tel;
		this.gender = gender;
		this.email = email;
		this.post = post;
	}
	
	/* 안드로이드 ==========================================================================================*/
	
	
	public String getSocial_email() {
		return social_email;
	}
	public void setSocial_email(String social_email) {
		this.social_email = social_email;
	}
	public String getSocial_type() {
		return social_type;
	}
	public void setSocial_type(String social_type) {
		this.social_type = social_type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr.replace(",", "|");
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		//010,1235,5678 -> 010-1235-5678 
		this.tel = tel.replace(",", "-");
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
}
