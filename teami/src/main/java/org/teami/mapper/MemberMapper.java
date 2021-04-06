package org.teami.mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;
import org.teami.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String user_id);
	
	public void insert(MemberVO member);
	
	public void insertAuth(MemberVO member);
	//public void insert_auth(AuthVO auth);
	
	public int memberChk(String user_id);
	
	public int pwChk(String user_pw);
	
	public void deleteUser(@Param("user_id") String user_id);
	
    public void updatePW(MemberVO member);
    }
