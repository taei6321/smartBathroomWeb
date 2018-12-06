package management;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ManagementUserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 실제로 데이터베이스에 접속 하게 하는 곳
	public ManagementUserDAO(){
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
	
	public int countUserID(){
		String SQL = "SELECT count(userID) FROM user";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				return rs.getInt(1);
			}
			else{
				return -1;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -2; 
	}
	
	public String[] findUserID(){
		String SQL = "SELECT userID FROM user order by userID desc";
		int row = countUserID();
		String[] name = new String[row];
		
		try{

			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			for(int i = 0; rs.next(); i++){
				name[i] = rs.getString("userID");
			}
			
			return name;
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	
	public String findUserName(String userID){
		String SQL = "SELECT userName FROM user WHERE userID = ?";
		
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				return rs.getString(1);
			}
			return "-1";
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "-2";
	}
	
	public String findUserPhone(String userID){
		String SQL = "SELECT userfirPhone, usersecPhone, userthrPhone FROM user WHERE userID = ?";
		
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(rs.getString(1).length() == 2){
					return "0" + rs.getString(1) + "-" + rs.getString(2) + "-" + rs.getString(3);
				}
				else{
					return rs.getString(1) + "-" + rs.getString(2) + "-" + rs.getString(3);
				}
			}
			return "-1";
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "-2";
	}
	
	public String findUserAddress(String userID){
		String SQL = "SELECT userAddress FROM user WHERE userID = ?";
		
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
	
			if(rs.next()){
				return rs.getString(1);
			}
			return "-1";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "-2";
	}
	
	public String findUserManager(String userID){
		String SQL = "SELECT userManager FROM user WHERE userID = ?";
		
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
	
			if(rs.next()){
				if(rs.getString(1) == null){
					return " ";
				}
				return rs.getString(1);
			}
			return "-1";
		}catch(Exception e){
			e.printStackTrace();
		}
		return "-2";
	}
}
