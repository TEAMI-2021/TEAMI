package org.teami.service;

import java.util.List;

import org.teami.domain.BoardVO;
import org.teami.domain.Criteria;
import org.teami.domain.RoomMemberVO;
import org.teami.domain.RoomVO;

public interface RoomService {
	public void register(RoomVO room);
	
	public RoomVO get(String room_code);
	
	public void addMember(RoomMemberVO roomMember);
	
	public int roomChk(String room_code);
	
	public List<RoomVO> getList(String user_id);
	
	public void deleteRoom(String user_id, String room_code);
}
