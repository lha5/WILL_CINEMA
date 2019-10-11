package com.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

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

//getmember
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
			mdto.setEmail(rs.getString("email"));
			mdto.setId(rs.getString("id"));
			mdto.setLevel(rs.getInt("level"));
			mdto.setMobile(rs.getString("mobile"));
			mdto.setName(rs.getString("name"));
			mdto.setPass(rs.getString("pass"));
			mdto.setPoint(rs.getInt("point"));
			mdto.setPreference(rs.getString("preference"));
			mdto.setReceive(rs.getString("receive"));
			mdto.setDetailaddr(rs.getString("detailAddr"));
			mdto.setZipcode(rs.getInt("zipcode"));
			mdto.setReg_date(rs.getDate("reg_date"));
		}
		
		
		
		
	} catch (Exception e) {
		e.printStackTrace();
	}finally{
		closeDB();
	}
	
	return mdto;
}
	
//getmember

//updateMember(MemberDTO mdto)

@Override
public int updateMember(MemberDTO mdto){
	int update = 1;
	
	try {
		con = getCon();
		sql="select pass from member where id=?";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs.next()){
			
		}
		
		
		
	} catch (Exception e) {
		e.printStackTrace();
	}finally {
		closeDB();
	}
	
	return update;
}

//updateMember(MemberDTO mdto)

//deleteMember(String id,String pass)

@Override
public int deleteMember(String id,String pass){
	int delete = 1;
	
	try {
		con = getCon();
		sql="select pass from member where id=?";
		pstmt= con.prepareStatement(sql);
		rs= pstmt.executeQuery();
		
		if(rs.next()){
		if(pass.equals(rs.getString("pass"))){
			
			sql= "delete from member where id=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			delete = 1;
		}else{
			delete=0;
		}
		}else{
			delete =-1;
		}
	} catch (Exception e) {
		e.printStackTrace();
	}finally {
		closeDB();
	}
	
	return delete;
}
//deleteMember(String id,String pass)

	





	
	
	@Override
	public void insertMember(MemberDTO mdto) {
		try {
			con = getCon();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}

	//id 체크 (id,pass)
	@Override
	public int idcheck(String id, String pass) {
int idcheck = -1;
		
		try {
			con = getCon();
			
			sql="select pass from member where id=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs= pstmt.executeQuery();
			
			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){
					idcheck= 1;
				}else{
					idcheck=0;
				}
				
			}else{
				idcheck= -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return idcheck;
	}
	
}
//id 체크 (id,pass)
