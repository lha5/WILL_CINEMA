package com.admin.service.notice.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.service.QnA.db.QnADTO;

public class AdminNoticeDAOImpl implements AdminNoticeDAO {
	
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
	private void closeDB() {
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
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	// insertBoard(andto)
	@Override
	public void insertBoard(AdminNoticeDTO andto) {
		int num = 0;
		try {
			con = getCon();

			// 글번호 계산
			sql = "select max(num) from notice";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			
			System.out.println("num = " + num);

			sql = "insert into "
					+ "notice(num,name,pass,subject,content,date,category,image,readcount) "
					+ "values(?,?,?,?,?,now(),?,?,?)";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, num);
			pstmt.setString(2, andto.getName());
			pstmt.setString(3, andto.getPass());
			pstmt.setString(4, andto.getSubject());
			pstmt.setString(5, andto.getContent());
			pstmt.setString(6, andto.getCategory());
			pstmt.setString(7, andto.getImage());
			pstmt.setInt(8, 0);
			int value = pstmt.executeUpdate();

			System.out.println("게시판 글 저장 완료 " +value+"개");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// insertBoard(andto)

			
			
			
	// getBoardCount()
	@Override
	public int getBoardCount() {
		int count = 0;

		try {
			con = getCon();

			sql="select count(*) from notice";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if(rs.next()){
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		System.out.println("게시판에 있는 글의 개수 : " + count);
		
		return count;
	}
	// getBoardCount()
					
					
					
	// getBoardList(startRow,pageSize)
		@Override
		public List<AdminNoticeDTO> getBoardList(int startRow, int pageSize) {
		List<AdminNoticeDTO> boardList = new ArrayList<AdminNoticeDTO>();

		try {
			con = getCon();

			sql="select * from notice ORDER BY num DESC LIMIT ?, ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);

			rs = pstmt.executeQuery();

			while(rs.next()){
				AdminNoticeDTO  andto = new AdminNoticeDTO();

				andto.setNum(rs.getInt("num"));
				andto.setName(rs.getString("name"));
				andto.setPass(rs.getString("pass"));
				andto.setSubject(rs.getString("subject"));
				andto.setContent(rs.getString("content"));
				andto.setCategory(rs.getString("category"));
				andto.setDate(rs.getDate("date"));
				andto.setImage(rs.getString("image"));
				andto.setReadcount(rs.getInt("readcount"));
				boardList.add(andto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		System.out.println("글 목록 가져오기 완료");
		return boardList;
	}
	//getBoardList(startRow,pageSize)
					
					
					
					
	// updateReadcount(num)
	@Override
	public void updateReadcount(int num) {
		
		try {
			con = getCon();

			sql = "update notice set readcount=readcount+1 where num=?";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1,num);

			int value = pstmt.executeUpdate();
			
			System.out.println("조회수 1증가 글 개수  num : "+value);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// updateReadcount(num)
	
	

					
					
	
	// getBoard(num)
	@Override
	public AdminNoticeDTO getBoard(int num) {
		AdminNoticeDTO andto = null;

		try {
			con = getCon();

			sql = "select * from notice where num=?";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				andto = new AdminNoticeDTO();
				
				andto.setCategory(rs.getString("category"));
				andto.setContent(rs.getString("content"));
				andto.setDate(rs.getDate("date"));
				andto.setImage(rs.getString("image"));
				andto.setName(rs.getString("name"));
				andto.setNum(rs.getInt("num"));
				andto.setPass(rs.getString("pass"));
				andto.setSubject(rs.getString("subject"));
				andto.setReadcount(rs.getInt("readcount"));
			}
			System.out.println("게시판 글 저장: "+andto);
		} catch (Exception e) {

			e.printStackTrace();
		}finally{
			closeDB();
		}
		System.out.println("게시판 글 저장 : " + andto);

		return andto;
	}
	// getBoard(num)
					
					
					
	// updateBoard(andto)
	public int updateBoard(AdminNoticeDTO andto){
		int check = -1;

		try {
			con = getCon();

			sql = "select pass from notice where num=?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, andto.getNum());

			rs = pstmt.executeQuery();


			if(rs.next()){
				if(andto.getPass().equals(rs.getString("pass"))){
					sql = "update notice set name=?,subject=?,content=?,category=? where num=?";

					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, andto.getName());
					pstmt.setString(2, andto.getSubject());
					pstmt.setString(3, andto.getContent());
					pstmt.setString(4, andto.getCategory());
					pstmt.setInt(5, andto.getNum());
					
					check = pstmt.executeUpdate();
					// check = -1;
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
		
		System.out.println("글 수정 동작 완료 : "+check);	
		return check;
	}
	// updateBoard(andto)
					
					
					
	// deleteNotice(num,pass)
	@Override
	public int deleteNotice(int num, String pass){
		int check = -1;
		
		try {
			con = getCon();
							
			sql = "select pass from notice where num=?";
								
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
								
			rs = pstmt.executeQuery(); 
			//123
								
			if(rs.next()){	
				if(pass.equals(rs.getString("pass"))){
					
					sql ="delete from notice where num=?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setInt(1, num);

					check = pstmt.executeUpdate();
									
					// check = 1;
				} else {
					check = 0;
				}
			} else {
				check = -1;
			}		
		} catch (Exception e) {		
			e.printStackTrace();
		}finally{
			closeDB();
		}
							
		System.out.println("공지글 삭제 리턴값 : " + check);
		return check;		
	}
	// deleteNotice(num,pass)

	@Override
	public List<AdminNoticeDTO> getSearch(String search, int startRow, int pageSize) {

List<AdminNoticeDTO> boardList = new ArrayList<AdminNoticeDTO>();
		
		try {
			con = getCon();
			
			sql = "select * from notice where subject like ?";
			pstmt = con.prepareStatement(sql);
			
			System.out.println(search);
			
			pstmt.setString(1, "%"+search+"%");
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				AdminNoticeDTO andto = new AdminNoticeDTO();
				

				andto.setCategory(rs.getString("category"));
				andto.setContent(rs.getString("content"));
				andto.setDate(rs.getDate("date"));
				andto.setImage(rs.getString("image"));
				andto.setName(rs.getString("name"));
				andto.setNum(rs.getInt("num"));
				andto.setPass(rs.getString("pass"));
				andto.setReadcount(rs.getInt("readcount"));
				andto.setSubject(rs.getString("subject"));
				boardList.add(andto);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return boardList;
	}
	

	@Override
	public String getSubject() {
		String subject = "";
		try {
			con = getCon();
			
			sql = "SELECT subject FROM notice WHERE num = (SELECT MAX(num) FROM notice)";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				subject += rs.getString("subject");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}	
		return subject;
	}	
}
