package com.cgutech.meeting.service.impl;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cgutech.meeting.Dao.MinutesDao;
import com.cgutech.meeting.entity.MeetingMinutes;
import com.cgutech.meeting.service.MinutesService;
import com.cgutech.meeting.utils.Page;

@Service
public class MinutesServiceImpl implements MinutesService {
	@Autowired
	private MinutesDao minutesDao;
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@Override
	public void saveMinutes(String content, String author, String title) {
		
		String ctime=sf.format(new Date());
		MeetingMinutes minutes = new MeetingMinutes(title,author,content,ctime);
		minutesDao.saveMinutes(minutes);

	}
	@Override
	public Page getMeetingsPage(MeetingMinutes minutes,String before,String after, int currentPage, int pageNum) {
		int count=minutesDao.countMinutes();
		Page page = new Page(currentPage, count, pageNum);
		page.setTotalnum(count);
		int offset = (currentPage - 1) * pageNum;
		List<MeetingMinutes> pageconfig =minutesDao.getMinutes(minutes,before,after, offset, pageNum);
		if(pageconfig!=null){
		for (MeetingMinutes meetingMinutes : pageconfig) {
			if(meetingMinutes.getCtime()!=null&&meetingMinutes.getCtime().endsWith(".0")){
				meetingMinutes.setCtime(meetingMinutes.getCtime().substring(0,meetingMinutes.getCtime().length()-2));
			}	
		}
	}
		page.setList(pageconfig);
		return page;
	}
	@Override
	public MeetingMinutes getMinutesByid(int id) {
		return minutesDao.getMinutesById(id);
		
	}
	@Override
	public void delete(String id) {
		
			minutesDao.delete(Integer.parseInt(id));
		
		
	}
	@Override
	public List<MeetingMinutes> getMeetings(MeetingMinutes minutes, String before, String after) {
		// TODO Auto-generated method stub
		List<MeetingMinutes> meetings =minutesDao.getMinutes(minutes,before,after, 0, 0);
		if(meetings!=null){
			for (MeetingMinutes meetingMinutes : meetings) {
			if(meetingMinutes.getCtime()!=null&&meetingMinutes.getCtime().endsWith(".0")){
				meetingMinutes.setCtime(meetingMinutes.getCtime().substring(0,meetingMinutes.getCtime().length()-2));
			}	
		}
		}
		return meetings;
	}
}

