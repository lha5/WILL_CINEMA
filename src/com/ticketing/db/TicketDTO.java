package com.ticketing.db;

import java.security.Timestamp;
import java.sql.Date;

public class TicketDTO{
	private int book_num;
	private String id;
	private String pass;
	private int movie_num;
	private int cinema_num;
	private String seat;
	private String room;
	private Date date;
	private String runnging_time;
	private String payment; 
	private int price;
	private Date sell_date;
	private String person_num;
	private String day;
	
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getPerson_num() {
		return person_num;
	}
	public void setPerson_num(String person_num) {
		this.person_num = person_num;
	}
	public int getBook_num() {
		return book_num;
	}
	public void setBook_num(int book_num) {
		this.book_num = book_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public int getMovie_num() {
		return movie_num;
	}
	public void setMovie_num(int movie_num) {
		this.movie_num = movie_num;
	}
	public int getCinema_num() {
		return cinema_num;
	}
	public void setCinema_num(int cinema_num) {
		this.cinema_num = cinema_num;
	}
	public String getSeat() {
		return seat;
	}
	public void setSeat(String seat) {
		this.seat = seat;
	}
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getRunnging_time() {
		return runnging_time;
	}
	public void setRunnging_time(String runnging_time) {
		this.runnging_time = runnging_time;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
	
	public Date getSell_date() {
		return sell_date;
	}
	public void setSell_date(Date sell_date) {
		this.sell_date = sell_date;
	}
	@Override
	public String toString() {
		return "["+book_num+","+id+","+pass+","+movie_num+","+cinema_num+","+seat+","+room+","+
	date+","+runnging_time+","+payment+","+price+","+sell_date+"]";		
	}
}
