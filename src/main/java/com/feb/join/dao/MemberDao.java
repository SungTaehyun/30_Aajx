package com.feb.join.dao;

import java.util.HashMap;

import org.springframework.stereotype.Repository;

@Repository
public interface MemberDao {
	public int confirmId(String memberId);
	public int signUp(HashMap<String, String> params);
}
