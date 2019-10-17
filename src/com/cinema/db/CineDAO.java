package com.cinema.db;

import java.util.List;

public interface CineDAO {
	// 영화관 지점 등록
	public void insertCinema(CineDTO cdto);
	
	// 영화관 보여주기
	public List<CineDTO> getCineList();
	
	// 수정할 영화관 내용 가져오기
	public CineDTO getCinema(int location_num);
	
	
	// 등록된 영화관 지점 수정
	public void updateCinema(CineDTO cdto);
	
	// 등록된 영화관 지점 삭제
	public void deleteCinema(int location_num);
	
}
