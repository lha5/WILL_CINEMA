package com.cinema.db;

public class CineDTO {
	private int location_num;
	private String region;
	private String name;
	private String addr;
	private String room;
	private String tel;
	private String image;
	
	
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public int getLocation_num() {
		return location_num;
	}
	public void setLocation_num(int location_num) {
		this.location_num = location_num;
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
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
}
