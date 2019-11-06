package com.ticketing.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.admin.movie.db.AdminMovieDTO;
import com.cinema.db.CineDTO;
import com.movie.db.MovieDTO;
import com.mysql.fabric.xmlrpc.base.Array;

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
				
				cdto.setRegion_num(rs.getInt("region_num"));
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

  
	/*--------------------- 선택된 영화관 정보 (영화관 명)--------------------*/
	 @Override
	public CineDTO getSelectList(String cinema) {
		 CineDTO cdto=new CineDTO();
		 try {
				con = getCon();
				
				sql = "SELECT * FROM cinema where name=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, cinema);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					cdto.setRegion_num(rs.getInt("region_num"));
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
				}
				
				System.out.println("cineList 목록 저장 완료------------------------------");
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			return cdto;
	}
	 /*--------------------- 영화관 정보 (영화관 명)--------------------*/
	 
	 /*--------------------- 선택된 영화관 정보(영화관 번호) --------------------*/
	 @Override
	public CineDTO getSelectList(int cinema_num) {
		 CineDTO cdto=new CineDTO();
		 try {
				con = getCon();
				
				sql = "SELECT * FROM cinema where cinema_num=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cinema_num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					cdto.setRegion_num(rs.getInt("region_num"));
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
				}
				
				System.out.println("cineList 목록 저장 완료------------------------------");
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			return cdto;
	}
	 /*--------------------- 영화관 정보(영화관 번호) --------------------*/

	/*--------------------- 영화 예매순 --------------------*/
	@Override
	public List<AdminMovieDTO> bookRatingList() {

		List<AdminMovieDTO> movieList = new ArrayList<AdminMovieDTO>();
		
		try {
			con = getCon();
			
			sql = "select * from movie order by booking_ration desc";

			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				AdminMovieDTO mdto = new AdminMovieDTO();
				
				mdto.setMovie_num(rs.getInt("movie_num"));
				mdto.setTitle(rs.getString("title"));
				mdto.setGenre(rs.getString("genre"));
				mdto.setStory(rs.getString("story"));
				mdto.setRunning_time(rs.getInt("running_time"));
				mdto.setDirector(rs.getString("director"));
				mdto.setActor(rs.getString("actor"));
				mdto.setCountry(rs.getString("country"));
				mdto.setGrade(rs.getInt("grade"));
				mdto.setTotal_rating(rs.getDouble("total_rating"));
				mdto.setBooking_ration(rs.getDouble("booking_ration"));
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
	public List<AdminMovieDTO> totalRatingList() {
		List<AdminMovieDTO> movieList = new ArrayList<AdminMovieDTO>();
		
		try {
			con = getCon();
			
			sql = "select * from movie order by total_rating desc";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				AdminMovieDTO mdto = new AdminMovieDTO();
				
				mdto.setMovie_num(rs.getInt("movie_num"));
				mdto.setTitle(rs.getString("title"));
				mdto.setGenre(rs.getString("genre"));
				mdto.setStory(rs.getString("story"));
				mdto.setRunning_time(rs.getInt("running_time"));
				mdto.setDirector(rs.getString("director"));
				mdto.setActor(rs.getString("actor"));
				mdto.setCountry(rs.getString("country"));
				mdto.setGrade(rs.getInt("grade"));

				mdto.setTotal_rating(rs.getDouble("total_rating"));
				mdto.setBooking_ration(rs.getDouble("booking_ration"));

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

	/*--------------------- 선택된 영화 정보 --------------------*/
	@Override
	public AdminMovieDTO getMovie(int num) {
		AdminMovieDTO mdto = new AdminMovieDTO();
		
		try {
			con = getCon();
			
			sql = "select * from movie where movie_num=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				mdto.setMovie_num(rs.getInt("movie_num"));
				mdto.setTitle(rs.getString("title"));
				mdto.setGenre(rs.getString("genre"));
				mdto.setGrade(rs.getInt("grade"));
				mdto.setStory(rs.getString("story"));
				mdto.setRunning_time(rs.getInt("running_time"));
				mdto.setDirector(rs.getString("director"));
				mdto.setActor(rs.getString("actor"));
				mdto.setCountry(rs.getString("country"));			
			}
			
		} catch (Exception e) { 	
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return mdto;
	}
	/*--------------------- 선택된 영화 정보 --------------------*/

	/*------------------- 선택한 날짜의 예매 정보 --------------------*/
	@Override
	public List<TicketDTO> getTicketList(String date) {
		List<TicketDTO> tlist=new ArrayList();
		try {
			con = getCon();
			
			sql = "select * from book where date=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				TicketDTO tdto=new TicketDTO();
				
				tdto.setBook_num(rs.getInt("book_num"));
				tdto.setId(rs.getString("id"));
				tdto.setPass(rs.getString("pass"));
				tdto.setMovie_num(rs.getInt("movie_num"));
				tdto.setCinema_num(rs.getInt("cinema_num"));
				tdto.setSeat(rs.getString("seat"));
				tdto.setRoom(rs.getString("room"));
				tdto.setDate(rs.getDate("date"));
				tdto.setRunnging_time(rs.getString("running_time"));
				tdto.setPayment(rs.getString("payment"));
				tdto.setPrice(rs.getInt("price"));
				tdto.setSell_date(rs.getDate("sell_date"));
				System.out.println("저장 날짜"+tdto.getDate());
				tlist.add(tdto);
			}
		} catch (Exception e) { 	
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return tlist;
	}
	/*------------------- 선택한 날짜의 예매 정보 --------------------*/

	/*------------------- 영화 예약된 좌석 --------------------*/
	@Override
	public String getSeatNum(int cinema_num, int movie_num, int roomNum, String running_date, String running_time) {
		String seat="";
		try {
			con = getCon();
			
			sql = "select * from book where cinema_num=? and movie_num=? and "
					+ "room=? and date=? and running_time=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cinema_num);
			pstmt.setInt(2, movie_num);
			pstmt.setInt(3, roomNum);
			pstmt.setString(4, running_date);
			pstmt.setString(5, running_time);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				seat=rs.getString("seat");	
			}
			
		} catch (Exception e) { 	
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return seat;
	}
	/*------------------- 영화 예약된 좌석 --------------------*/


}
