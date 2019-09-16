package com.dtos;

import java.util.Date;

public class CommentDto {

	private int reseq;
	private int seq;
	private String content;
	private String email;
	private Date regdate;
	private int refer;
	private int step;
	private int depth;
	
	public CommentDto() {
		super();
	}

	public CommentDto(int reseq, int seq, String content, String email, Date regdate, int refer, int step, int depth) {
		super();
		this.reseq = reseq;
		this.seq = seq;
		this.content = content;
		this.email = email;
		this.regdate = regdate;
		this.refer = refer;
		this.step = step;
		this.depth = depth;
	}
	
	public CommentDto(int reseq, int seq, String content, String email) {
		super();
		this.reseq = reseq;
		this.seq = seq;
		this.content = content;
		this.email = email;
	}

	public int getReseq() {
		return reseq;
	}

	public void setReseq(int reseq) {
		this.reseq = reseq;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
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
		return "Comment [reseq=" + reseq + ", seq=" + seq + ", content=" + content + ", email=" + email + ", regdate="
				+ regdate + ", refer=" + refer + ", step=" + step + ", depth=" + depth + "]";
	}
	
}
