package com.cinema.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//영화관DB
public class CineDAOImpl implements CineDAO{
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

	
	
	// 영화관 등록
	@Override
	public void insertCinema(CineDTO cdto) {
		int location_num = 0;
		
		try {
			con = getCon();
			
			sql = "SELECT MAX(location_num) FROM cinema";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				location_num = rs.getInt(1) + 1;
			} else {
				location_num = 1;
			}
			
			sql = "INSERT INTO cinema(location_num, region, name, addr, room, tel, image)"
					+ " VALUES(?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, location_num);
			pstmt.setString(2, cdto.getRegion());
			pstmt.setString(3, cdto.getName());
			pstmt.setString(4, cdto.getRoom());
			pstmt.setString(5, cdto.getTel());
			pstmt.setString(6, cdto.getImage());
			
			pstmt.executeUpdate();
			
			System.out.println("관리자 영화관 지점 등록 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
}
