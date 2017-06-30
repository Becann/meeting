package com.cgutech.meeting.Dao.impl;



import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Service;

import com.cgutech.meeting.Dao.UserDao;
import com.cgutech.meeting.entity.User;
import com.cgutech.meeting.utils.MD5;

@Service
public class UserDaoImpl implements UserDao {

	@Autowired
	HibernateTemplate ht;

	@Override
	public User getUser(String username) {
		@SuppressWarnings("unchecked")
		List<User> userEntitys= ht.find("from User where name=?",username);
		if(userEntitys==null||userEntitys.size()==0){
			return null;
		}
		return userEntitys.get(0);
	}

	@Override
	public void changePassword(String username, String password) {
		@SuppressWarnings("unchecked")
		List<User> userEntitys= ht.find("from User where name=?",username);
		if(userEntitys!=null&&userEntitys.size()!=0){
			User userEntity =userEntitys.get(0);
			
			userEntity.setPswd(MD5.encode(password));
			ht.update(userEntity);
		}
		
		
	}

	@Override
	public void addUser(User userEntity) {
		userEntity.setPswd(MD5.encode(userEntity.getPswd()));
		ht.save(userEntity);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> getUsers(final String username,final int offset,final int limit) {
		return this.ht
				.executeFind(new HibernateCallback<List<User>>() {

					@Override
					public List<User> doInHibernate(Session session)
							throws HibernateException, SQLException {
						Query query = session.createQuery("from User order by name");
						if(username!=null){
							query =session.createQuery("from User where name=?");
							query.setParameter(0, username);
						}
						if(offset!=0&&limit!=0){
							query.setFirstResult(offset);
							query.setMaxResults(limit);
	
						}
						return query.list();
					}

				});
	}

	@Override
	public int countUser() {
		long  count = 0;
		String hql = "select count(*) from User";
		count = (long)this.ht.find(hql).iterator().next();	
		return (int)count;
	}

	@Override
	public void deleteUser(int id) {
		User userEntity=ht.get(User.class, id);
		ht.delete(userEntity);
		
	}

	
	@Override
	public int countFile() {
		long  count = 0;
		String hql = "select count(*) from FileEntity";
		count = (long)this.ht.find(hql).iterator().next();	
		return (int)count;
	}

}

