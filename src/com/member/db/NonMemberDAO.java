package com.member.db;

import java.sql.Connection;

import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.ResultSet;

import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class NonMemberDAO {
	
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
	public int login(String name, String email) {
		
		try {
			con = getCon();
			
			sql = "SELECT email FROM non_member WHERE name = ?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, name);

			rs = pstmt.executeQuery();

			if(rs.next()) {

				if(rs.getString(1).equals(email))

					return 1; // 로그인 성공

				else

					return 0; // 비밀번호 틀림

			}

			return -1; // 아이디 없음

		} catch (Exception e) {

			e.printStackTrace();

		}

		return -2; // 데이터베이스 오류

	}

	

	public int join(NonMemberDTO user) {
		int check = -1;
		try {
			con = getCon();
			
			sql = "INSERT INTO non_member(name,birthday,email,email_hash,email_checked) VALUES (?, ?, ?, ?, 0)";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, user.getName());

			pstmt.setString(2, user.getBirthday());

			pstmt.setString(3, user.getEmail());

			pstmt.setString(4, user.getEmail_hash());

			pstmt.executeUpdate();
			
			check = 0;

		} catch (Exception e) {

			e.printStackTrace();
			
		}
		
		return check;
		
	}

	

	public String getUserEmail(String name) {

		try {
			con = getCon();
			
			sql = "SELECT email FROM non_member WHERE name = ?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, name);

			rs = pstmt.executeQuery();

			while(rs.next()) {

				return rs.getString(1); // 이메일 주소 반환

			}

		} catch (Exception e) {

			e.printStackTrace();

		}

		return null; // 데이터베이스 오류

	}

	

	public boolean getUserEmailChecked(String name) {

		try {
			
			con = getCon();
			
			sql = "SELECT email_checked FROM non_member WHERE name = ?";

			PreparedStatement pstmt = con.prepareStatement(sql);

			pstmt.setString(1, name);

			rs = pstmt.executeQuery();

			while(rs.next()) {

				return rs.getBoolean(1); // 이메일 등록 여부 반환

			}

		} catch (Exception e) {

			e.printStackTrace();

		}

		return false; // 데이터베이스 오류

	}

	

	public boolean setUserEmailChecked(String name) {

		try {
			
			con = getCon();
			
			sql = "UPDATE non_member SET email_checked = 1 WHERE name = ?";
			
			PreparedStatement pstmt = con.prepareStatement(sql);

			pstmt.setString(1, name);

			pstmt.executeUpdate();

			return true; // 이메일 등록 설정 성공

		} catch (Exception e) {

			e.printStackTrace();

		}

		return false; // 이메일 등록 설정 실패

	}

}
