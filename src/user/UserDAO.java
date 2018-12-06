package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 실제로 데이터베이스에 접속 하게 하는 곳
	public UserDAO(){
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
	
	public int login(String userID, String userPassword){
		
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		
		try{
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				// 아이디가 있는 경우
				if(rs.getString(1).equals(userPassword)){
					return 1; // 로그인 성공
				}
				else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	public int join(User user){
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try{
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setInt(5, user.getUserfirPhone());
			pstmt.setInt(6, user.getUsersecPhone());
			pstmt.setInt(7, user.getUserthrPhone());
			pstmt.setString(8, user.getUserEmail());
			pstmt.setString(9, user.getUserAddress());
			pstmt.setString(10, null);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int find(String userID){
	String SQL = "SELECT userManager FROM USER WHERE userID = ?";
		
		try{
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				// 일반 회원인 경우
				if(rs.getString(1) == null){
					return 0; 
				}
				else
					return 1; // 관리자인 경우
			}
			return -1; // 아이디가 없음
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
}
