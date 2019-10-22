package com.cinema.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
		int cinema_num = 0;
		
		try {
			con = getCon();
			
			sql = "SELECT MAX(cinema_num) FROM cinema";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				cinema_num = rs.getInt(1) + 1;
			} else {
				cinema_num = 1;
			}
			
			sql = "INSERT INTO cinema"
					+ "(cinema_num, region, name, room, seat, addr, tel, "
					+ "start_times, end_times, start_priod, end_priod, movie_num)"
					+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, cinema_num);
			pstmt.setString(2, cdto.getRegion());
			pstmt.setString(3, cdto.getName());
			pstmt.setString(4, cdto.getRoom());
			pstmt.setString(5, cdto.getSeat());
			pstmt.setString(6, cdto.getAddr());
			pstmt.setString(7, cdto.getTel());
			pstmt.setString(8, cdto.getStart_times());
			pstmt.setString(9, cdto.getEnd_times());
			pstmt.setString(10, cdto.getStart_priod());
			pstmt.setString(11, cdto.getEnd_priod());
			//
			pstmt.setString(12, cdto.getMovie_num());
			
			pstmt.executeUpdate();
			
			System.out.println("관리자 영화관 지점 등록 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}

	
	
	// 등록된 지점 목록 보여주기
	@Override
	public List<CineDTO> getCineList() {
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
				cdto.setStart_priod(rs.getString("end_priod"));
				
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

	
	
	//수정할 영화관 가져오기
	@Override
	public CineDTO getCinema(int cinema_num) {
		CineDTO cdto = null;
		
		try {
			con = getCon();
			sql = "select * from cinema where cinema_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cinema_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cdto = new CineDTO();
				
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
				cdto.setStart_priod(rs.getString("end_priod"));
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
		return cdto;
	}

	
	//영화관 지점 수정
	@Override
	public void updateCinema(CineDTO cdto) {
		try {
			con = getCon();
			
			sql = "update cinema "
					+ "set "
					+ "where cinema_num=?";
			
			pstmt = con.prepareStatement(sql);
			
			
			
			
			pstmt.executeUpdate();
			
			System.out.println("관리자 영화관 지점 수정 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}

	
	//영화관 지점 삭제
	@Override
	public void deleteCinema(int location_num) {
		try {
			con = getCon();
			sql = "delete from cinema where cinema_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, location_num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
	}
	
}
