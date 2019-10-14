package com.service.QnA.db;

import java.util.List;

public interface QnADAO {
	// 게시판 글쓰기
	public void insertBoard(QnADTO qadto);
	
	// 게시판에 있는 총 글의 갯수 가져오기
	public int getBoardCount();
	
	// 해당 번호의 게시글 조회수 증가
	public void updateReadCount(int num);
	
	// 게시판 글 목록 가져오기
	public List<QnADTO> getBoardList(int startRow,int pageSize);
	
	// 해당 번호의 게시글 내용 가져오기
	public QnADTO getBoard(int num);
	
	// 게시글 수정
	public int updateBoard(QnADTO qadto);
	
	// 게시글 삭제
	public int deleteBoard(int num,String pass);
}
