package com.dtos;

import java.util.Date;

public class BoardDto {
	
	private int seq;
	private String title;
	private String content;
	private String email;
	private Date regdate;
	private String kind;
	private int readcount;
	private String enabled;
	private int refer;
	private int step;
	private int depth;
	
	public BoardDto() {
		super();
	}

	public BoardDto(int seq, String title, String content, String email, Date regdate, String kind, int readcount,
			String enabled, int refer, int step, int depth) {
		super();
		this.seq = seq;
		this.title = title;
		this.content = content;
		this.email = email;
		this.regdate = regdate;
		this.kind = kind;
		this.readcount = readcount;
		this.enabled = enabled;
		this.refer = refer;
		this.step = step;
		this.depth = depth;
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

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
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

	@Override
	public String toString() {
		return "BoardDto [seq=" + seq + ", title=" + title + ", content=" + content + ", email=" + email + ", regdate="
				+ regdate + ", kind=" + kind + ", readcount=" + readcount + ", enabled=" + enabled + ", refer=" + refer
				+ ", step=" + step + ", depth=" + depth + "]";
	}
	
}
