package com.service.QnA.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//QnA게시판 DB
public class QnADAOImpl implements QnADAO{
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

		//연결정보를 가져와서 리턴.
		con=ds.getConnection();
		
		System.out.println("con : 완료");
		
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
	
	public void insertBoard(QnADTO qadto) {
		int num = 0;
		try {
			con = getCon();
			
			sql = "select max(num) from qna";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			System.out.println("num : "+num);
			
			sql = "insert into qna(num,category,name,pass,subject,content,readcount,date,re_ref,re_lev,re_seq,image,secreat) values(?,?,?,?,?,?,?,now(),?,?,?,?,?);";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, qadto.getCategory());
			pstmt.setString(3, qadto.getName());
			pstmt.setString(4, qadto.getPass());
			pstmt.setString(5, qadto.getSubject());
			pstmt.setString(6, qadto.getContent());
			pstmt.setInt(7, qadto.getReadcount());
			pstmt.setInt(8, qadto.getRe_ref());
			pstmt.setInt(9, qadto.getRe_lev());
			pstmt.setInt(10, qadto.getRe_seq());
			pstmt.setString(11, qadto.getImage());
			pstmt.setString(12, qadto.getSecreat());
			
			int value = pstmt.executeUpdate();
			
			System.out.println("글 저장 완료"+value+"개");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	public int getBoardCount(){
		int count = 0;
		
		try {
			con = getCon();
			
			sql = "select count(*) from qna";
			
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
	
	public List<QnADTO> getBoardList(int startRow,int pageSize) {
		List<QnADTO> boardList = new ArrayList<QnADTO>();
		
		try {
			con = getCon();
			
			sql = "select * from qna order by re_ref desc, re_seq asc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				QnADTO qadto = new QnADTO();
				
				qadto.setNum(rs.getInt("num"));
				qadto.setName(rs.getString("name"));
				qadto.setPass(rs.getString("pass"));
				qadto.setSubject(rs.getString("subject"));
				qadto.setContent(rs.getString("content"));
				qadto.setCategory(rs.getString("category"));
				qadto.setReadcount(rs.getInt("readcount"));
				qadto.setRe_ref(rs.getInt("re_ref"));
				qadto.setRe_lev(rs.getInt("re_lev"));
				qadto.setRe_seq(rs.getInt("re_seq"));
				qadto.setDate(rs.getDate("date"));
				qadto.setImage(rs.getString("image"));
				qadto.setSecreat(rs.getString("secreat"));
				
				boardList.add(qadto);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return boardList;
	}
	
	public void updateReadCount(int num){
		try {
			con = getCon();
			
			sql = "update qna set readcount=readcount+1 where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			int value = pstmt.executeUpdate();
			
			System.out.println("조회수 1증가 글 개수 value : "+value);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
	
	}
	
	public QnADTO getBoard(int num){
		QnADTO qadto = null;
		
		try {
			con = getCon();
			
			sql = "select * from qna where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				
				qadto = new QnADTO();
				qadto.setContent(rs.getString("content"));
				qadto.setCategory(rs.getString("category"));
				qadto.setDate(rs.getDate("date"));
				qadto.setImage(rs.getString("image"));
				qadto.setName(rs.getString("name"));
				qadto.setNum(rs.getInt("num"));
				qadto.setPass(rs.getString("pass"));
				qadto.setRe_lev(rs.getInt("re_lev"));
				qadto.setRe_ref(rs.getInt("re_ref"));
				qadto.setRe_seq(rs.getInt("re_seq"));
				qadto.setReadcount(rs.getInt("readcount"));
				qadto.setSubject(rs.getString("subject"));
			}
			
			System.out.println("게시판 글 저장 : "+qadto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return qadto;
	}
	
	public int updateBoard(QnADTO qadto){
		int check = -1;
		
		try {
			con = getCon();
			
			System.out.println(qadto.getNum());
			
			sql = "select pass from qna where num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qadto.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(qadto.getPass().equals(rs.getString("pass"))){
					sql = "update qna set name=? ,subject=?, content=?, category=?,image=? where num=?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, qadto.getName());
					pstmt.setString(2, qadto.getSubject());
					pstmt.setString(3, qadto.getContent());
					pstmt.setString(4, qadto.getCategory());
					pstmt.setString(5, qadto.getImage());
					pstmt.setInt(6, qadto.getNum());
					
					check = pstmt.executeUpdate();
					// check = 1;
				}else{
					check = 0;
				}
				
			}else{
				check = -1;
			}
			
			System.out.println("글 수정 동작 완료 : "+check);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return check;
		
	}
	
public int deleteBoard(int num,String pass){
		
		int check = -1;
		
		try {
			con = getCon();
			
			sql = "select pass from qna where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){
					
					sql = "delete from qna where num=?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setInt(1, num);
					
					check = pstmt.executeUpdate();
					
				}else{
					check = 0;
				}
				
			}else{
				check = -1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return check;
		
	}

	public List<QnADTO> getSearch(String search,int startRow,int pageSize) {
		List<QnADTO> boardList = new ArrayList<QnADTO>();
		
		try {
			con = getCon();
			
			sql = "select * from qna where subject like ?";
			pstmt = con.prepareStatement(sql);
			
			System.out.println(search);
			
			pstmt.setString(1, "%"+search+"%");
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				QnADTO qadto = new QnADTO();
				
				qadto.setNum(rs.getInt("num"));
				qadto.setName(rs.getString("name"));
				qadto.setPass(rs.getString("pass"));
				qadto.setSubject(rs.getString("subject"));
				qadto.setContent(rs.getString("content"));
				qadto.setCategory(rs.getString("category"));
				qadto.setReadcount(rs.getInt("readcount"));
				qadto.setRe_ref(rs.getInt("re_ref"));
				qadto.setRe_lev(rs.getInt("re_lev"));
				qadto.setRe_seq(rs.getInt("re_seq"));
				qadto.setDate(rs.getDate("date"));
				qadto.setImage(rs.getString("image"));
				qadto.setSecreat(rs.getString("secreat"));
				
				boardList.add(qadto);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return boardList;
	}
	
}	

