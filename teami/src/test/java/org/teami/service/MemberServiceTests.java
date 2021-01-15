package org.teami.service;

import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.teami.domain.AuthVO;
import org.teami.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class MemberServiceTests {
	
	@Setter(onMethod_ = {@Autowired })
	private MemberService service;
	
	
	//@Setter(onMethod_ = @Autowired)
	//private PasswordEncoder pwencoder;
	
	/*
	 @Test 
	 public void testExist(){
	 	log.info(service); 
	 	assertNotNull(service); 
	 }
	 */
	
	@Test
	public void testRegister(){
		
		ArrayList<AuthVO>auth = new ArrayList<>();
		auth.add(new AuthVO("user2", "ROLE_MEMBER"));
		
		MemberVO member = new MemberVO();
		member.setUser_id("user6");
		member.setUser_pw("pw6");
		member.setUser_name("사용자6");
		member.setAuth("ROLE_MEMBER");
		//member.setAuthList(auth);
		
		service.joinIn(member);
		
		log.info("멤버등록");
	}
	
}
