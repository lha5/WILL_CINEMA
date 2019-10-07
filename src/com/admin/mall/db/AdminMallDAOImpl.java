package com.admin.mall.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//쇼핑(mall) 관리 페이지
public class AdminMallDAOImpl implements AdminMallDAO{
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

	
	//관리자 제품 등록
	@Override
	public void insertGoodsMall(AdminMallDTO amdto) {
		int num = 0;
		try {
			con = getCon();
			sql = "select max(goods_num) from goods";
			pstmt=con.prepareStatement(sql);
			
			if(rs.next()){
				num=rs.getInt(1)+1;
			}else{
				num=1;
			}
			
			sql = "insert into goods values(?,?,?,?,?,?)";
			//(goods_num,category,name,content,price,image)
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, amdto.getCategory());
			pstmt.setString(3, amdto.getName());
			pstmt.setString(4, amdto.getContent());
			pstmt.setInt(5, amdto.getPrice());
			pstmt.setString(6, amdto.getImage());
			
			pstmt.executeUpdate();
			
			System.out.println("관리자 상품 등록 성공");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}
	//insertGoodsMall(AdminMallDTO amdto)
	
	
	
	
}//AdminMallDAOImpl