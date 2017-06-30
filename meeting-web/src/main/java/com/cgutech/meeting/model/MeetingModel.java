package com.cgutech.meeting.model;

public class MeetingModel implements java.io.Serializable {

	private String id;
	private String title;
	private String author;
	private String ctime;
	public MeetingModel(){
		
	}
	public MeetingModel (String id, String title,String author,String ctime){
		this.id=id;
		this.title=title;
		this.author=author;
		this.ctime=ctime;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getCtime() {
		return ctime;
	}
	public void setCtime(String ctime) {
		this.ctime = ctime;
	}

	


}
