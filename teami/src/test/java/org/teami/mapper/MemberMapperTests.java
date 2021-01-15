package org.teami.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.teami.domain.AuthVO;
import org.teami.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class MemberMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	/*
	@Test
	
	public void testRead() {
		
		MemberVO vo = mapper.read("admin90");
		
		log.info(vo);
		vo.getAuthList().forEach(authVO -> log.info(authVO));
		
	}
	*/
	@Test
	 public void testInsertMember() {
		
		ArrayList<AuthVO>auth = new ArrayList<>();
		auth.add(new AuthVO("user123", "ROLE_MEMBER"));
		
		MemberVO member = new MemberVO();
		member.setUser_id("user123");
		member.setUser_pw("pw123");
		member.setUser_name("사용자123");
		member.setAuth("ROLE_MEMBER");
		//member.setAuthList(auth);
		
		mapper.insert(member);
		mapper.insertAuth(member);
		//member.getAuthList().forEach(authVO -> mapper.insert_auth(authVO));
	
	}
	
}
