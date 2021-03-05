package org.teami.service;

import org.teami.domain.MemberVO;

public interface MemberService {
	
	public void joinIn(MemberVO member);
	
	public MemberVO get(String user_id);
	
	//Sting인가 int인가
	public int memberChk(String user_id);
}
