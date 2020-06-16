package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import dto.Delivery;

public class DeliveryDao {
	private static  String dburl =  "jdbc:oracle:thin:@db.pknu.ac.kr:1521:xe";
	private static  String dbUser = "db201512119";
	private static  String dbpasswd = "201512119";
	
	//배달 리스트 받아오기
		public List<Delivery> getDeliveries(){
			List<Delivery> list = new LinkedList<>();
			try {
				Class.forName("oracle.jdbc.OracleDriver");
			}catch(ClassNotFoundException e) {
				e.printStackTrace();
			}

			String sql = "SELECT * from Delivery";
			try(Connection conn = DriverManager.getConnection(dburl, dbUser, dbpasswd);
					PreparedStatement ps  = conn.prepareStatement(sql) ){

				try(ResultSet rs = ps.executeQuery()){
					while(rs.next()) {
							
						String deliveryID = rs.getString(1);
						String status = rs.getString(2);
						
						Delivery delivery = new Delivery(deliveryID, status);
						
						list.add(delivery);

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
		
		public int addDelivery(Delivery delivery) {
			int insertCount = 0;
			Connection conn = null;
			PreparedStatement ps = null;
			
			try {
				Class.forName("oracle.jdbc.OracleDriver");
				conn = DriverManager.getConnection(dburl,dbUser,dbpasswd);
				String sql = "INSERT INTO Customer VALUES (?,?)";
				
				ps = conn.prepareStatement(sql);
				
				ps.setString(1, delivery.getDeliveryID());
				ps.setString(2, delivery.getStatus());
				
				insertCount = ps.executeUpdate();
				
			}catch(Exception ex) {
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
