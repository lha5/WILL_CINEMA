package com.admin.service.event.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//이벤트 관리 DB(관리자)
public class AdminEventDAOImpl implements AdminEventDAO{
	Connection con = null;
	PreparedStatement pstmt =null;
	ResultSet rs =null;
	String sql="";
	
	//DB 연결
	private Connection getCon() throws Exception{
		//Context 객체 생성
		Context init=new InitialContext();
		
		//DB연동 이름으로 DB 호출 -> DataSource저장
		DataSource ds= (DataSource)init.lookup("java:comp/env/jdbc/will_cinema");
		
		//연결정보를 가져와서 리턴
		con=ds.getConnection();
		
		//System.out.println("DB 접속 완료 : " + con);
		
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
	
	/*-------------------- 이벤트 작성(관리자) --------------------*/
	public void eventInsert(AdminEventDTO aedto){
		int num=0;
		try {
			con=getCon();
			
			sql="select max(num) from event";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				num=rs.getInt(1)+1;
			}else{
				num=1;
			}
			
			sql="insert into event(num,category,subject,image,f_date,e_date) "
					+ "values(?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, aedto.getCategory());
			pstmt.setString(3, aedto.getSubject());
			pstmt.setString(4, aedto.getImage());
			pstmt.setDate(5, aedto.getF_date());
			pstmt.setDate(6, aedto.getE_date());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/*-------------------- 이벤트 작성(관리자) --------------------*/
	
	/*-------------------- 이벤트 리스트 가져오기(사용자) --------------------*/
	public List<AdminEventDTO> getGoodsList(String item){
		List<AdminEventDTO> arr=new ArrayList<AdminEventDTO>();
		try {
			con=getCon();
			String sql = "select * from event where category=? order by f_date desc";
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, item);

			rs=pstmt.executeQuery();
			
			while(rs.next()){
				AdminEventDTO aedto = new AdminEventDTO();
				aedto.setNum(rs.getInt("num"));
				aedto.setCategory(rs.getString("category"));
				aedto.setSubject(rs.getString("subject"));
				aedto.setImage(rs.getString("image"));
				aedto.setF_date(rs.getDate("f_date"));
				aedto.setE_date(rs.getDate("e_date"));
				arr.add(aedto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return arr;
	}
	/*-------------------- 이벤트 리스트 가져오기(사용자) --------------------*/
	
	/*-------------------- 이벤트 내용 가져오기(사용자) --------------------*/
	public AdminEventDTO getEvent(int eventId){
		AdminEventDTO aedto = new AdminEventDTO();
		try {
			con=getCon();
			sql="select * from event where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, eventId);
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				aedto.setCategory(rs.getString("category"));
				aedto.setSubject(rs.getString("subject"));
				aedto.setF_date(rs.getDate("f_date"));
				aedto.setE_date(rs.getDate("e_date"));
				aedto.setImage(rs.getString("image"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}

		return aedto;
	}
	/*-------------------- 이벤트 내용 가져오기(사용자) --------------------*/
}
