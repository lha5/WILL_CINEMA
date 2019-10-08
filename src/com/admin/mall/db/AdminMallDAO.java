package com.admin.mall.db;

import java.util.List;

public interface AdminMallDAO {
	
	//(관리자)제품 등록
	public void insertGoodsMall(AdminMallDTO amdto);
	
	//(관리자)제품 리스트 가져오기
	public List<AdminMallDTO> getGoodsList();
	
	//(관리자 수정)제품 가져오기
	public AdminMallDTO getGoods(int num);
	
	//(관리자 수정)제품 수정하기
	public void modifyGoodsMall(AdminMallDTO amdto);
	
	//(관리자)제품 삭제하기
	public void deleteGoodsMall(int num);
	
}
