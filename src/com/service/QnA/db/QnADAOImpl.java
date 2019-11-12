package com.service.QnA.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

//QnA게시판 DB
public class QnADAOImpl implements QnADAO {
	Connection con = null;
	PreparedStatement pstmt =null;
	ResultSet rs =null;
	String sql="";
	
	// DB 연결
	private Connection getCon() throws Exception{
		//Context 객체 생성
		Context init=new InitialContext();
		//DB연동 이름으로 DB 호출 -> DataSource저장
		DataSource ds= (DataSource)init.lookup("java:comp/env/jdbc/will_cinema");

		//연결정보를 가져와서 리턴.
		con=ds.getConnection();
		
		System.out.println("DB 연결 완료 : " + con);
		
		return con;
	}
	
	// DB 자원 해제
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
	
	
	
	// 게시판 글쓰기
	@Override
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
			
			sql = "insert into qna(num,category,name,pass,subject,content,readcount,date,re_ref,re_lev,re_seq,image) values(?,?,?,?,?,?,?,now(),?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, qadto.getCategory());
			pstmt.setString(3, qadto.getName());
			pstmt.setString(4, qadto.getPass());
			pstmt.setString(5, qadto.getSubject());
			pstmt.setString(6, qadto.getContent());
			pstmt.setInt(7, 0);
			pstmt.setInt(8, num);
			pstmt.setInt(9, 0);
			pstmt.setInt(10, 0);
			pstmt.setString(11, qadto.getImage());
			
			int value = pstmt.executeUpdate();
			
			System.out.println("글 저장 완료"+value+"개");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	
	
	// 게시판 총 글 갯수 세기
	@Override
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
	
	
	
	// 게시판 글 목록 가져오기
	@Override
	public List<QnADTO> getBoardList(int startRow,int pageSize) {
		List<QnADTO> boardList = new ArrayList<QnADTO>();
		
		try {
			con = getCon();
			
			sql = "select * from qna ORDER BY re_ref DESC, re_seq ASC LIMIT ?, ? ";
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
				
				boardList.add(qadto);
				
			}
			
		} catch (Exception e) { 	
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return boardList;
	}
	
	
	
	// 게시판에 있는 글의 조회수 증가
	@Override
	public void updateReadCount(int num) {
		try {
			con = getCon();
			
			sql = "update qna set readcount=readcount+1 where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			int value = pstmt.executeUpdate();
			
			System.out.println("조회수 1증가 글 개수 value : " + value);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
	
	}
	
	
	
	// 번호에 맞는 글 내용 가져오기
	@Override
	public QnADTO getBoard(int num) {
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
	
	
	
	// 게시글 수정
	@Override
	public int updateBoard(QnADTO qadto) {
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
	
	
	
	// 게시글 삭제
	@Override
	public int deleteBoard(int num,String pass) {
		
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
				boardList.add(qadto);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return boardList;
	}

	
	
	
	@Override
	public void reInsertBoard(QnADTO qnadto) {
		int num = 0;
		try {
			con = getCon();
			
			sql = "SELECT MAX(num) FROM qna";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				num = rs.getInt(1) + 1;	// rs.getInt(1)에서 괄호 안의 1은 첫 번째(1번) 컬럼이라는 뜻
			}
			
			System.out.println("실행할 답글 글 번호 : " + num);
			
			// 답글 순서 재배치
			sql = "UPDATE qna SET re_seq = re_seq + 1 WHERE re_ref=? and re_seq > ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, qnadto.getRe_ref());
			pstmt.setInt(2, qnadto.getRe_seq());
			
			pstmt.executeUpdate();
			
			// 답글 작성
			sql = "INSERT INTO qna(num, name, pass, subject, content, readcount, re_ref, re_lev, re_seq, date, image, category)"
					+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);// 위에서 계산한 글 번호(no) 입력
			pstmt.setString(2, qnadto.getName());
			pstmt.setString(3, qnadto.getPass());
			pstmt.setString(4, qnadto.getSubject());
			pstmt.setString(5, qnadto.getContent());
			pstmt.setInt(6, 0);	// 모든 글의 조회수는 항상 0으로 초기화
			pstmt.setInt(7, qnadto.getRe_ref());
			pstmt.setInt(8, qnadto.getRe_lev() + 1);	// 원래 글에서 1 증가된 값을 가진다.
			pstmt.setInt(9, qnadto.getRe_seq());
			pstmt.setString(10, qnadto.getImage());
			pstmt.setString(11, qnadto.getCategory());
			
			pstmt.executeUpdate();
			
			System.out.println("답글 쓰기 메소드 실행 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
}	

