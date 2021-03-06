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

    /*--------------------- 영화관 정보 --------------------*/
	@Override
	public List<CineDTO> getCinemaList(int region_num) {
		List<CineDTO> cineList = new ArrayList<CineDTO>();
		try {
			con = getCon();
			
			sql = "SELECT * FROM cinema where region_num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, region_num);
			
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
				mdto.setGrade(rs.getString("grade"));
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
				mdto.setGrade(rs.getString("grade"));

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
				mdto.setGrade(rs.getString("grade"));
				mdto.setStory(rs.getString("story"));
				mdto.setRunning_time(rs.getInt("running_time"));
				mdto.setDirector(rs.getString("director"));
				mdto.setActor(rs.getString("actor"));
				mdto.setCountry(rs.getString("country"));
				mdto.setPoster(rs.getString("poster"));
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
		int cnt=0;
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
			
			while (rs.next()) {
				if(cnt==0){
					seat=rs.getString("seat");	
				}else{
					seat+=","+rs.getString("seat");
				}
				cnt++;
			}
			
		} catch (Exception e) { 	
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return seat;
	}
	/*------------------- 영화 예약된 좌석 --------------------*/

	/*------------------- 티켓예매 정보 저장 --------------------*/
	@Override
	public void setTicket(TicketDTO tdto) {
		int num = 0;
		try {
			con = getCon();

			sql = "select max(book_num) from book";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt(1) + 1;
			} else {
				num = 1;
			}

			sql = "insert into book(book_num,id,pass,movie_num,cinema_num,seat,room,date,day,"
					+ "running_time,person_num,payment,price,sell_date) " + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, tdto.getId());
			pstmt.setString(3, tdto.getPass());
			pstmt.setInt(4, tdto.getMovie_num());
			pstmt.setInt(5, tdto.getCinema_num());
			pstmt.setString(6, tdto.getSeat());
			pstmt.setString(7, tdto.getRoom());
			pstmt.setDate(8, tdto.getDate());
			pstmt.setString(9, tdto.getDay());
			pstmt.setString(10, tdto.getRunnging_time());
			pstmt.setString(11, tdto.getPerson_num());
			pstmt.setString(12, tdto.getPayment());
			pstmt.setInt(13, tdto.getPrice());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	/*------------------- 티켓예매 정보 저장 --------------------*/

	
	// 예매 내역 리스트 -------------------------------------------
	@Override
	public List<TicketDTO> getTicketingList() {
		List<TicketDTO> bookList = new ArrayList<TicketDTO>();
		try {
			con = getCon();
			
			sql = "SELECT book_num, sell_date, date, movie_num FROM book";
			
			pstmt = con.prepareStatement(sql);
						
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				TicketDTO tdto = new TicketDTO();
				
				tdto.setBook_num(rs.getInt("book_num"));
				tdto.setSell_date(rs.getDate("sell_date"));
				tdto.setDate(rs.getDate("date"));
				tdto.setMovie_num(rs.getInt("movie_num"));
				
				bookList.add(tdto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		System.out.println("예매 내역 리스트 불러오기 성공");
		return bookList;
	}

	
	// 예매 리스트(사용자)
	@Override
	public List<TicketDTO> getMyBookList(String id) {
		List<TicketDTO> bookList = new ArrayList<TicketDTO>();
		try {
			con = getCon();
			
			sql = "SELECT book_num, sell_date, date, movie_num FROM book WHERE id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
						
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				TicketDTO tdto = new TicketDTO();
				
				tdto.setBook_num(rs.getInt("book_num"));
				tdto.setSell_date(rs.getDate("sell_date"));
				tdto.setDate(rs.getDate("date"));
				tdto.setMovie_num(rs.getInt("movie_num"));
				
				bookList.add(tdto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		System.out.println(id + "님의 예매 내역 리스트 불러오기 성공, 값 : " + bookList);
		return bookList;
	}
	

	// 예매 내역 상세
	@Override
	public TicketDTO getBookDetail(int book_num) {
		TicketDTO tdto = null;
		try {
			con = getCon();
			
			sql = "SELECT * FROM book WHERE book_num = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, book_num);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				tdto = new TicketDTO();
				
				tdto.setBook_num(book_num);
				tdto.setCinema_num(rs.getInt("cinema_num"));
				tdto.setDate(rs.getDate("date"));
				tdto.setDay(rs.getString("day"));
				tdto.setId(rs.getString("id"));
				tdto.setMovie_num(rs.getInt("movie_num"));
				tdto.setPass(rs.getString("pass"));
				tdto.setPayment(rs.getString("payment"));
				tdto.setPerson_num(rs.getString("person_num"));
				tdto.setPrice(rs.getInt("price"));
				tdto.setRoom(rs.getString("room"));
				tdto.setRunnging_time(rs.getString("running_time"));
				tdto.setSeat(rs.getString("seat"));
				tdto.setSell_date(rs.getDate("sell_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		System.out.println("예매 내역 상세 데이터 저장 완료");
		return tdto;
	}

}
