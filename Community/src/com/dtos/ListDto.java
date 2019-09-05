package com.dtos;

public class ListDto {
	
	private int kindseq;
	private String kind;
	private String enabled;
	
	public ListDto() {
		super();
	}

	public ListDto(int kindseq, String kind, String enabled) {
		super();
		this.kindseq = kindseq;
		this.kind = kind;
		this.enabled = enabled;
	}

	public int getKindseq() {
		return kindseq;
	}

	public void setKindseq(int kindseq) {
		this.kindseq = kindseq;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	@Override
	public String toString() {
		return "ListDto [kindseq=" + kindseq + ", kind=" + kind + ", enabled=" + enabled + "]";
	}
	
}
