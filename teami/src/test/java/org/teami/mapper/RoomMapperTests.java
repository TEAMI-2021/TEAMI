package org.teami.mapper;

import java.util.ArrayList;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.teami.domain.RoomMemberVO;
import org.teami.domain.RoomVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class RoomMapperTests {
	@Setter(onMethod_ = @Autowired)
	private RoomMapper mapper;
	
	
	
	@Test
	 public void testInsertRoom() {
		
		ArrayList<RoomMemberVO>roomMeberList = new ArrayList<>();
		
		RoomVO room = new RoomVO();
		room.setRoom_code("123");
		room.setRoom_name("테스트");
		room.setUser_id("test123");
		
		//member.setAuthList(auth);
		
		mapper.insert(room);
		mapper.insertRoomMember(room);
		//member.getAuthList().forEach(authVO -> mapper.insert_auth(authVO));
	
	}
	
	@Test
	public void testRead() {
		
		RoomVO vo = mapper.read("1234");
		
		log.info(vo);
		vo.getRoomMemberList().forEach(RoomMemberVO -> log.info(RoomMemberVO));
		
	}
	
	@Test
	public void testAddMember() {
		RoomMemberVO roomMember = new RoomMemberVO();
		roomMember.setRoom_code("1234");
		roomMember.setUser_id("user1");
		
		mapper.insertRoomMember(roomMember);
	}
	
	@Test
	public void testRoomChk() {
		
		int i = mapper.roomChk("1234");
		
		log.info(i);
		
	}
	
}
