package com.admin.movie.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//영화 관리 DB
public class AdminMovieDAOImpl implements AdminMovieDAO{
	Connection con = null;
	PreparedStatement pstmt =null;
	ResultSet rs =null;
	String sql="";
	
	//DB연결
	private Connection getCon() throws Exception{
		//Context 객체 생성
		Context init=new InitialContext();
		
		//DB연동 이름으로 DB 호출 -> DataSource저장
		DataSource ds= (DataSource)init.lookup("java:comp/env/jdbc/will_cinema");
		
		//연결정보를 가져와서 리턴
		con=ds.getConnection();
		
		System.out.println("DB 접속 완료 : " + con);
		
		return con;
	}
	
	//DB자원해제
	private void closeDB(){
		try{
			if(rs != null){
				rs.close();
			}
			if(pstmt !=null){
				pstmt.close();
			}
			if(con !=null){
				con.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public void insertBoard(AdminMovieDTO mdto) {
		int movie_num = 0;
		
		try {
			con = getCon();
			
			sql = "select max(movie_num) from movie";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				movie_num = rs.getInt(1)+1;
			}
			
			System.out.println("movie_num : " + movie_num);
			

			sql = "insert into movie(title, movie_num, genre, story, running_time, director, actor, open_date, close_date, country, booking_ration,poster,image) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, mdto.getTitle());
			pstmt.setInt(2, movie_num);
			pstmt.setString(3, mdto.getGenre());
			pstmt.setString(4, mdto.getStory());
			pstmt.setInt(5, mdto.getRunning_time());
			pstmt.setString(6, mdto.getDirector());
			pstmt.setString(7, mdto.getActor());
			pstmt.setDate(8, mdto.getOpen_date());
			pstmt.setDate(9, mdto.getClose_date());
			pstmt.setString(10, mdto.getCountry());
			pstmt.setDouble(11, 0);
			pstmt.setString(12, mdto.getPoster());
			pstmt.setString(13, mdto.getImage());
			
			pstmt.executeUpdate();
			
			System.out.println("영화 작성 완료, 글 번호 : " + movie_num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}

	
	
	@Override
	public int getBoardCount() {
		int count = 0;
		
		try {
			con = getCon();
			
			sql = "select count(*) from movie";
			
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
		System.out.println("DB-movie 테이블에 있는 모든 글의 갯수 : " + count + "개");
		return count;
	}
	
	

	@Override
	public int updateBoard(AdminMovieDTO mdto) {
		int check = -1;
		
		try {
			con = getCon();
			
			// System.out.println("movie_num : " + mdto.getMovie_num());
			
			sql = "select title from movie where movie_num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mdto.getMovie_num());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {// check = 1;
				sql = "update movie set title=? ,genre=?, country=?, running_time=?, director=?, story=?, actor=? where movie_num=?";
					
				pstmt = con.prepareStatement(sql);
					
				pstmt.setString(1, mdto.getTitle());
				pstmt.setString(2, mdto.getGenre());
				pstmt.setString(3, mdto.getCountry());
				pstmt.setInt(4, mdto.getRunning_time());
				pstmt.setString(5, mdto.getDirector());
				pstmt.setString(6, mdto.getStory());
				pstmt.setString(7, mdto.getActor());
				pstmt.setInt(8, mdto.getMovie_num());
				
				check = pstmt.executeUpdate();
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

	
	
	@Override
	public int deleteBoard(int movie_num) {
		int check = -1;
		try {
			con = getCon();
			
			sql = "select title from movie where movie_num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, movie_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				sql = "delete from movie where movie_num=?";
					
				pstmt = con.prepareStatement(sql);
					
				pstmt.setInt(1, movie_num);
					
				check = pstmt.executeUpdate();
			}else{
				check = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return check;
	}
	
}
