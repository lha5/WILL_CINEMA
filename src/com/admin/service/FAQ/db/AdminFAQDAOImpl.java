package com.admin.service.FAQ.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.admin.service.notice.db.AdminNoticeDTO;
import com.movie.db.MovieDTO;

//FAQ게시판 DB(관리자전용)
public class AdminFAQDAOImpl implements AdminFAQDAO{
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
	
	//DB 자원해제
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


//insertFAQ
	@Override
	public void insertFAQ(AdminFAQDTO afdto){
		int num = 0;
		try {
			con = getCon();
			
			// 글번호 계산 
			sql = "select max(num) from faq";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			// 글 숫자
			System.out.println("num = "+num);
			
			sql = "insert into "
					+ "faq(num,category,subject,content,image,name,pass) "
					+ "values(?,?,?,?,?,?,?);";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, afdto.getCategory());
			pstmt.setString(3, afdto.getSubject());
			pstmt.setString(4, afdto.getContent());
			pstmt.setString(5, afdto.getImage());
			pstmt.setString(6, afdto.getName());
			pstmt.setString(7, afdto.getPass());
			
			int value = pstmt.executeUpdate();
			
			System.out.println("게시판 글 저장 완료 "+value+"개");	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	//insertFAQ

	//getFAQCount();
	@Override
	public int getFAQCount() {
		
		int count = 0;
		
		try {
			con=getCon();
			sql="select count(*) from faq";
			pstmt=con.prepareStatement(sql);
			rs= pstmt.executeQuery();
			
			
			if(rs.next()){
				count=rs.getInt(1);
			}
			
		} catch (Exception e) {

			e.printStackTrace();
		}finally {
			closeDB();
		}
		System.out.println("글의 개수" +count);
		return count;
	}

	//getFAQCount();
	
	
	
	@Override
	public List<AdminFAQDTO> getFAQList(int startRow, int pageSize) {
		List<AdminFAQDTO> FAQList = new ArrayList<AdminFAQDTO>();
		
		try {
			con = getCon();
		
			sql="select * from faq order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
		
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				AdminFAQDTO  afdto = new AdminFAQDTO();
				
				afdto.setNum(rs.getInt("num"));
				afdto.setSubject(rs.getString("subject"));
				afdto.setContent(rs.getString("content"));
				afdto.setCategory(rs.getString("category"));
				afdto.setImage(rs.getString("image"));
				afdto.setName(rs.getString("name"));
				afdto.setPass(rs.getString("pass"));
			
				FAQList.add(afdto);
			
			}
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} finally{
		closeDB();
	}
	System.out.println("글목록가지고옴");
	return FAQList;
}
	
	@Override
	public void updateReadcount(int num) {
		try {
			con = getCon();
		
			sql = "update faq set readcount=readcount+1 where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			int value = pstmt.executeUpdate();
		System.out.println("조회수 증가 " +value);
		} catch (Exception e) {
		
			e.printStackTrace();
		}finally{
			closeDB();
		}
	}

	@Override
	public AdminFAQDTO getFAQ(int num) {
	AdminFAQDTO afdto = null;	
		
	
	 try {
		con= getCon();
		sql="select * from faq where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, num);
		
		rs= pstmt.executeQuery();
		if(rs.next()){
			afdto = new AdminFAQDTO();
			afdto.setName(rs.getString("name"));
			afdto.setPass(rs.getString("pass"));
			afdto.setCategory(rs.getString("category"));
			afdto.setContent(rs.getString("content"));
			afdto.setImage(rs.getString("image"));
			afdto.setNum(rs.getInt("num"));
			afdto.setSubject(rs.getString("subject"));
			
		}
		
	 } catch (Exception e) {

		e.printStackTrace();
	}finally {
		closeDB();
	}
	System.out.println("게시판 글 저장 "+ afdto);
	
		return afdto;
	}
	
	//getBoard(int num)
	
	
	
	

	@Override
	public int updateFAQ(AdminFAQDTO afdto) {
		int check=-1;
		try {
			con = getCon();
			sql = "select pass from faq where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, afdto.getNum());
			rs = pstmt.executeQuery();

		if(rs.next()){
			if(afdto.getPass().equals(rs.getString("pass"))){
				sql="update faq set category=?, content=?, image=?, subject=? where num=? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, afdto.getCategory());
				pstmt.setString(2, afdto.getContent());
				pstmt.setString(3, afdto.getImage());
				pstmt.setString(4, afdto.getSubject());
				pstmt.setInt(5, afdto.getNum());
			
				check = pstmt.executeUpdate();
			
				
			}else{// afdto. if
				check=0;
			}
			}else{//rs. if
				check=-1;
			}
			System.out.println("FAQ수정함!"+check);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return check;
	}

	@Override
	public int deleteFAQ(int num, String pass) {
	int check = 1;
		
	
	try {
		con = getCon();
		sql = "select pass from faq where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, num);			
		rs = pstmt.executeQuery(); 
		
		if(rs.next()){
			if(pass.equals(rs.getString("pass"))){
				sql="delete from faq where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				check=pstmt.executeUpdate();
			}else{
				check=0;
			}
		}else{
			check =-1;
		}
	} catch (Exception e) {	
		e.printStackTrace();
	}finally {
		closeDB();
	}
		return check;
	}

	@Override
	public int getBoardCount() {
int count = 0;
		
		try {
			con = getCon();
			
			sql = "select count(*) from faq";
			
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

	@Override
	public List<AdminFAQDTO> getBoardList() {
	List<AdminFAQDTO> FAQList = new ArrayList<AdminFAQDTO>();
		
		try {
			con = getCon();
			
			sql = "select * from faq";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				AdminFAQDTO afdto = new AdminFAQDTO();
				
				afdto.setContent(rs.getString("content"));
				afdto.setImage(rs.getString("image"));
				afdto.setSubject(rs.getString("subject"));
				afdto.setName(rs.getString("name"));
				FAQList.add(afdto);
				System.out.println(afdto+"나오나");
			}
			
		} catch (Exception e) { 	
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return FAQList;
	}
	
	

	
	
	
	
	
}
	
	
	
	

