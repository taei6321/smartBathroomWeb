package question;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class QuestionDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	// 실제로 데이터베이스에 접속 하게 하는 곳
	public QuestionDAO(){
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
			String SQL = "SELECT questionID FROM question ORDER BY questionID DESC";
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
	
	public int write(String questionTitle, String userID, String questionContent){
		String SQL = "INSERT INTO question VALUES (?, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, questionTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, questionContent);
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Question> getList(int pageNumber){
		String SQL = "SELECT * FROM question WHERE questionID < ? AND questionAvailable = 1 ORDER BY questionID DESC LIMIT 10";
		ArrayList<Question> list = new ArrayList<Question>();
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Question question = new Question();
				question.setQuestionID(rs.getInt(1));
				question.setQuestionTitle(rs.getString(2));
				question.setUserID(rs.getString(3));
				question.setQuestionDate(rs.getString(4));
				question.setQuestionContent(rs.getString(5));
				question.setQuestionAvailable(rs.getInt(6));
				list.add(question);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	// 페이징 처리를 위한 함수
	public boolean nextPage(int pageNumber){
		String SQL = "SELECT * FROM question WHERE questionID < ? AND questionAvailable = 1";
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
	
	public Question getQuestion(int questionID){
		String SQL = "SELECT * FROM question WHERE questionID = ?";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, questionID);
			rs = pstmt.executeQuery();
			if(rs.next()){
				Question question = new Question();
				question.setQuestionID(rs.getInt(1));
				question.setQuestionTitle(rs.getString(2));
				question.setUserID(rs.getString(3));
				question.setQuestionDate(rs.getString(4));
				question.setQuestionContent(rs.getString(5));
				question.setQuestionAvailable(rs.getInt(6));
				return question;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int questionID, String questionTitle, String questionContent){
		String SQL = "UPDATE question SET questionTitle = ?, questionContent = ? WHERE questionID = ?";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, questionTitle);
			pstmt.setString(2, questionContent);
			pstmt.setInt(3, questionID);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int questionID){
		String SQL = "UPDATE question SET questionAvailable = 0 WHERE questionID = ?";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, questionID);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
