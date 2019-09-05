package com.dtos;

public class List {
	
	private String kind;
	private String enabled;
	
	public List() {
		super();
	}

	public List(String kind, String enabled) {
		super();
		this.kind = kind;
		this.enabled = enabled;
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
		return "List [kind=" + kind + ", enabled=" + enabled + "]";
	}
	
}
