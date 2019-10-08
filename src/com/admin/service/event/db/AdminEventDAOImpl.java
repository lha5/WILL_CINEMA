package com.admin.service.event.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
}
