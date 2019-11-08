package com.review.db;

import java.util.List;

public interface MovieReviewDAO {
	// 리뷰 작성
	public void writeComment(MovieReviewDTO mrdto);
	
	// 리뷰 목록
	List<MovieReviewDTO> commentList(int movie_num);
	
	// 리뷰 수정
	int modifyComment(MovieReviewDTO mrdto);
	
	// 리뷰 삭제
	public int deleteComment(int num);

	int commentCount();
	
	//리뷰 가져오기
	public MovieReviewDTO getReview(String id, int movie_num,int num);

	
	
}
