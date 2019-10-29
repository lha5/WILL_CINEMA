package com.cinema.db;

public class CineDTO {
	private int region_num;
	private int cinema_num;
	private String region;
	private String name;
	private String room;
	private String seat;
	private String addr;
	private String tel;
	private String start_times;
	private String end_times;
	private String start_priod;
	private String end_priod;
	private String movie_num;
	
	
	
	
	@Override
	public String toString() {
		
		return "번호 :"+cinema_num+", 지역번호 :"+region_num+", 지역 :"+region+", 지점명:"+name+", 관수 :"+room+
				", 좌석수 :"+seat+", 주소 :"+addr+", 전화번호 :"+tel+
				", 시작시간 :"+start_times+", 종료시간 :"+end_times+
				", 시작일 :"+start_priod+", 종료일 :"+end_priod+", 영화번호 :"+movie_num;
	}

	public int getRegion_num() {
		return region_num;
	}
	public void setRegion_num(int region_num) {
		this.region_num = region_num;
	}
	public int getCinema_num() {
		return cinema_num;
	}
	public void setCinema_num(int cinema_num) {
		this.cinema_num = cinema_num;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public String getSeat() {
		return seat;
	}
	public void setSeat(String seat) {
		this.seat = seat;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getStart_times() {
		return start_times;
	}
	public void setStart_times(String start_times) {
		this.start_times = start_times;
	}
	public String getEnd_times() {
		return end_times;
	}
	public void setEnd_times(String end_times) {
		this.end_times = end_times;
	}
	public String getStart_priod() {
		return start_priod;
	}
	public void setStart_priod(String start_priod) {
		this.start_priod = start_priod;
	}
	public String getEnd_priod() {
		return end_priod;
	}
	public void setEnd_priod(String end_priod) {
		this.end_priod = end_priod;
	}
	public String getMovie_num() {
		return movie_num;
	}
	public void setMovie_num(String movie_num) {
		this.movie_num = movie_num;
	}
	
	
	
	
	
	
	
}
