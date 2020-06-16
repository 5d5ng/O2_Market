package dto;

public class Delivery {

		private String DeliveryID;
		private String Status;
		public String getDeliveryID() {
			return DeliveryID;
		}
		public void setDeliveryID(String deliveryID) {
			DeliveryID = deliveryID;
		}
		public String getStatus() {
			return Status;
		}
		public void setStatus(String status) {
			Status = status;
		}
		public Delivery(String deliveryID, String status) {
			super();
			DeliveryID = deliveryID;
			Status = status;
		}
		@Override
		public String toString() {
			return "Delivery [DeliveryID=" + DeliveryID + ", Status=" + Status + "]";
		}
		
}
