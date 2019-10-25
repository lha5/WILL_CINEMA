package com.ticketing.db;

import java.util.List;

import com.cinema.db.CineDTO;
import com.movie.db.MovieDTO;

public interface TicketDAO {
	public List<CineDTO> getCinemaList();
	
	public List<MovieDTO> getMovieList();
}
