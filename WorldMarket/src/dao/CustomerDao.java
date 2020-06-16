package dao;

import java.sql.*;
import java.util.*;

import dto.Customer;
public class CustomerDao {

	private static  String dburl =  "jdbc:oracle:thin:@db.pknu.ac.kr:1521:xe";
	private static  String dbUser = "db201512119";
	private static  String dbpasswd = "201512119";

	
	//회원리스트 받아오기
	public List<Customer> getCustomers(){
		List<Customer> list = new LinkedList<>();
		try {
			Class.forName("oracle.jdbc.OracleDriver");
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}

		String sql = "SELECT * from CUSTOMER";
		try(Connection conn = DriverManager.getConnection(dburl, dbUser, dbpasswd);
				PreparedStatement ps  = conn.prepareStatement(sql) ){

			try(ResultSet rs = ps.executeQuery()){
				while(rs.next()) {

					String customerID = rs.getString(1);
					String customerPW = rs.getString(2);
					String name = rs.getString(3);
					int age = rs.getInt(4);
					String phoneNumber = rs.getString(5);
					String eMail = rs.getString(6);

					Customer customer = new Customer(customerID, customerPW, name, age, phoneNumber, eMail);
					//System.out.println(customer.toString());
					list.add(customer);


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
  
	//회원추가
	
	public int addCustomer(Customer customer) {
		int insertCount = 0;
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			Class.forName("oracle.jdbc.OracleDriver");

			conn = DriverManager.getConnection(dburl,dbUser,dbpasswd);
			String sql =  "INSERT INTO Customer VALUES (?,?,?,?,?,?)";
			
			ps = conn.prepareStatement(sql);
	
			ps.setString(1,customer.getCustomerID());
			ps.setString(2, customer.getCustomerPW());
			ps.setString(3, customer.getName());
			ps.setInt(4, customer.getAge());
			ps.setString(5, customer.getPhoneNumber());
			ps.setString(6, customer.getEMail());

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
