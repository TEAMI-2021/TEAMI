package org.teami.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum;
	private int amount;
	private String room_code;
	
	private String type;
	private String keyword;
	
	public Criteria() {
		this.setPageNum(1);
		this.setAmount(10);
	}
	
	public Criteria(int pageNum, int amount, String room_code) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.room_code=room_code;
	}
	
	public int getSkip() {
		return (this.pageNum-1)*this.amount;
	}
	
	public String[] getTypeArr() {
		return type == null? new String[] {}: type.split("");
	}
}
