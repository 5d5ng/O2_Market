package dto;

public class Delivery {

		private String DeliveryID;
		private String Status;
		private int HistoryNumber;
		public int getHistoryNumber() {
			return HistoryNumber;
		}
		public void setHistoryNumber(int historyNumber) {
			HistoryNumber = historyNumber;
		}
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
		public Delivery(String deliveryID, String status, int historyNumber) {
			super();
			DeliveryID = deliveryID;
			Status = status;
			HistoryNumber = historyNumber;
		}
		@Override
		public String toString() {
			return "Delivery [DeliveryID=" + DeliveryID + ", Status=" + Status + ", HistoryNumber=" + HistoryNumber
					+ "]";
		}
		
		
}
