package org.teami.service;

import org.teami.domain.RoomMemberVO;
import org.teami.domain.RoomVO;

public interface RoomService {
	public void register(RoomVO room);
	
	public RoomVO get(String room_code);
	
	public void addMember(RoomMemberVO roomMember);
}
