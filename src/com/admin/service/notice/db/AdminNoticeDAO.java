package com.admin.service.notice.db;

import java.util.List;


public interface AdminNoticeDAO {
	// 공지사항 글쓰기
	public void insertBoard(AdminNoticeDTO andto);

	// 공지사항 총 게시글 갯수 가져오기
	public int getBoardCount();

	// 공지사항 글 내용 가져오기
	public List<AdminNoticeDTO> getBoardList(int startRow,int pageSize);

	// 공지사항 글 조회수 올리기
	public void updateReadcount(int num);

	// 공지사항 번호에 해당하는 글 내용 가져오기
	public AdminNoticeDTO getBoard(int num);

	// 번호에 해당하는 글 내용 수정
	public int updateBoard(AdminNoticeDTO andto);

	// 번호에 해당하는 글 삭제
	public int deleteNotice(int num, String pass);
}
