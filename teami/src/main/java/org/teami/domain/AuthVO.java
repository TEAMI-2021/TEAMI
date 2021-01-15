package org.teami.domain;

import lombok.Data;

@Data
public class AuthVO {
	public AuthVO(String string, String string2) {
		// TODO Auto-generated constructor stub
		user_id=string;
		auth=string2;
	}
	private String user_id;
	private String auth;
}
