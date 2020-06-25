package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import dto.Product;

public class ProductDao {


	private static  String dburl =  "jdbc:oracle:thin:@db.pknu.ac.kr:1521:xe";
	private static  String dbUser = "db201512119";
	private static  String dbpasswd = "201512119";

	public List<Product> getProduct(){
		List<Product> list = new LinkedList<>();
		try {
			Class.forName("oracle.jdbc.OracleDriver");

		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}

		String sql = "SELECT * FROM PRODUCT";
		try(Connection conn = DriverManager.getConnection(dburl, dbUser, dbpasswd);
				PreparedStatement ps = conn.prepareStatement(sql)) {
			try(ResultSet rs = ps.executeQuery()){
				while(rs.next()) {
					int productNumber = rs.getInt(1);
					int productPrice = rs.getInt(2);
					String productName = rs.getString(3);
					int stock = rs.getInt(4);
					String supplier = rs.getString(5);
					String category = rs.getString(6);


					Product product = new Product(productNumber, productPrice, productName, stock, supplier, category);
					list.add(product);
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

	public int addProduct(Product product) {

		int insertCount = 0;
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			Class.forName("oracle.jdbc.OracleDriver");

			conn = DriverManager.getConnection(dburl,dbUser,dbpasswd);
			String sql =  "INSERT INTO Product VALUES (?,?,?,?,?,?)";

			ps = conn.prepareStatement(sql);

			ps.setInt(1, product.getProductNumber());
			ps.setInt(2, product.getProductPrice());
			ps.setString(3,product.getProductName());
			ps.setInt(4, product.getStock());
			ps.setString(5, product.getSupplier());
			ps.setString(6, product.getCategory());

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

	public List<Product> getProduct2(){
		List<Product> list = new LinkedList<>();
		try {
			Class.forName("oracle.jdbc.OracleDriver");

		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}

		String sql = "SELECT * FROM PRODUCT";
		try(Connection conn = DriverManager.getConnection(dburl, dbUser, dbpasswd);
				PreparedStatement ps = conn.prepareStatement(sql)) {
			try(ResultSet rs = ps.executeQuery()){
				while(rs.next()) {
					int productNumber = rs.getInt(1);
					int productPrice = rs.getInt(2);
					String productName = rs.getString(3);
					int stock = rs.getInt(4);
					String supplier = rs.getString(5);
					String category = rs.getString(6);


					Product product = new Product(productNumber, productPrice, productName, stock, supplier, category);
					list.add(product);
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


	public void updateProduct(int productNum) { //제품이 주문완료된 경우 재고에서 뺀다.
		String sql = "UPDATE product set stock=stock-1 where productNumber = ?";

		try {

			Class.forName("oracle.jdbc.OracleDriver");

			Connection conn = DriverManager.getConnection(dburl, dbUser, dbpasswd);

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,productNum);
			int numRows = ps.executeUpdate();
			ps.close();
			conn.close();

		}catch(SQLException e) {
			e.printStackTrace();
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public void deleteProduct(int productNum) { // 상품 명단에서 제거
		String sql = "DELETE from PRODUCT where productnumber = ?";
		
		try {
			Class.forName("oracle.jdbc.OracleDriver");

			Connection conn = DriverManager.getConnection(dburl, dbUser, dbpasswd);

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,productNum);
			int numRows = ps.executeUpdate();
			
			ps.close();
			conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}

	}

}
