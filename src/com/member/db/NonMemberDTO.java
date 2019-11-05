package com.member.db;

public class NonMemberDTO {
	private int num;
	private String name;
	private String birthday;
	private String mobile;
	private String email;
	private int book_num;
	private int email_checked;
	private String email_hash;
	
	public String getEmail_hash() {
		return email_hash;
	}
	public void setEmail_hash(String email_hash) {
		this.email_hash = email_hash;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getBook_num() {
		return book_num;
	}
	public void setBook_num(int book_num) {
		this.book_num = book_num;
	}
	public int getEmail_checked() {
		return email_checked;
	}
	public void setEmail_checked(int email_checked) {
		this.email_checked = email_checked;
	}
	
	public NonMemberDTO(String name, String birth, String email,

			String email_hash, int email_checked) {

		this.name = name;

		this.birthday = birth;

		this.email = email;

		this.email_hash = email_hash;

		this.email_checked = email_checked;

	}

	
	
}
