package com.admin.service.event.db;

import java.sql.Date;

public class AdminEventDTO {
	private int num;
	private String category;
	private String subject;
	private String image;
	private Date f_date;
	private Date e_date;
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public Date getF_date() {
		return f_date;
	}
	public void setF_date(Date f_date) {
		this.f_date = f_date;
	}
	public Date getE_date() {
		return e_date;
	}
	public void setE_date(Date e_date) {
		this.e_date = e_date;
	}
	@Override
	public String toString() {
		return "["+num+","+category+","+subject+","+image+","+f_date+","+e_date+"]";
	}
	
	
}
