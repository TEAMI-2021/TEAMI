package org.teami.mapper;

import org.teami.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String user_id);
}
