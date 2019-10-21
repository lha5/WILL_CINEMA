package com.movie.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

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
				
			
				
				
				mdto.setActor(rs.getString("actor"));
				mdto.setBooking_ration(rs.getDouble("booking_ration"));
				mdto.setCountry(rs.getString("country"));
				mdto.setDirector(rs.getString("director"));
				mdto.setGenre(rs.getString("genre"));
				mdto.setImage(rs.getString("image"));
				mdto.setMovie_num(rs.getInt("movie_num"));
				mdto.setName(rs.getString("name"));
				mdto.setOpen_date(rs.getString("open_date"));
				mdto.setPoster(rs.getString("poster"));
				mdto.setRunning_time(rs.getInt("running_time"));
				mdto.setStory(rs.getString("story"));
				
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






}







