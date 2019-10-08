package com.admin.mall.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
		return con = ds.getConnection();
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
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
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

	
	
	//제품 리스트 가져오기
	@Override
	public List<AdminMallDTO> getGoodsList() {
		List<AdminMallDTO> goodsList = new ArrayList<AdminMallDTO>();
		try {
			con = getCon();
			
			sql = "select * from goods";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				AdminMallDTO amdto = new AdminMallDTO();
				
				
				amdto.setGoods_num(rs.getInt("goods_num"));
				amdto.setCategory(rs.getString("category"));
				amdto.setName(rs.getString("name"));
				amdto.setContent(rs.getString("content"));
				amdto.setPrice(rs.getInt("price"));
				amdto.setImage(rs.getString("image"));
				
				goodsList.add(amdto);
				
				
			}
			
			System.out.println("(관리자)제품 목록 가져오기 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
		return goodsList;
	}
	//getGoodsList()

	
	//제품 가져오기
	@Override
	public AdminMallDTO getGoods(int num) {
		AdminMallDTO amdto = null;
		try {
			con = getCon();
			sql= "select * from goods where goods_num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				amdto = new AdminMallDTO();
				
				amdto.setGoods_num(rs.getInt("goods_num"));
				amdto.setCategory(rs.getString("category"));
				amdto.setName(rs.getString("name"));
				amdto.setContent(rs.getString("content"));
				amdto.setPrice(rs.getInt("price"));
				amdto.setImage(rs.getString("image"));

			}
			
			System.out.println("상품 "+num+"번 가져오기 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
		return amdto;
	}
	//getGoods(num)

	
	//제품 수정
	@Override
	public void modifyGoodsMall(AdminMallDTO amdto) {
		try {
			con = getCon();
			
			sql = "update goods "
					+ "set category=?, name=?, content=?, price=?, image=? "
					+ "where goods_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, amdto.getCategory());
			pstmt.setString(2, amdto.getName());
			pstmt.setString(3, amdto.getContent());
			pstmt.setInt(4, amdto.getPrice());
			pstmt.setString(5, amdto.getImage());
			pstmt.setInt(6, amdto.getGoods_num());
			
			pstmt.executeUpdate();
			
			System.out.println("(관리자)제품 수정 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
	}
	//modifyGoodsMall(amdto)

	
	//제품 삭제
	@Override
	public void deleteGoodsMall(int num) {
		try {
			con = getCon();
			sql = "delete from goods where goods_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
	}
	//deleteGoodsMall(num)
	
	
	
	
}//AdminMallDAOImpl