package com.dtos;

public class LikeDto {

	private String email;
	private String seq;
	
	public LikeDto() {
		super();
	}

	public LikeDto(String email, String seq) {
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

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	@Override
	public String toString() {
		return "Like [email=" + email + ", seq=" + seq + "]";
	}
	
}
