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
//getmember
@Override
public MemberDTO getMember(String id){
	MemberDTO mdto = null;
	//정보가지고 오기 
	try {
		con = getCon();
		sql= "select into from will_cinema where id=?";
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
		mdto.setAddrdetail(rs.getString("addrdetail"));
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
	int update = -1;
	
	try {
		con = getCon();
		sql="select pass from will_cinema where id=?";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs.next()){
		if(mdto.getPass().equals(rs.getString("pass"))){
			sql="update will_cinema set name=?, birthday=?, mobile=?, email=?"
					+ "addr=?,addrdetail=?,zipcode=?, receive=? preference=? where id=?";
			pstmt= con.prepareStatement(sql);
			// int = 우편번호 zipcode
			pstmt.setString(1, mdto.getName());
			pstmt.setString(2, mdto.getBirthday());
			pstmt.setString(3, mdto.getMobile());
			pstmt.setString(4, mdto.getEmail());
			pstmt.setString(5, mdto.getAddr());
			pstmt.setString(6, mdto.getAddrdetail());
			pstmt.setInt(7, mdto.getZipcode());
			pstmt.setString(8, mdto.getReceive());
			pstmt.setString(9, mdto.getPreference());
			pstmt.setString(10, mdto.getId());
			
			pstmt.executeUpdate();
			
			update= 1;
		}else{
			update =0;
		}
		}else{
			update =-1;
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
		sql="select pass from will_cinema where id=?";
		pstmt= con.prepareStatement(sql);
		rs= pstmt.executeQuery();
		
		if(rs.next()){
		if(pass.equals(rs.getString("pass"))){
			
			sql= "delete from will_cinema where id=? ";
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
}



