package com.ticketing.db;

import java.util.List;

import com.admin.movie.db.AdminMovieDTO;
import com.cinema.db.CineDTO;

public interface TicketDAO {
	public List<CineDTO> getCinemaList();
	
	public CineDTO getSelectList(String cinema);
	
	public CineDTO getSelectList(int cinema_num);

	//영화 예매순
	public List<AdminMovieDTO> bookRatingList();
	//영화 평점순
	public List<AdminMovieDTO> totalRatingList();
	//선택된 영화 정보
	public AdminMovieDTO getMovie(int num);

	//선택한 날짜의 예매 정보
	public List<TicketDTO> getTicketList(String date);
}
