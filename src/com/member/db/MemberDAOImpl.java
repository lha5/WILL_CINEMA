package com.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//회원관련 DB
public class MemberDAOImpl implements MemberDAO{
	
	Connection con = null;
	PreparedStatement pstmt =null;
	ResultSet rs =null;
	String sql="";
	
	//DB연결
	private Connection getCon() throws Exception{
		//Context 객체 생성
		Context init=new InitialContext();
		//DB연동 이름으로 DB 호출 -> DataSource저장
		DataSource ds= (DataSource)init.lookup("java:comp/env/jdbc/willcinema");
		//연결정보를 가져와서 리턴
		con=ds.getConnection();
		
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

@Override
public MemberDTO getMember(String id){
	MemberDTO mdto = null;
	//정보가지고 오기 
	try {
		con = getCon();
		sql= "select into from member where id=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
	
		rs= pstmt.executeQuery();
		
		if(rs.next()){
			mdto = new MemberDTO();
		
			// 인트는 북 바이 (넘버), 포인트 레벨
		mdto.setAddr(rs.getString("addr"));
		mdto.setBirthday(rs.getString("birthday"));
		mdto.setBook_num(rs.getInt("book_num"));
		mdto.setBuy_num(rs.getInt("buy_num"));
		mdto.setEmail(rs.getString("email"));
		mdto.setId(rs.getString("id"));
		mdto.setLevel(rs.getInt("level"));
		mdto.setMobile(rs.getString("mobile"));
		mdto.setName(rs.getString("name"));
		mdto.setPass(rs.getString("pass"));
		mdto.setPoint(rs.getInt("point"));
		mdto.setPreference(rs.getString("preference"));
		mdto.setReceive(rs.getString("receive"));
		
		}
		
		
		
		
	} catch (Exception e) {
		e.printStackTrace();
	}finally{
		closeDB();
	}
	
	return mdto;
}
	
}



