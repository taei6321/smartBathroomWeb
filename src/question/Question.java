package question;

public class Question {
	
	private int questionID;
	private String questionTitle;
	private String userID;
	private String questionDate;
	private String questionContent;
	private int questionAvailable;
	
	public int getQuestionID() {
		return questionID;
	}
	public void setQuestionID(int questionID) {
		this.questionID = questionID;
	}
	public String getQuestionTitle() {
		return questionTitle;
	}
	public void setQuestionTitle(String questionTitle) {
		this.questionTitle = questionTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getQuestionDate() {
		return questionDate;
	}
	public void setQuestionDate(String questionDate) {
		this.questionDate = questionDate;
	}
	public String getQuestionContent() {
		return questionContent;
	}
	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}
	public int getQuestionAvailable() {
		return questionAvailable;
	}
	public void setQuestionAvailable(int questionAvailable) {
		this.questionAvailable = questionAvailable;
	}
	
}