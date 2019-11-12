package com.admin.movie.db;

public interface AdminMovieDAO {
	// 영화 내용 작성
	public void insertBoard(AdminMovieDTO mdto);
	
	// 영화 글 갯수 가져오기
	public int getBoardCount();
	
	// 영화 내용 수정
	public int updateBoard(AdminMovieDTO mdto);
	
	// 영화 삭제
	public int deleteBoard(int movie_num);
	
	// 영화 이미지 가져오기
	public String getPoster(int movie_num);
}
