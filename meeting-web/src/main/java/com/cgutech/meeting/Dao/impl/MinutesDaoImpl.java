package com.cgutech.meeting.Dao.impl;


import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Service;

import com.cgutech.meeting.Dao.MinutesDao;
import com.cgutech.meeting.entity.MeetingMinutes;

@Service
public class MinutesDaoImpl implements MinutesDao{
	@Autowired
	HibernateTemplate ht;
	@Override
	public void saveMinutes(MeetingMinutes minutes) {
		ht.save(minutes);
	}
	@Override
	public int countMinutes() {
		long  count = 0;
		String hql = "select count(*) from MeetingMinutes";
		count = (long)this.ht.find(hql).iterator().next();	
		return (int)count;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<MeetingMinutes> getMinutes(MeetingMinutes minutes, String before, String after, int offset,
			int limit) {
		DetachedCriteria criteria=DetachedCriteria.forClass(MeetingMinutes.class);
		if(!minutes.getAuthor().equals("")){
			criteria.add(Restrictions.eq("author", minutes.getAuthor()));
		}
		if(!"".equals(minutes.getTitle())){
			criteria.add(Restrictions.eq("title", minutes.getTitle()));
		}
		if(!before.equals("")){
			criteria.add(Restrictions.ge("ctime", before));
		}
		if(!after.equals("")){
			criteria.add(Restrictions.le("ctime", after));
		}
		if(!minutes.getContent().equals("")){
			criteria.add(Restrictions.like("content", "%"+minutes.getContent()+"%"));
		}
		criteria.addOrder(Order.desc("ctime"));
		if(offset==0&&limit==0){
			return ht.findByCriteria(criteria);
		}
		List<MeetingMinutes> inutes = ht.findByCriteria(criteria, offset, limit);
		return inutes;
	}
	@Override
	public MeetingMinutes getMinutesById(int id) {
		
		return ht.get(MeetingMinutes.class, id);
	}
	@Override
	public void delete(int id) {
		ht.delete(getMinutesById(id));
	}
	

}

