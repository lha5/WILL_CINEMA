package com.cinema.db;

import java.util.List;

public interface CineDAO {
	// 영화관 지점 등록
	public void insertCinema(CineDTO cdto);
	
	// 영화관 개수 가져오기
	public int getCount();
	
	// 영화관 보여주기
	//public List<CineDTO> getCineList();
	public List<CineDTO> getCineList(int startRow,int pageSize);
	
	// 수정할 영화관 내용 가져오기
	public CineDTO getCinema(int cinema_num);
	
	
	// 등록된 영화관 지점 수정
	public void updateCinema(CineDTO cdto);
	
	// 등록된 영화관 지점 삭제
	public void deleteCinema(int cinema_num);
	
	// 지점 번호로 지점 이름 가져오기
	public CineDTO getCineName(int cinema_num);
}
