package org.teami.service;

import org.teami.domain.MemberVO;

public interface MemberService {
	
	public void joinIn(MemberVO member);
	
	public MemberVO get(String user_id);
	
	//Sting�씤媛� int�씤媛�
	public int memberChk(String user_id);
	
	public void deleteUser(String user_id);

	public void updatePW(MemberVO member);
}
