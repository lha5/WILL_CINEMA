package com.review.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MovieReviewDAOImpl implements MovieReviewDAO {
	// 레퍼런스 준비
	Connection con = null;
	
	PreparedStatement pstmt = null;
	
	ResultSet rs = null;
	
	String sql = "";



	// DB 연결
	private Connection getCon() throws Exception {
		Context init = new InitialContext();
		
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/will_cinema");
		
		con = ds.getConnection();

		return con;
	}



	// DB 자원 해제
	public void closeDB() {
		try {
			if (rs != null) {rs.close();}
			
			if (pstmt != null) {pstmt.close();}
			
			if (con != null) {con.close();}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}



	// 리뷰 작성
	@Override
	public void writeComment(MovieReviewDTO mrdto) {
		// TODO Auto-generated method stub
		
	}



	// 리뷰 목록
	@Override
	public List<MovieReviewDTO> commentList(int startRow, int pageSize) {
		// TODO Auto-generated method stub
		return null;
	}



	// 리뷰 수정
	@Override
	public int modifyComment(String id, String pass) {
		// TODO Auto-generated method stub
		return 0;
	}



	// 리뷰 삭제
	@Override
	public int deleteComment(String id, String pass) {
		// TODO Auto-generated method stub
		return 0;
	}
}
