package com.review.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.service.QnA.db.QnADTO;

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
		
		int num = 0;
		
		try {
			con = getCon();
			
			sql = "select max(num) from review";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			System.out.println("num : "+num);
			
			sql = "insert into review(num,movie_num,book_num,rating,content,id,pass,date) values(?,?,?,?,?,?,?,now());";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setInt(2, mrdto.getMovie_num());
			pstmt.setInt(3, mrdto.getBook_num());
			pstmt.setInt(4, mrdto.getRating());
			pstmt.setString(5, mrdto.getContent());
			pstmt.setString(6, mrdto.getId());
			pstmt.setString(7, mrdto.getPass());
			
			
			int value = pstmt.executeUpdate();
			
			System.out.println("글 저장 완료"+value+"개");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}

	@Override
	public int commentCount(){
		int count = 0;
		
		try {
			con = getCon();
			
			sql = "select count(*) from review";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return count;
	}

	// 리뷰 목록
	@Override
	public List<MovieReviewDTO> commentList(int movie_num) {
		
		List<MovieReviewDTO> boardList = new ArrayList<MovieReviewDTO>();
		try {
			con = getCon();
			
			sql = "select * from review where movie_num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, movie_num);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MovieReviewDTO mrdto = new MovieReviewDTO();
				System.out.println("num : "+rs.getInt("num"));
				mrdto.setNum(rs.getInt("num"));
				mrdto.setId(rs.getString("id"));
				mrdto.setPass(rs.getString("pass"));
				mrdto.setRating(rs.getInt("rating"));
				mrdto.setContent(rs.getString("content"));
				mrdto.setDate(rs.getTimestamp("date"));
				
				boardList.add(mrdto);
				
			}
			
		} catch (Exception e) { 	
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return boardList;
		
	}
	
	// 수정할 리뷰 가져오기
	@Override
	public MovieReviewDTO getReview(String id,int movie_num,int num) {
		
		MovieReviewDTO mrdto = new MovieReviewDTO();
		try {
			con = getCon();
			
			sql = "select * from review where id=? and movie_num=? and num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			pstmt.setInt(2, movie_num);
			pstmt.setInt(3, num);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				
				//System.out.println("num : "+rs.getInt("num"));
				mrdto.setNum(rs.getInt("num"));
				mrdto.setId(rs.getString("id"));
				mrdto.setPass(rs.getString("pass"));
				mrdto.setRating(rs.getInt("rating"));
				mrdto.setContent(rs.getString("content"));
				mrdto.setDate(rs.getTimestamp("date"));
				
			}
			
		} catch (Exception e) { 	
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return mrdto;
		
	}

	// 리뷰 수정
	@Override
	public int modifyComment(MovieReviewDTO mrdto) {
		int check = -1;
		
		try {
			con = getCon();
			
			System.out.println(mrdto.getNum());
			
			sql = "select movie_num from review where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mrdto.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				sql = "update review set rating=?, content=? where num=?";
					
				pstmt = con.prepareStatement(sql);
					
				pstmt.setInt(1, mrdto.getRating());
				pstmt.setString(2, mrdto.getContent());
				pstmt.setInt(3, mrdto.getNum());
					
				check = pstmt.executeUpdate();
				// check = 1;
				
			}else{
				check = -1;
			}
			
			System.out.println("글 수정 동작 완료 : "+check);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return check;
	}

	// 리뷰 삭제
	@Override
	public int deleteComment(int num) {
		
		int check = -1;
		
		try {
			con = getCon();
			
			sql = "select movie_num from review where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
					
					sql = "delete from review where num=?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setInt(1, num);
					
					check = pstmt.executeUpdate();
				
			}else{
				check = -1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return check;
	}



	@Override
	public int avgRating(int movie_num) {
		int avg = 0;
		try {
			con = getCon();
			
			sql = "SELECT AVG(rating) AS avgrate FROM review WHERE movie_num = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, movie_num);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				avg = (int) rs.getInt("avgrate");
				System.out.println("평점 값 : " + avg);
			} else {
				avg = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return avg;
	}

}
