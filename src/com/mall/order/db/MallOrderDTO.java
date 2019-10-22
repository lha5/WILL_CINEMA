package com.mall.order.db;

import java.sql.Date;

public class MallOrderDTO {
	private int order_num;	//주문번호
	private String order_id;	//주문자 아이디
	private int order_goods_num;	//제품번호
	private int price;			//가격
	private String payment;		//구매방법(카드?)
	private int goods_amount;	//구매량
	private Date order_date;	//구매날짜
	private String goods_name;
	
	
	
	
	public String getGoods_name() {
		return goods_name;
	}
	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public int getOrder_goods_num() {
		return order_goods_num;
	}
	public void setOrder_goods_num(int order_goods_num) {
		this.order_goods_num = order_goods_num;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public int getGoods_amount() {
		return goods_amount;
	}
	public void setGoods_amount(int goods_amount) {
		this.goods_amount = goods_amount;
	}
	
	
}
