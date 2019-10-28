package com.ticketing.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.cinema.db.CineDTO;
import com.movie.db.MovieDTO;

//예매 DB
public class TicketDAOImpl implements TicketDAO{
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
    /*--------------------- 영화관 정보 --------------------*/
	@Override
	public List<CineDTO> getCinemaList() {
		List<CineDTO> cineList = new ArrayList<CineDTO>();
		try {
			con = getCon();
			
			sql = "SELECT * FROM cinema";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				CineDTO cdto = new CineDTO();
				
				cdto.setCinema_num(rs.getInt("cinema_num"));
				cdto.setRegion(rs.getString("region"));
				cdto.setName(rs.getString("name"));
				cdto.setRoom(rs.getString("room"));
				cdto.setSeat(rs.getString("seat"));
				cdto.setAddr(rs.getString("addr"));
				cdto.setTel(rs.getString("tel"));
				cdto.setStart_times(rs.getString("start_times"));
				cdto.setEnd_times(rs.getString("end_times"));
				cdto.setStart_priod(rs.getString("start_priod"));
				cdto.setEnd_priod(rs.getString("end_priod"));
				cdto.setMovie_num(rs.getString("movie_num"));
				
				cineList.add(cdto);
			}
			
			System.out.println("cineList 목록 저장 완료------------------------------");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return cineList;
	}
	 /*--------------------- 영화관 정보 --------------------*/

	 /*--------------------- 영화 예매순 --------------------*/
	@Override
	public List<MovieDTO> bookRatingList() {
		List<MovieDTO> movieList = new ArrayList<MovieDTO>();
		
		try {
			con = getCon();
			
			sql = "select * from movie order by booking_ration desc";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MovieDTO mdto = new MovieDTO();
				
				mdto.setMovie_num(rs.getInt("movie_num"));
				mdto.setTitle(rs.getString("title"));
				mdto.setGrade(rs.getInt("grade"));
				mdto.setGenre(rs.getString("genre"));
				mdto.setStory(rs.getString("story"));
				mdto.setRunning_time(rs.getInt("running_time"));
				mdto.setDirector(rs.getString("director"));
				mdto.setActor(rs.getString("actor"));
				mdto.setCountry(rs.getString("country"));
				
				movieList.add(mdto);
				
			}
			
		} catch (Exception e) { 	
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return movieList;
	}
	/*--------------------- 영화 예매순 --------------------*/
	
	/*--------------------- 영화 평점순 --------------------*/
	@Override
	public List<MovieDTO> totalRatingList() {
		List<MovieDTO> movieList = new ArrayList<MovieDTO>();
		
		try {
			con = getCon();
			
			sql = "select * from movie order by total_rating desc";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MovieDTO mdto = new MovieDTO();
				
				mdto.setMovie_num(rs.getInt("movie_num"));
				mdto.setTitle(rs.getString("title"));
				mdto.setGrade(rs.getInt("grade"));
				mdto.setGenre(rs.getString("genre"));
				mdto.setStory(rs.getString("story"));
				mdto.setRunning_time(rs.getInt("running_time"));
				mdto.setDirector(rs.getString("director"));
				mdto.setActor(rs.getString("actor"));
				mdto.setCountry(rs.getString("country"));
				
				movieList.add(mdto);
				
			}
			
		} catch (Exception e) { 	
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return movieList;
	}
	/*--------------------- 영화 평점순 --------------------*/
}
