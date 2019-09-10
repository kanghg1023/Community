package com.dtos;

public class ListDto {
	
	private int kindseq;
	private String enabled;
	private String kind;
	private String kindcontent;
	
	public ListDto() {
		super();
	}

	public ListDto(int kindseq, String enabled, String kind, String kindcontent) {
		super();
		this.kindseq = kindseq;
		this.enabled = enabled;
		this.kind = kind;
		this.kindcontent = kindcontent;
	}
	
	public ListDto(String enabled, String kind, String kindcontent) {
		super();
		this.enabled = enabled;
		this.kind = kind;
		this.kindcontent = kindcontent;
	}

	public int getKindseq() {
		return kindseq;
	}

	public void setKindseq(int kindseq) {
		this.kindseq = kindseq;
	}

	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getKindcontent() {
		return kindcontent;
	}

	public void setKindcontent(String kindcontent) {
		this.kindcontent = kindcontent;
	}

	@Override
	public String toString() {
		return "ListDto [kindseq=" + kindseq + ", enabled=" + enabled + ", kind=" + kind + ", kindcontent="
				+ kindcontent + "]";
	}

	
	
}
