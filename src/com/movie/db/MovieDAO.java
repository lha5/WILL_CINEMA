package com.movie.db;

import java.util.List;

import com.admin.movie.db.AdminMovieDTO;

public interface MovieDAO {
	// 영화 리스트 가져오기
	public List<AdminMovieDTO> getBoardList();
	
	// 영화 상세 페이지 가져오기
	public AdminMovieDTO getBoard(int num);	
	
	// 영화 검색
	public List<AdminMovieDTO> getSearch(String searchType,String search,int startRow,int pageSize);
}
