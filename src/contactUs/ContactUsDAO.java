package contactUs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ContactUsDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	// 실제로 데이터베이스에 접속 하게 하는 곳
	public ContactUsDAO(){
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
	
	// 현재 시간을 가져오는 함수, 게시판 글을 쓰는 시간을 넣어준다
		public String getDate(){
			String SQL = "SELECT NOW()";
			PreparedStatement pstmt = null;
			try{
				pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if(rs.next()){
					return rs.getString(1);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			return ""; // 데이터베이스 오류
		}
		
		public int getNext(){
			String SQL = "SELECT contactUsID FROM contactUs ORDER BY contactUsID DESC";
			PreparedStatement pstmt = null;
			try{
				pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if(rs.next()){
					return rs.getInt(1) + 1;
				}
				return 1; // 첫 번째 게시물인 경우
			}catch(Exception e){
				e.printStackTrace();
			}
			return -1; // 데이터베이스 오류
		}
	
	public int write(String contactUsTitle, String userID, String contactUsContent){
		String SQL = "INSERT INTO contactUs VALUES (?, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, contactUsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, contactUsContent);
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<ContactUs> getList(int pageNumber){
		String SQL = "SELECT * FROM contactUs WHERE contactUsID < ? AND contactUsAvailable = 1 ORDER BY contactUsID DESC LIMIT 10";
		ArrayList<ContactUs> list = new ArrayList<ContactUs>();
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()){
				ContactUs contactUs = new ContactUs();
				contactUs.setContactUsID(rs.getInt(1));
				contactUs.setContactUsTitle(rs.getString(2));
				contactUs.setUserID(rs.getString(3));
				contactUs.setContactUsDate(rs.getString(4));
				contactUs.setContactUsContent(rs.getString(5));
				contactUs.setContactUsAvailable(rs.getInt(6));
				list.add(contactUs);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	// 페이징 처리를 위한 함수
	public boolean nextPage(int pageNumber){
		String SQL = "SELECT * FROM contactUs WHERE contactUsID < ? AND contactUsAvailable = 1";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()){
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	public ContactUs getContactUs(int contactUsID){
		String SQL = "SELECT * FROM contactUs WHERE contactUsID = ?";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, contactUsID);
			rs = pstmt.executeQuery();
			if(rs.next()){
				ContactUs contactUs = new ContactUs();
				contactUs.setContactUsID(rs.getInt(1));
				contactUs.setContactUsTitle(rs.getString(2));
				contactUs.setUserID(rs.getString(3));
				contactUs.setContactUsDate(rs.getString(4));
				contactUs.setContactUsContent(rs.getString(5));
				contactUs.setContactUsAvailable(rs.getInt(6));
				return contactUs;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int contactUsID, String contactUsTitle, String contactUsContent){
		String SQL = "UPDATE contactUs SET contactUsTitle = ?, contactUsContent = ? WHERE contactUsID = ?";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, contactUsTitle);
			pstmt.setString(2, contactUsContent);
			pstmt.setInt(3, contactUsID);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int contactUsID){
		String SQL = "UPDATE contactUs SET contactUsAvailable = 0 WHERE contactUsID = ?";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, contactUsID);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
