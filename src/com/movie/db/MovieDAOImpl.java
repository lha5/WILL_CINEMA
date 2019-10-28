package com.movie.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.service.QnA.db.QnADTO;

import com.admin.service.notice.db.AdminNoticeDTO;

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


	// getBoard(num)
	@Override
	public MovieDTO getBoard(int num) {
		MovieDTO mdto = null;

		try {
			con = getCon();

			sql = "select * from movie where movie_num=?";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				mdto = new MovieDTO();
				mdto.setTitle(rs.getString("title"));
				mdto.setActor(rs.getString("actor"));
				mdto.setBooking_ration(rs.getDouble("booking_ration"));
				mdto.setCountry(rs.getString("country"));
				mdto.setDirector(rs.getString("director"));
				mdto.setGenre(rs.getString("genre"));
				mdto.setImage(rs.getString("image"));
				mdto.setMovie_num(rs.getInt("movie_num"));
				mdto.setPoster(rs.getString("poster"));
				mdto.setRunning_time(rs.getInt("running_time"));
				mdto.setStory(rs.getString("story"));
				mdto.setOpen_date(rs.getDate("open_date"));
				mdto.setClose_date(rs.getDate("close_date"));
			
			}
			System.out.println("게시판 글 저장: "+mdto);
	
		} catch (Exception e) {

			e.printStackTrace();
		}finally{
			closeDB();
		}
	
		System.out.println("게시판 글 저장: "+mdto);
		return mdto;
	}






	//insert Board
	
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
			

			sql = "insert into movie(title,movie_num,genre,story,running_time,director,actor,open_date,close_date,country,booking_ration,poster,image) "
			+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?);";



			
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
			pstmt.setDouble(11, mdto.getBooking_ration());
			pstmt.setString(12, mdto.getPoster());
			pstmt.setString(13, mdto.getImage());
			
			int value = pstmt.executeUpdate();
			
			System.out.println("글 저장 완료"+value+"개");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	public int getBoardCount(){
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
		
		return count;
	}
	// getBoardList
	
		public List<MovieDTO> getBoardList() {
		List<MovieDTO> boardList = new ArrayList<MovieDTO>();
		
		try {
			con = getCon();
			
			sql = "select * from movie";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MovieDTO mdto = new MovieDTO();
				
				mdto.setMovie_num(rs.getInt("movie_num"));
				mdto.setTitle(rs.getString("title"));
				mdto.setGenre(rs.getString("genre"));
				mdto.setStory(rs.getString("story"));
				mdto.setRunning_time(rs.getInt("running_time"));
				mdto.setDirector(rs.getString("director"));
				mdto.setActor(rs.getString("actor"));
				mdto.setCountry(rs.getString("country"));
				boardList.add(mdto);
				
			}
			
		} catch (Exception e) { 	
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return boardList;
	}

	
	

}







