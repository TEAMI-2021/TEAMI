package org.teami.domain;

import lombok.Getter;
import lombok.ToString;
import lombok.extern.log4j.Log4j;

@Log4j
@Getter
@ToString
public class PageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev, next;

	private int total;
	private Criteria cri;

	public PageDTO(Criteria cri, int total) {

		this.cri = cri;
	    this.total = total;

	    log.info("cri.getStartList() : " + cri.getStartList());
	    log.info("(cri.getStartList()+1) : " + (cri.getStartList()+1));
	    log.info("(cri.getStartList()+1)/(double)cri.getAmount() : " + (cri.getStartList()+1)/(double)cri.getAmount());
	    log.info("((cri.getStartList()+1)/(double)cri.getAmount())/10.0 : " + ((cri.getStartList()+1)/(double)cri.getAmount())/10.0);
	    log.info("Math.ceil(((cri.getStartList()+1)/(double)cri.getAmount())/10.0) : " + Math.ceil(((cri.getStartList()+1)/(double)cri.getAmount())/10.0));
	    this.endPage = (int) (Math.ceil(((cri.getStartList()+1)/(double)cri.getAmount())/10.0)*10);
	    log.info("endPage..........." + endPage);
	    
	    this.startPage = this.endPage - 9;
//	    this.startPage = 1;
	    log.info("startPage..........." + startPage);

	    int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));

	    if (realEnd <= this.endPage) {
	      this.endPage = realEnd;
	    }

	    this.prev = this.startPage > 1;

	    this.next = this.endPage < realEnd;
	  }
}
