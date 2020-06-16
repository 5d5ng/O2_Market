package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import dto.OrderProduct;

public class OrderProductDao {
	private static  String dburl =  "jdbc:oracle:thin:@db.pknu.ac.kr:1521:xe";
	private static  String dbUser = "db201512119";
	private static  String dbpasswd = "201512119";
	
	public List<OrderProduct> getOrders(){
		List<OrderProduct> list = new LinkedList<>();
		try {
			Class.forName("oracle.jdbc.OracleDriver");
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		String sql = "SELECT * from Order";
		
		
		try(Connection conn = DriverManager.getConnection(dburl, dbUser, dbpasswd);
				PreparedStatement ps  = conn.prepareStatement(sql) ){

			try(ResultSet rs = ps.executeQuery()){
				while(rs.next()) {

					int orderNumber = rs.getInt(1);
					int quantity = rs.getInt(2);
					String deliveryID = rs.getString(3);
					String customerID = rs.getString(4);
					int productNumber = rs.getInt(5);
					int historyNumber = rs.getInt(6);
					
					OrderProduct order = new OrderProduct(orderNumber, quantity, deliveryID, customerID, productNumber, historyNumber);
					list.add(order);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
		
	}
	
	public int addOrderProduct(OrderProduct orderProduct) {
		int insertCount = 0;
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			Class.forName("oracle.jdbc.OracleDriver");

			conn = DriverManager.getConnection(dburl,dbUser,dbpasswd);
			String sql =  "INSERT INTO OrderProduct VALUES (?,?,?,?,?,?)";
			
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, orderProduct.getOrderNumber());
			ps.setInt(2, orderProduct.getQuantity());
			ps.setString(3, orderProduct.getDeliveryID());
			ps.setString(4, orderProduct.getCustomerID());
			ps.setInt(5, orderProduct.getProductNumber());
			ps.setInt(6,orderProduct.getHistoryNumber());
			

			insertCount = ps.executeUpdate();


		}catch(Exception ex){
			ex.printStackTrace();
		}finally {
			if(ps!=null) {
				try {
					ps.close();
				}catch (Exception e) {
					e.printStackTrace();
				}
			}	
			if(conn!=null) {
				try {
					conn.close();
				}catch (Exception e) {
					e.printStackTrace();
				}
			}

		}

		return insertCount;
	}

 
}
