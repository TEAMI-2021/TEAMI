package org.teami.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.teami.domain.MemberVO;
import org.teami.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService{
	
	private MemberMapper mapper;

	private PasswordEncoder pwencoder;
	
	@Override
	public void joinIn(MemberVO member) {
		
		log.info("register.......");
		member.setUser_pw(pwencoder.encode(member.getUser_pw()));
		mapper.insert(member);
		mapper.insertAuth(member);
		//member.getAuthList().forEach(authVO -> mapper.insert_auth(authVO));
		
	}

	@Override
	public MemberVO get(String user_id) {
		return null;
	}
	
	
}
