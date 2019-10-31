package com.review.db;

import java.util.List;

public interface MovieReviewDAO {
	// 리뷰 작성
	public void writeComment(MovieReviewDTO mrdto);
	
	// 리뷰 목록
	public List<MovieReviewDTO> commentList();
	
	// 리뷰 수정
	public int modifyComment(String id, String pass);
	
	// 리뷰 삭제
	public int deleteComment(int num);

	int commentCount();

}
