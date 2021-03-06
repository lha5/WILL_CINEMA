package com.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

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
	
	// insertMember() - 회원 가입 메소드
	@Override
	public void insertMember(MemberDTO mdto) {
		try {
			con = getCon();

			sql = "INSERT INTO member(id, pass, name, birthday, mobile, email,"
					+ " zipcode, addr, detailaddr, receive, preference, reg_date)"
					+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mdto.getId());
			pstmt.setString(2, mdto.getPass());
			pstmt.setString(3, mdto.getName());
			pstmt.setString(4, mdto.getBirthday());
			pstmt.setString(5, mdto.getMobile());
			pstmt.setString(6, mdto.getEmail());
			pstmt.setInt(7, mdto.getZipcode());
			pstmt.setString(8, mdto.getAddr());
			pstmt.setString(9, mdto.getDetailaddr());
			pstmt.setString(10, mdto.getReceive());
			pstmt.setString(11, mdto.getPreference());
			pstmt.setTimestamp(12, mdto.getReg_date());

			pstmt.executeUpdate();

			System.out.println("회원 가입 완료");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	
	
	// idCheck(id, pass) - 로그인 아이디 체크 메소드
	@Override
	public int idCheck(String id, String pass) {
		int check = -1;
		try {
			System.out.println("try문 성공");
			con = getCon();

			sql = "SELECT pass FROM member WHERE id=?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (pass.equals(rs.getString("pass"))) {
					check = 1;
				} else {
					check = 0;
				}
			} else {
				check = -1;
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return check;
	}
	// 비회원전용 로그인
	@Override
	public int emailCheck(String name, String email) {
		
		int check = -1;
		
		System.out.println(" name(login) : "+name+" email(login) : "+email);
		System.out.println("try문 실행");
		
		try {
			System.out.println("try문 성공");
			
			con = getCon();
			
			System.out.println(" con : "+con);

			sql = "select email from non_member where name = ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, name);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				
				System.out.println("rs1 : " + rs);
				
				sql = "SELECT email_checked FROM non_member WHERE email=?";

				pstmt = con.prepareStatement(sql);

				pstmt.setString(1, email);

				rs = pstmt.executeQuery();
				
				if(rs.next()){
					
					if (rs.getInt("email_checked") == 1) {
						
						System.out.println("rs2 : " + rs);
						
						check = 1;
					} else {
						check = 0;
					}
					
				}
				
			} else {
				check = -1;
			}
		} catch (Exception e) {
			System.out.println("try문 예외발생");
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return check;
	}
	
	@Override
	public MemberDTO getMember(String id){
		MemberDTO mdto = null;
		
		try {
			con = getCon();
			
			sql= "select * from member where id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);

			rs= pstmt.executeQuery();

			if (rs.next()){
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
				mdto.setReg_date(rs.getTimestamp("reg_date"));
			
				
			}
			System.out.println("getMember(id) - 회원 정보 저장 완료");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	return mdto;
	}
	//getMember(id)

	
	
	//updateMember(MemberDTO mdto) - 회원 정보 수정
	@Override
	public int updateMember(MemberDTO mdto){
		int update = 1;

		try {
			con = getCon();
			
			sql="select pass from member where id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, mdto.getId());
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if (mdto.getPass().equals(rs.getString("pass"))) {
					sql = "UPDATE member SET name=?, birthday=?, mobile=?, email=?,"
							+ " zipcode=?, addr=?, detailaddr=?, receive=?, preference=? WHERE id=?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, mdto.getName());
					pstmt.setString(2, mdto.getBirthday());
					pstmt.setString(3, mdto.getMobile());
					pstmt.setString(4, mdto.getEmail());
					pstmt.setInt(5, mdto.getZipcode());
					pstmt.setString(6, mdto.getAddr());
					pstmt.setString(7, mdto.getDetailaddr());
					pstmt.setString(8, mdto.getReceive());
					pstmt.setString(9, mdto.getPreference());
					pstmt.setString(10, mdto.getId());
					
					pstmt.executeUpdate();
					
					update = 1;
				} else {
					update = 0;
				}
			} else {
				update = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		System.out.println("회원 정보 수정 완료, check(update) 값 : " + update);
		return update;
	}
	//updateMember(MemberDTO mdto)

	
	
	//deleteMember(String id,String pass) - 회원 탈퇴 메소드
	@Override
	public int deleteMember(String id,String pass){
		int delete = 1;

		try {
			con = getCon();
			
			sql="select pass from member where id=?";
			
			pstmt= con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs= pstmt.executeQuery();

			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){

					sql= "delete from member where id=? ";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, id);
					
					pstmt.executeUpdate();

					delete = 1;
				}else{
					delete = 0;
				}
			}else{
				delete = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		System.out.println("deleteMember 처리 완료, check(delete) 값 : " + delete);
		return delete;
	}
	//deleteMember(String id,String pass)
	
	
	
	
	// getMemberList() - 관리자 회원 목록 열람
	@Override
	public List<MemberDTO> getMemberList() {
		List<MemberDTO> memberList = new ArrayList<MemberDTO>();		
		try {
			con = getCon();

			sql = "SELECT * FROM member";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// 회원 한 명의 정보를 해당 ArrayList 한 칸에 저장

				MemberDTO mdto = new MemberDTO();

				mdto.setId(rs.getString("id"));
				mdto.setName(rs.getString("name"));
				mdto.setEmail(rs.getString("email"));
				mdto.setBirthday(rs.getString("birthday"));
				mdto.setMobile(rs.getString("mobile"));
				mdto.setLevel(rs.getInt("level"));
				mdto.setPoint(rs.getInt("point"));
				mdto.setZipcode(rs.getInt("zipcode"));
				mdto.setAddr(rs.getString("addr"));
				mdto.setDetailaddr(rs.getString("detailaddr"));
				mdto.setReceive(rs.getString("receive"));
				mdto.setReg_date(rs.getTimestamp("reg_date"));

				memberList.add(mdto);
			}

			System.out.println("회원 목록 저장 완료");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return memberList;
	}

	
	
	// 회원 마이 페이지 기본 정보 가져가기
	@Override
	public List forPointLevel(String id) {
		List info = new ArrayList();
		try {
			con = getCon();
			
			sql = "SELECT name, level, point FROM member WHERE id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				info.add(0, rs.getString("name"));
				info.add(1, rs.getInt("level"));
				info.add(2, rs.getInt("point"));
			}else {
				info.add(0, "");
				info.add(1, -1);
				info.add(2, 0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return info;
	}

	
	
	// 비밀번호 변경
	@Override
	public void updatePass(String id, String pass) {
		try {
			con = getCon();
			
			sql = "UPDATE member SET pass=? WHERE id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, pass);
			pstmt.setString(2, id);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		System.out.println("비밀번호 변경 완료.");
	}

	
	
	@Override
	public int JoinIdCheck(String id) {

		int check=0;
		
		try {
			con = getCon();
			
			sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				// 아이디 중복
				check = 1;
			}else{
				// 아이디 사용가능
				check = 0;
			}
			
			System.out.println("아이디 중복체크  : "+check);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return check;
	}

  
  
  // 포인트 적립
	@Override
	public void addPoint(String id, int percentage) {
		try {
			con = getCon();
			
			sql = "SELECT point FROM member WHERE id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sql = "UPDATE member SET point=? WHERE id = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, rs.getInt("point") + percentage);
				pstmt.setString(2, id);
				
				pstmt.executeUpdate();
				
			} else {
				sql = "UPDATE member SET point=? WHERE id = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, percentage);
				pstmt.setString(2, id);
				
				pstmt.executeUpdate();
			}
			
			System.out.println(id + "님 포인트 적립 완료");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}  
	
	@Override
	public List<MemberDTO> searchId(MemberDTO mdto) {
		List<MemberDTO> idList = new ArrayList<MemberDTO>();		
		try {
			con = getCon();

			sql = "SELECT * FROM member where name=?";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, mdto.getName());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// 회원 한 명의 정보를 해당 ArrayList 한 칸에 저장
				sql = "SELECT * FROM member where email=?";

				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, mdto.getEmail());

				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					mdto.setId(rs.getString("id"));
	
					idList.add(mdto);
				}
			}

			System.out.println("아이디 목록 저장 완료");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return idList;
	}
	
	public List<MemberDTO> searchPass(MemberDTO mdto){
		List<MemberDTO> passList = new ArrayList<MemberDTO>();		
		try {
			con = getCon();
			
			sql = "SELECT pass FROM member where id=?";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, mdto.getId());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// 회원 한 명의 정보를 해당 ArrayList 한 칸에 저장
				sql = "SELECT pass FROM member where name=?";

				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, mdto.getName());

				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					mdto.setPass(rs.getString("pass"));
					System.out.println(rs.getString("pass"));
	
					passList.add(mdto);
				}
			}

			System.out.println("비밀번호 목록 저장 완료");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return passList;
	}

	
	public String getUserEmail(String id) {

		String SQL = "SELECT email FROM member WHERE id = ?";

			try {
				con = getCon();
				
				PreparedStatement pstmt = con.prepareStatement(SQL);

				pstmt.setString(1, id);

				rs = pstmt.executeQuery();

				while(rs.next()) {

					return rs.getString(1); // 이메일 주소 반환

				}
			} catch (Exception e) {
				
				e.printStackTrace();
			} finally {
				closeDB();
			}

		return null; // 데이터베이스 오류
		
	}
	
	public boolean setUserEmailChecked(String id) {

		String SQL = "UPDATE member SET userEmailChecked = true WHERE id = ?";

		try {
			con = getCon();
			
			PreparedStatement pstmt = con.prepareStatement(SQL);

			pstmt.setString(1, id);

			pstmt.executeUpdate();

			return true; // 이메일 등록 설정 성공

		} catch (Exception e) {

			e.printStackTrace();

		}

		return false; // 이메일 등록 설정 실패

	}

	
	//SNS 회원 가져오기 메소드
	@Override
	public String checkSNSMember(String id) {
		String SNSMember = "";
		try {
			con = getCon();
			
			System.out.println("String id : "+id);
			sql = "select id from member where sns_login=1 and pass=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				SNSMember = rs.getString(1);
			}else{
				SNSMember = "fail";
			}

			System.out.println("회원 아이디 가져오기");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return SNSMember;
	}
	
	// 네이버아이디 추가번호
	@Override
	public int SNSMemberinsertNum(){
		int num = 0;
		try {
			con = getCon();

			sql = "select count(*) from member where sns_login=1 and reg_date > curdate()";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1)+1;
			}else{
				num = 1;
			}

			System.out.println("아이디 추가번호 가져오기 성공");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return num;
	}
	
	// insertSNSMember() - SNS 회원 가입 메소드
		@Override
		public void insertSNSMember(MemberDTO mdto) {
			try {
				con = getCon();
				
				sql = "INSERT INTO member(id, pass, name, birthday, email,"
						+ " reg_date, receive, sns_login)"
						+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?)";

				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, mdto.getId());
				pstmt.setString(2, mdto.getPass());
				pstmt.setString(3, mdto.getName());
				pstmt.setString(4, mdto.getBirthday());
				pstmt.setString(5, mdto.getEmail());
				pstmt.setTimestamp(6, mdto.getReg_date());
				pstmt.setString(7, "no");
				pstmt.setInt(8, 1);

				pstmt.executeUpdate();

				System.out.println("SNS 회원 등록 완료");

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
		}

		
		
		
	// 포인트 차감	
	@Override
	public void substractPoint(String id, int usingPoint) {
		try {
			con = getCon();
			
			sql = "UPDATE member SET point -= ? WHERE id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, usingPoint);
			pstmt.setString(2, id);
			
			pstmt.executeUpdate();
			
			System.out.println("포인트 사용 완료");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
}
