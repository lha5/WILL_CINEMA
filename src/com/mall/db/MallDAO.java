package com.mall.db;

import java.util.List;

public interface MallDAO {
	
	//상품 리스트 가져오기
	public List getGoodsList(String item);
	
	//상품 가져오기
	public MallDTO getGoods(int num);
	
	
}
