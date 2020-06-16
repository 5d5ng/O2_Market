package dto;

/**
 * @author LACUC
 *
 */
public class Product {
	private int ProductNumber;
	private int ProductPrice;
	private String ProductName;
	private int Stock;
	private String Supplier;
	private String Category;
	public int getProductNumber() {
		return ProductNumber;
	}
	public void setProductNumber(int productNumber) {
		ProductNumber = productNumber;
	}
	public int getProductPrice() {
		return ProductPrice;
	}
	public void setProductPrice(int productPrice) {
		ProductPrice = productPrice;
	}
	public String getProductName() {
		return ProductName;
	}
	public void setProductName(String productName) {
		ProductName = productName;
	}
	public int getStock() {
		return Stock;
	}
	public void setStock(int stock) {
		Stock = stock;
	}
	public String getSupplier() {
		return Supplier;
	}
	public void setSupplier(String supplier) {
		Supplier = supplier;
	}
	public String getCategory() {
		return Category;
	}
	public void setCategory(String category) {
		Category = category;
	}
	
	public Product(int productNumber, int productPrice, String productName, int stock, String supplier,
			String category) {
		super();
		ProductNumber = productNumber;
		ProductPrice = productPrice;
		ProductName = productName;
		Stock = stock;
		Supplier = supplier;
		Category = category;
	}
	@Override
	public String toString() {
		return "Product [ProductNumber=" + ProductNumber + ", ProductPrice=" + ProductPrice + ", ProductName="
				+ ProductName + ", Stock=" + Stock + ", Supplier=" + Supplier + ", Category=" + Category + "]";
	}
	

}
