package com.movie.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.service.QnA.db.QnADTO;

//영화 DB
public class MovieDAOImpl implements MovieDAO{
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
	
	public void insertBoard(MovieDTO mdto) {
		int movie_num = 0;
		try {
			con = getCon();
			
			sql = "select max(movie_num) from movie";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				movie_num = rs.getInt(1)+1;
			}
			System.out.println("movie_num : "+movie_num);
			
			sql = "insert into movie(movie_num,name,genre,story,running_time,director,actor,open_date,country,booking_ration,poster,image) values(?,?,?,?,?,?,?,?,?,?,?,?);";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, movie_num);
			pstmt.setString(2, mdto.getName());
			pstmt.setString(3, mdto.getGenre());
			pstmt.setString(4, mdto.getStory());
			pstmt.setInt(5, mdto.getRunning_time());
			pstmt.setString(6, mdto.getDirector());
			pstmt.setString(7, mdto.getActor());
			pstmt.setString(8, mdto.getOpen_date());
			pstmt.setString(9, mdto.getCountry());
			pstmt.setDouble(10, mdto.getBooking_ration());
			pstmt.setString(11, mdto.getPoster());
			pstmt.setString(12, mdto.getImage());
			
			int value = pstmt.executeUpdate();
			
			System.out.println("글 저장 완료"+value+"개");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
}
