package management;

import purchase.PurchaseDAO;

public class ManagementPurchaseDAO {

	private PurchaseDAO purchaseDAO = new PurchaseDAO();
	
	public String useSmartMir(String userID){
		int result = purchaseDAO.findSmartMir(userID);
		if(result == 1){
			return "O";
		}
		return "X";
	}
	
	public String useSmartBath(String userID){
		int result = purchaseDAO.findSmartBath(userID);
		if(result == 1){
			return "O";
		}
		return "X";
	}
	
	public String useDigitalShowerhead(String userID){
		int result = purchaseDAO.findDigitalShowerhead(userID);
		if(result == 1){
			return "O";
		}
		return "X";
	}
	
	public String useAutoVentilator(String userID){
		int result = purchaseDAO.findAutoVentilator(userID);
		if(result == 1){
			return "O";
		}
		return "X";
	}
	
	public int countSmartMir(String userID){
		int result = purchaseDAO.findSmartMir(userID);
		if(result == 1){
			return 1;
		}
		return 0;
	}
	
	public int countSmartBath(String userID){
		int result = purchaseDAO.findSmartBath(userID);
		if(result == 1){
			return 1;
		}
		return 0;
	}
	
	public int countDigitalShowerhead(String userID){
		int result = purchaseDAO.findDigitalShowerhead(userID);
		if(result == 1){
			return 1;
		}
		return 0;
	}
	
	public int countAutoVentilator(String userID){
		int result = purchaseDAO.findAutoVentilator(userID);
		if(result == 1){
			return 1;
		}
		return 0;
	}
	
	public String customRank(String userID){
		int result = countSmartMir(userID) + countSmartBath(userID) + countDigitalShowerhead(userID) + countAutoVentilator(userID);
		
		switch(result){
		case 4:
			return "상";
		case 3:
		case 2:
			return "중";
		case 1:
			return "하";
		default:
			return "비구매 회원";
		}
	}
}
