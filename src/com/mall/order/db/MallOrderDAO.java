package com.mall.order.db;

import java.util.List;

public interface MallOrderDAO {
	// 구매 하기
	public void addOrder(MallOrderDTO modto);
	
	// 구매 직후 확인
	public String getOrderDone(String id);
	
	// 내 구매 목록 가져오기
	public List<MallOrderDTO> getOrderList(String id);
	
	// 구매 상세 내역
	public MallOrderDTO orderDetail(String trans_num);
}
