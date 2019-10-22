package com.mall.order.db;

import java.util.List;

public interface MallOrderDAO {
	// 주문 하기
	public void addOrder(MallOrderDTO modto);
	
	// 주문 목록 가져오기
	public List<MallOrderDTO> getOrderList(String id);
	
	// 주문 상세 내역
	public List orderDetail(int order_num);
}
