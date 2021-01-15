package org.teami.mapper;

import org.teami.domain.AuthVO;
import org.teami.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String user_id);
	
	public void insert(MemberVO member);
	
	public void insertAuth(MemberVO member);
	//public void insert_auth(AuthVO auth);
}
