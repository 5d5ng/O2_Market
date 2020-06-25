package test;
import java.util.*;
import dao.*;
import dto.*;
public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		CustomerDao dao = new CustomerDao();
		dao.getCustomers();
		DeliveryDao Ddao = new DeliveryDao();
		ProductDao Pdao = new ProductDao();
		PurchasHistoryDao PHdao = new PurchasHistoryDao();
		OrderProductDao OPdao = new OrderProductDao();
		Pdao.deleteProduct(400);
		//OPdao.updateOrderProduct(1);
//		PHdao.updatePurchaseHisory(11231, 1);

		List l = OPdao.getOrderbyHistroynum(1);
		System.out.println(l.size());
		
	}

}
