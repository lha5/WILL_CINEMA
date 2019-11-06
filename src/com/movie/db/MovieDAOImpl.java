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
import com.admin.movie.db.AdminMovieDTO;
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
	
	// getBoardList
	@Override
	public List<AdminMovieDTO> getBoardList() {
		List<AdminMovieDTO> boardList = new ArrayList<AdminMovieDTO>();
		try {
			con = getCon();

			sql = "select * from movie";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				AdminMovieDTO amdto = new AdminMovieDTO();

				amdto.setMovie_num(rs.getInt("movie_num"));
				amdto.setTitle(rs.getString("title"));
				amdto.setGenre(rs.getString("genre"));
				amdto.setStory(rs.getString("story"));
				amdto.setRunning_time(rs.getInt("running_time"));
				amdto.setDirector(rs.getString("director"));
				amdto.setActor(rs.getString("actor"));
				amdto.setCountry(rs.getString("country"));
				amdto.setPoster(rs.getString("poster"));
				amdto.setImage(rs.getString("image"));

				boardList.add(amdto);
			}

		} catch (Exception e) { 	
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return boardList;
	}



	@Override
	public List<AdminMovieDTO> getSearch(String searchType, String search, int startRow, int pageSize) {
		List<AdminMovieDTO> boardList = new ArrayList<AdminMovieDTO>();
		try {
			con = getCon();
			if(searchType.equals("title")){
				sql = "select * from movie where title like ?";	
			}else if(searchType.equals("genre")){
				sql = "select * from movie where genre like ?";	
			}else if(searchType.equals("director")){
				sql = "select * from movie where director like ?";
			}else if(searchType.equals("actor")){
				sql = "select * from movie where actor like ?";
			}

			pstmt = con.prepareStatement(sql);

			System.out.println("영화 검색 실행, 검색 범주 : " + searchType + ", 키워드 : " + search);

			pstmt.setString(1, "%"+search+"%");

			rs = pstmt.executeQuery();

			while (rs.next()){
				AdminMovieDTO amdto= new AdminMovieDTO();

				amdto.setMovie_num(rs.getInt("movie_num"));
				amdto.setTitle(rs.getString("title"));
				amdto.setGenre(rs.getString("genre"));
				amdto.setStory(rs.getString("story"));
				amdto.setRunning_time(rs.getInt("running_time"));
				amdto.setDirector(rs.getString("director"));
				amdto.setActor(rs.getString("actor"));
				amdto.setOpen_date(rs.getDate("open_date"));
				amdto.setClose_date(rs.getDate("close_date"));
				amdto.setCountry(rs.getString("country"));
				amdto.setBooking_ration(rs.getDouble("booking_ration"));
				amdto.setPoster(rs.getString("poster"));
				amdto.setImage(rs.getString("image"));

				boardList.add(amdto);
			}
		} catch (Exception e) {

			e.printStackTrace();
		}finally{
			closeDB();
		}
		return boardList;
	}
	
	
	// getBoard(num)
	@Override
	public AdminMovieDTO getBoard(int num) {
		AdminMovieDTO amdto = null;

		try {
			con = getCon();

			sql = "select * from movie where movie_num=?";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			
			if (rs.next()) {
				amdto = new AdminMovieDTO();
				
				amdto.setTitle(rs.getString("title"));
				amdto.setActor(rs.getString("actor"));
				amdto.setBooking_ration(rs.getDouble("booking_ration"));
				amdto.setCountry(rs.getString("country"));
				amdto.setDirector(rs.getString("director"));
				amdto.setGenre(rs.getString("genre"));
				amdto.setImage(rs.getString("image"));
				amdto.setMovie_num(rs.getInt("movie_num"));
				amdto.setPoster(rs.getString("poster"));
				amdto.setRunning_time(rs.getInt("running_time"));
				amdto.setStory(rs.getString("story"));
				amdto.setOpen_date(rs.getDate("open_date"));
				amdto.setClose_date(rs.getDate("close_date"));
			}	
		} catch (Exception e) {

			e.printStackTrace();
		}finally{
			closeDB();
		}
		System.out.println("게시판 글 저장: " + amdto);
		return amdto;
	}
}
