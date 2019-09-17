package com.dtos;

import java.util.Date;

public class BoardDto {
	
	private int seq;
	private String title;
	private String content;
	private String email;
	private Date regdate;
	private String kindseq;
	private int readcount;
	private String enabled;
	private int refer;
	private int step;
	private int depth;
	
	private int rk; //추천수 
	
	public BoardDto() {
		super();
	}

	public BoardDto(int seq, String title, String content, String email, Date regdate, String kindseq, int readcount,
			String enabled, int refer, int step, int depth) {
		super();
		this.seq = seq;
		this.title = title;
		this.content = content;
		this.email = email;
		this.regdate = regdate;
		this.kindseq = kindseq;
		this.readcount = readcount;
		this.enabled = enabled;
		this.refer = refer;
		this.step = step;
		this.depth = depth;
	}
	
	public BoardDto(String title, String content, String email, String kindseq) {
		super();
		this.title = title;
		this.content = content;
		this.email = email;
		this.kindseq = kindseq;
	}

	public BoardDto(int seq, String title, String content) {
		super();
		this.seq = seq;
		this.title = title;
		this.content = content;
	}
	
	public BoardDto(int seq, String title, String content, String email, String kindseq) {
		super();
		this.seq = seq;
		this.title = title;
		this.content = content;
		this.email = email;
		this.kindseq = kindseq;
	}
	
	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getKindseq() {
		return kindseq;
	}

	public void setKindseq(String kindseq) {
		this.kindseq = kindseq;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	public int getRefer() {
		return refer;
	}

	public void setRefer(int refer) {
		this.refer = refer;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getRk() {
		return rk;
	}

	public void setRk(int rk) {
		this.rk = rk;
	}

	@Override
	public String toString() {
		return "BoardDto [seq=" + seq + ", title=" + title + ", content=" + content + ", email=" + email + ", regdate="
				+ regdate + ", kindseq=" + kindseq + ", readcount=" + readcount + ", enabled=" + enabled + ", refer=" + refer
				+ ", step=" + step + ", depth=" + depth + "]";
	}
	
}
