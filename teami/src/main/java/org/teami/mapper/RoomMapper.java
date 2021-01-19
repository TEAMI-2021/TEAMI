package org.teami.mapper;

import org.teami.domain.RoomVO;

public interface RoomMapper {

	public RoomVO read(String room_code);
	
	public void insert(RoomVO room);
	
	public void insertRoomMember(RoomVO room);
}
