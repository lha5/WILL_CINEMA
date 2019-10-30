package com.ticketing.db;

import java.util.List;

import com.cinema.db.CineDTO;
import com.movie.db.MovieDTO;

public interface TicketDAO {
	public List<CineDTO> getCinemaList();
	
	public CineDTO getSelectList(String cinema);

	//영화 예매순
	public List<MovieDTO> bookRatingList();
	//영화 평점순
	public List<MovieDTO> totalRatingList();
	//선택된 영화 정보
	public MovieDTO getMovie(int num);

}
