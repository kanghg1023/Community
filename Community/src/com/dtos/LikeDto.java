package com.dtos;

public class LikeDto {

	private String email;
	private int seq;
	
	public LikeDto() {
		super();
	}

	public LikeDto(String email, int seq) {
		super();
		this.email = email;
		this.seq = seq;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	@Override
	public String toString() {
		return "Like [email=" + email + ", seq=" + seq + "]";
	}
	
}
