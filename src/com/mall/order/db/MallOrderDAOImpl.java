package com.mall.order.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MallOrderDAOImpl implements MallOrderDAO{
	Connection con = null;
	PreparedStatement pstmt =null;
	ResultSet rs =null;
	String sql="";
	
	// DB 연결
	private Connection getCon() throws Exception{
		// Context 객체 생성
		Context init=new InitialContext();
		
		// DB연동 이름으로 DB 호출 -> DataSource저장
		DataSource ds= (DataSource)init.lookup("java:comp/env/jdbc/will_cinema");
		
		// 연결정보를 가져와서 리턴
		con=ds.getConnection();
		
		System.out.println("DB 접속 완료 : " + con);
		
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

	
	
	// 주문 동작
	@Override
	public void addOrder(MallOrderDTO modto) {
		int order_no = 0;
		int trans_no = 0;
		
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		
		try {
			con = getCon();
			
			sql = "SELECT MAX(order_num) FROM order_goods";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				order_no = rs.getInt(1) + 1;
			}
			
			System.out.println("order_num 값 : " + order_no);
			
			// ------------------------------------------
			
			sql = "SELECT trans_num, order_date FROM order_goods WHERE order_num="
					+ "(SELECT MAX(order_num) FROM order_goods)";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if (!rs.getDate("order_date").equals(sdf.format(cal.getTime()).toString())) {
					trans_no = 1;
				} else {
					trans_no = Integer.parseInt(rs.getString("trans_num").substring(9)) + 1;
				}
			}
			// trans_no = order_no;
			
			// ------------------------------------------
			
			sql = "INSERT INTO order_goods(order_num, trans_num, order_id, order_goods_num, goods_name, goods_amount, price, payment, order_date, barcode, barcode_img)"
					+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, order_no);
			pstmt.setString(2, sdf.format(cal.getTime()).toString() + "-" + trans_no);
			pstmt.setString(3, modto.getOrder_id());
			pstmt.setInt(4, modto.getOrder_goods_num());
			pstmt.setString(5, modto.getGoods_name());
			pstmt.setInt(6, modto.getGoods_amount());
			pstmt.setInt(7, modto.getPrice());
			pstmt.setString(8, modto.getPayment());
			pstmt.setString(9, modto.getBarcode());
			pstmt.setString(10, modto.getBarcode_img());
			
			pstmt.executeUpdate();
			
			System.out.println("주문 완료");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}

	
	
	// 주문 목록 가져오기
	@Override
	public List<MallOrderDTO> getOrderList(String id) {
		List<MallOrderDTO> orderList = new ArrayList<MallOrderDTO>();
		
		try {
			con = getCon();
			
			sql = "SELECT trans_num, goods_name, goods_amount, price, order_date FROM order_goods WHERE order_id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MallOrderDTO modto = new MallOrderDTO();
				
				modto.setGoods_amount(rs.getInt("goods_amount"));
				modto.setGoods_name(rs.getString("goods_name"));
				modto.setTrans_num(rs.getString("trans_num"));
				modto.setPrice(rs.getInt("price"));
				modto.setOrder_date(rs.getDate("order_date"));
				
				orderList.add(modto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		System.out.println("orderList 저장 완료");
		
		return orderList;
	}

	
	
	// 주문 상세 내역
	@Override
	public List orderDetail(String trans_num) {
		List orderDetailList = new ArrayList();
		
		try {
			con = getCon();
			
			sql = "SELECT * FROM order_goods WHERE trans_num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, trans_num);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MallOrderDTO modto = new MallOrderDTO();
				
				modto.setTrans_num(rs.getString("trans_num"));
				modto.setGoods_amount(rs.getInt("goods_amount"));
				modto.setGoods_name(rs.getString("goods_name"));
				modto.setOrder_date(rs.getDate("order_date"));
				modto.setOrder_goods_num(rs.getInt("order_goods_num"));
				modto.setOrder_id(rs.getString("order_id"));
				modto.setPayment(rs.getString("payment"));
				modto.setPrice(rs.getInt("price"));
				modto.setOrder_date(rs.getDate("order_date"));
				modto.setBarcode(rs.getString("barcode"));
				modto.setBarcode_img(rs.getString("barcode_img"));
				
				orderDetailList.add(modto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return orderDetailList;
	}
}
