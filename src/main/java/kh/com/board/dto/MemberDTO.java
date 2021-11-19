package kh.com.board.dto;

import java.text.SimpleDateFormat;

public class MemberDTO {

	private String id;
	private String password;
	private String nickname;
	private String phone;
	private String address;
	private String signup_date;
	
	public MemberDTO() {}
	
	public MemberDTO(String id, String password, String nickname, String phone, String address, long signup_date) {
		super();
		this.id = id;
		this.password = password;
		this.nickname = nickname;
		this.phone = phone;
		this.address = address;
		this.signup_date = toStringDate(signup_date);
	}
	
	public String toStringDate(long date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return sdf.format(date);
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getSignup_date() {
		return signup_date;
	}
	public void setSignup_date(long signup_date) {
		this.signup_date = toStringDate(signup_date);
	}
	
	
}
