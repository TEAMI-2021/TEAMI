package org.teami.service;

import org.springframework.stereotype.Service;
import org.teami.domain.RoomVO;
import org.teami.mapper.RoomMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class RoomServiceImpl implements RoomService{
	
	private RoomMapper mapper;
	
	@Override
	public void register(RoomVO room) {
		log.info("register Room.......");
		mapper.insert(room);
		mapper.insertRoomMember(room);
	}

	@Override
	public RoomVO get(String room_code) {
		// TODO Auto-generated method stub
		return null;
	}

}
