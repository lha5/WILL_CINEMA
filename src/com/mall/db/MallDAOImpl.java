package com.mall.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//쇼핑 DB
public class MallDAOImpl implements MallDAO{
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

	//상품 리스트 가져오기
	@Override
	public List getGoodsList(String item) {
		List goodsList = new ArrayList();
		
		StringBuffer sql = new StringBuffer();
		try {
			con = getCon();
			
			//상품 목록 가져오기 (전체, 카테고리별(관람권, 스낵/음료))
			
			sql.append("select * from goods");
			if(item.equals("all")){ // 전체
				//sql = "select * from goods";
			}else{ //카테고리별
				sql.append(" where category=?");
			}
			
			
			
			pstmt = con.prepareStatement(sql.toString());
			if(item.equals("all")){ //전체
			}else{ //카테고리별
				pstmt.setString(1, item);
			}
			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MallDTO mdto = new MallDTO();
				
				mdto.setGoods_num(rs.getInt("goods_num"));
				mdto.setCategory(rs.getString("category"));
				mdto.setName(rs.getString("name"));
				mdto.setContent(rs.getString("content"));
				mdto.setPrice(rs.getInt("price"));
				mdto.setImage(rs.getString("image"));
				
				goodsList.add(mdto);
			}//while
			
			System.out.println("(사용자)상품 리스트 저장 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
		return goodsList;
	}
	//getGoodsList(item)
	
	
	//상품 상세 가져오기
	public MallDTO getGoods(int num){
		MallDTO mdto = null;
		
		try {
			con = getCon();
			sql = "select * from goods where goods_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				mdto = new MallDTO();
				
				mdto.setGoods_num(rs.getInt("goods_num"));
				mdto.setCategory(rs.getString("category"));
				mdto.setName(rs.getString("name"));
				mdto.setContent(rs.getString("content"));
				mdto.setPrice(rs.getInt("price"));
				mdto.setImage(rs.getString("image"));
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return mdto;
	}
	//getGoods(num)
	
}
