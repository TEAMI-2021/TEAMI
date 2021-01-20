package org.teami.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.teami.domain.RoomVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class RoomServiceTests {
	
	@Setter(onMethod_ = {@Autowired })
	private RoomService service;
	
	@Test
	public void testRegister(){
		
		RoomVO room = new RoomVO();
		room.setRoom_code("1234");
		room.setRoom_name("test1234");
		room.setUser_id("user7");
		//member.setAuthList(auth);
		
		service.register(room);
		
		log.info("방등록");
	}
	
	@Test
	public void testRead() {
		
		RoomVO vo = service.get("1234");
		
		log.info(vo);
		vo.getRoomMemberList().forEach(RoomMemberVO -> log.info(RoomMemberVO));
		
	}
}
