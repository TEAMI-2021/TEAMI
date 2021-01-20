package org.teami.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int startList;
	private int amount;
	
	public Criteria() {
		this(0, 10);
	}
	
	public Criteria(int startList, int amount) {
		this.startList = startList;
		this.amount = amount;
	}
}
