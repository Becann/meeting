package com.cgutech.meeting.Dao;

import java.util.List;

import com.cgutech.meeting.entity.MeetingMinutes;

public interface MinutesDao {
	 public void saveMinutes(MeetingMinutes minutes);

	public int countMinutes();

	public List<MeetingMinutes> getMinutes(MeetingMinutes minutes, String before, String after, int offset,
			int limit);

	public MeetingMinutes getMinutesById(int id);
	
	public void delete(int id);
	
}

