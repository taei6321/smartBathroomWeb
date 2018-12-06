package purchase;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import notice.Notice;
import purchase.Purchase;

import user.User;

public class PurchaseDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 실제로 데이터베이스에 접속 하게 하는 곳
	public PurchaseDAO(){
		try{
			
			String dbURL = "jdbc:mysql://localhost:3306/smartBathroom";
			String dbID = "senser";
			String dbPassword = "gustp12";
			
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	public String findUserName(String userID){
		String SQL = "SELECT userName FROM user WHERE userID = ?";
			
			try{
				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					// 로그인을 안한 경우
					if(rs.getString(1) == null){
						return null; 
					}
					else
						return rs.getString(1); // 작성자 유
				}
				return "-1"; // 아이디가 없음
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return "-2"; // 데이터베이스 오류
	}
	
	public String findUserAddress(String userID){
		String SQL = "SELECT userAddress FROM user WHERE userID = ?";
			
			try{
				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					// 로그인을 안한 경우
					if(rs.getString(1) == null){
						return null; 
					}
					else
						return rs.getString(1); // 작성자 유
				}
				return "-1"; // 아이디가 없음
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return "-2"; // 데이터베이스 오류
	}
	
	public String findUserfirPhone(String userID){
		String SQL = "SELECT userfirPhone FROM user WHERE userID = ?";
			
			try{
				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					// 로그인을 안한 경우
					if(rs.getString(1) == null){
						return null; 
					}
					else
						return rs.getString(1); // 작성자 유
				}
				return "-1"; // 아이디가 없음
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return "-2"; // 데이터베이스 오류
	}
	
	public String findUsersecPhone(String userID){
		String SQL = "SELECT usersecPhone FROM user WHERE userID = ?";
			
			try{
				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					// 로그인을 안한 경우
					if(rs.getString(1) == null){
						return null; 
					}
					else
						return rs.getString(1); // 작성자 유
				}
				return "-1"; // 아이디가 없음
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return "-2"; // 데이터베이스 오류
	}
	
	public String findUserthrPhone(String userID){
		String SQL = "SELECT userthrPhone FROM user WHERE userID = ?";
			
			try{
				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					// 로그인을 안한 경우
					if(rs.getString(1) == null){
						return null; 
					}
					else
						return rs.getString(1); // 작성자 유
				}
				return "-1"; // 아이디가 없음
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return "-2"; // 데이터베이스 오류
	}
	
	public String findUserEmail(String userID){
		String SQL = "SELECT userEmail FROM user WHERE userID = ?";
			
			try{
				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					// 로그인을 안한 경우
					if(rs.getString(1) == null){
						return null; 
					}
					else
						return rs.getString(1); // 작성자 유
				}
				return "-1"; // 아이디가 없음
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return "-2"; // 데이터베이스 오류
	}
	
	public int findPurchaseAvailable(String userID){
		String SQL = "SELECT purchasesAvailable FROM purchase WHERE userID = ?";
		try{
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(rs.getString(1) == null){
					return 0;
				}
				else{
					return 1;
				}
			}
			return -1;
			
		}catch(Exception e){
			e.printStackTrace();
			return -2;
		}
	}
	
	public int apply(Purchase purchase, String userID){
		String SQL = "INSERT INTO purchase VALUES (?, ?, ?, ?, ?, ?)";
		
		try{
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, purchase.getSmartMir());
			pstmt.setString(3, purchase.getSmartBath());
			pstmt.setString(4, purchase.getDigitalShowerhead());
			pstmt.setString(5, purchase.getAutoVentilator());
			pstmt.setInt(6, 1);
		
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int update(Purchase purchase, String userID){
		String SQL = "UPDATE purchase SET smartMir = ?, smartBath = ?, digitalShowerhead = ?, autoVentilator = ? WHERE userID = ?";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, purchase.getSmartMir());
			pstmt.setString(2, purchase.getSmartBath());
			pstmt.setString(3, purchase.getDigitalShowerhead());
			pstmt.setString(4, purchase.getAutoVentilator());
			pstmt.setString(5, userID);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int findSmartMir(String userID){
		String SQL = "SELECT smartMir FROM purchase WHERE userID = ?";
			
			try{
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					// 로그인을 안한 경우
					if(rs.getString(1) == null){
						return 0; 
					}
					else
						return 1; // 작성자 유
				}
				return -1; // 아이디가 없음
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return -2; // 데이터베이스 오류
	}
	
	public int findSmartBath(String userID){
		String SQL = "SELECT smartBath FROM purchase WHERE userID = ?";
			
			try{
				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					// 로그인을 안한 경우
					if(rs.getString(1) == null){
						return 0; 
					}
					else
						return 1; // 작성자 유
				}
				return -1; // 아이디가 없음
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return -2; // 데이터베이스 오류
	}
	
	public int findDigitalShowerhead(String userID){
		String SQL = "SELECT digitalShowerhead FROM purchase WHERE userID = ?";
			
			try{
				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					// 로그인을 안한 경우
					if(rs.getString(1) == null){
						return 0; 
					}
					else
						return 1; // 작성자 유
				}
				return -1; // 아이디가 없음
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return -2; // 데이터베이스 오류
	}
	
	public int findAutoVentilator(String userID){
		String SQL = "SELECT autoVentilator FROM purchase WHERE userID = ?";
			
			try{
				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					if(rs.getString(1) == null){
						return 0; 
					}
					else
						return 1; // 작성자 유
				}
				return -1; // 아이디가 없음
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return -2; // 데이터베이스 오류
	}

}
