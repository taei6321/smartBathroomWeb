package review;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReviewDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	// 실제로 데이터베이스에 접속 하게 하는 곳
	public ReviewDAO(){
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
			String SQL = "SELECT reviewID FROM review ORDER BY reviewID DESC";
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
	
	public int write(String userID, String reviewContent){
		String SQL = "INSERT INTO review VALUES (?, ?, ?, ?, ?)";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, getDate());
			pstmt.setString(4, reviewContent);
			pstmt.setInt(5, 1);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Review> getList(int pageNumber){
		String SQL = "SELECT * FROM review WHERE reviewID < ? AND reviewAvailable = 1 ORDER BY reviewID DESC LIMIT 10";
		ArrayList<Review> list = new ArrayList<Review>();
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Review review = new Review();
				review.setReviewID(rs.getInt(1));
				review.setUserID(rs.getString(2));
				review.setReviewDate(rs.getString(3));
				review.setReviewContent(rs.getString(4));
				review.setReviewAvailable(rs.getInt(5));
				list.add(review);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	// 페이징 처리를 위한 함수
	public boolean nextPage(int pageNumber){
		String SQL = "SELECT * FROM review WHERE reviewID < ? AND reviewAvailable = 1";
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
	
	public Review getReview(int reviewID){
		String SQL = "SELECT * FROM review WHERE reviewID = ?";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, reviewID);
			rs = pstmt.executeQuery();
			if(rs.next()){
				Review review = new Review();
				review.setReviewID(rs.getInt(1));
				review.setUserID(rs.getString(2));
				review.setReviewDate(rs.getString(3));
				review.setReviewContent(rs.getString(4));
				review.setReviewAvailable(rs.getInt(5));
				return review;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int reviewID,String reviewContent){
		String SQL = "UPDATE review SET reviewContent = ? WHERE reviewID = ?";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, reviewContent);
			pstmt.setInt(2, reviewID);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int reviewID){
		String SQL = "UPDATE review SET reviewAvailable = 0 WHERE reviewID = ?";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, reviewID);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
