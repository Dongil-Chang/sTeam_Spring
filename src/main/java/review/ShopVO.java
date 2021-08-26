package review;

import oracle.ucp.jdbc.oracle.DataBasedConnectionAffinityCallback;

public class ShopVO {
	String tel, name, addr, xpos, ypos;

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getXpos() {
		return xpos;
	}

	public void setXpos(String xpos) {
		this.xpos = xpos;
	}

	public String getYpos() {
		return ypos;
	}

	public void setYpos(String ypos) {
		this.ypos = ypos;
	}
	
	
}
