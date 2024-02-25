package com.feb.join.dao;

import org.springframework.stereotype.Repository;

import com.feb.join.entity.EmailAuth;

@Repository
public interface EmailAuthDao {
	
	public int addEmailAuth(EmailAuth dto);
}
