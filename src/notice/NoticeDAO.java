package notice;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class NoticeDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	// 실제로 데이터베이스에 접속 하게 하는 곳
	public NoticeDAO(){
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
			String SQL = "SELECT noticeID FROM notice ORDER BY noticeID DESC";
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
	
	public int write(String noticeTitle, String userID, String noticeContent){
		String SQL = "INSERT INTO notice VALUES (?, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, noticeTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, noticeContent);
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Notice> getList(int pageNumber){
		String SQL = "SELECT * FROM notice WHERE noticeID < ? AND noticeAvailable = 1 ORDER BY noticeID DESC LIMIT 10";
		ArrayList<Notice> list = new ArrayList<Notice>();
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()){
				Notice notice = new Notice();
				notice.setNoticeID(rs.getInt(1));
				notice.setNoticeTitle(rs.getString(2));
				notice.setUserID(rs.getString(3));
				notice.setNoticeDate(rs.getString(4));
				notice.setNoticeContent(rs.getString(5));
				notice.setNoticeAvailable(rs.getInt(6));
				list.add(notice);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	// 페이징 처리를 위한 함수
	public boolean nextPage(int pageNumber){
		String SQL = "SELECT * FROM notice WHERE noticeID < ? AND noticeAvailable = 1";
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
	
	public Notice getNotice(int noticeID){
		String SQL = "SELECT * FROM notice WHERE noticeID = ?";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, noticeID);
			rs = pstmt.executeQuery();
			if(rs.next()){
				Notice notice = new Notice();
				notice.setNoticeID(rs.getInt(1));
				notice.setNoticeTitle(rs.getString(2));
				notice.setUserID(rs.getString(3));
				notice.setNoticeDate(rs.getString(4));
				notice.setNoticeContent(rs.getString(5));
				notice.setNoticeAvailable(rs.getInt(6));
				return notice;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int noticeID, String noticeTitle, String noticeContent){
		String SQL = "UPDATE notice SET noticeTitle = ?, noticeContent = ? WHERE noticeID = ?";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, noticeTitle);
			pstmt.setString(2, noticeContent);
			pstmt.setInt(3, noticeID);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int noticeID){
		String SQL = "UPDATE notice SET noticeAvailable = 0 WHERE noticeID = ?";
		PreparedStatement pstmt = null;
		try{
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, noticeID);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
