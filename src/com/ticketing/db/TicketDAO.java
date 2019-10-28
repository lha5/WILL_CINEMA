package com.ticketing.db;

import java.util.List;

import com.cinema.db.CineDTO;
import com.movie.db.MovieDTO;

public interface TicketDAO {
	public List<CineDTO> getCinemaList();
	
	//영화 예매순
	public List<MovieDTO> bookRatingList();
	//영화 평점순
	public List<MovieDTO> totalRatingList();
}
