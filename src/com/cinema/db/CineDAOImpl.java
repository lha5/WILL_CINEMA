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
					+ "(cinema_num, region_num, region, name, room, seat, addr, tel, "
					+ "start_times, end_times, start_priod, end_priod, movie_num)"
					+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, cinema_num);
			pstmt.setInt(2, cdto.getRegion_num());
			pstmt.setString(3, cdto.getRegion());
			pstmt.setString(4, cdto.getName());
			pstmt.setString(5, cdto.getRoom());
			pstmt.setString(6, cdto.getSeat());
			pstmt.setString(7, cdto.getAddr());
			pstmt.setString(8, cdto.getTel());
			pstmt.setString(9, cdto.getStart_times());
			pstmt.setString(10, cdto.getEnd_times());
			pstmt.setString(11, cdto.getStart_priod());
			pstmt.setString(12, cdto.getEnd_priod());
			//
			pstmt.setString(13, cdto.getMovie_num());
			
			pstmt.executeUpdate();
			
			System.out.println("관리자 영화관 지점 등록 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	//지점 개수 가져오기
	public int getCount(){

		int count = 0;
		
		try {
			con = getCon();
			
			sql="select count(*) from cinema";
			
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
	
	
	// 등록된 지점 목록 보여주기
	@Override
	public List<CineDTO> getCineList(int startRow, int pageSize) {
		List<CineDTO> cineList = new ArrayList<CineDTO>();
		try {
			con = getCon();
			
			sql = "SELECT * FROM cinema order by region_num,cinema_num limit ?,?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				CineDTO cdto = new CineDTO();
				
				cdto.setCinema_num(rs.getInt("cinema_num"));
				cdto.setRegion_num(rs.getInt("region_num"));
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
	// 등록된 지점 목록 보여주기(페이징 처리 없음)
	/*@Override
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
				cdto.setRegion_num(rs.getInt("region_num"));
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

	}*/

	
	
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
				cdto.setRegion_num(rs.getInt("region_num"));
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
					+ "set region_num=?, region=?, name=?, room=?, seat=?, addr=?, tel=?, "
					+ "start_times=?, end_times=?, start_priod=?, end_priod=?, movie_num=? "
					+ "where cinema_num=?";
			
			pstmt = con.prepareStatement(sql);
			
			
			pstmt.setInt(1, cdto.getRegion_num());
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
			pstmt.setString(12, cdto.getMovie_num());
			pstmt.setInt(13, cdto.getCinema_num());
			
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
	public void deleteCinema(int cinema_num) {
		try {
			con = getCon();
			sql = "delete from cinema where cinema_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cinema_num);
			
			pstmt.executeUpdate();
			
			System.out.println("시네마 지점 삭제 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
	}
	
}
