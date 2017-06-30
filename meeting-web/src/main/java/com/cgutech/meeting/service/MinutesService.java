package com.cgutech.meeting.service;

import java.util.List;


import com.cgutech.meeting.entity.MeetingMinutes;
import com.cgutech.meeting.utils.Page;

public interface MinutesService {
	public void saveMinutes(String content,String author,String title);

	public Page getMeetingsPage(MeetingMinutes minutes,String before,String after, int parseInt, int parseInt2);

	public MeetingMinutes getMinutesByid(int parseInt);

	public void delete(String id);
	
	public List<MeetingMinutes> getMeetings(MeetingMinutes minutes,String before,String after);
}

