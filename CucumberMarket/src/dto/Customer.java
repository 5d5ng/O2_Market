package dto;

public class Customer {
	
	private String CustomerID;
	private String CustomerPW;
	private String Name;
	private int Age;
	private String PhoneNumber;
	private String EMail;
	public String getCustomerID() {
		return CustomerID;
	}
	public void setCustomerID(String customerID) {
		CustomerID = customerID;
	}
	public String getCustomerPW() {
		return CustomerPW;
	}
	public void setCustomerPW(String customerPW) {
		CustomerPW = customerPW;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public int getAge() {
		return Age;
	}
	public void setAge(int age) {
		Age = age;
	}
	public String getPhoneNumber() {
		return PhoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		PhoneNumber = phoneNumber;
	}
	public String getEMail() {
		return EMail;
	}
	public void setEMail(String eMail) {
		EMail = eMail;
	}
	
	public Customer(String customerID, String customerPW, String name, int age, String phoneNumber, String eMail) {
		super();
		CustomerID = customerID;
		CustomerPW = customerPW;
		Name = name;
		Age = age;
		PhoneNumber = phoneNumber;
		EMail = eMail;
	}
	@Override
	public String toString() {
		return "Customer [CustomerID=" + CustomerID + ", CustomerPW=" + CustomerPW + ", Name=" + Name + ", Age=" + Age
				+ ", PhoneNumber=" + PhoneNumber + ", EMail=" + EMail + "]";
	}
	
	

}
