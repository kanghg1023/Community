package com.dtos;

public class UserDto {

	private String email;
	private String password;
	private String nick;
	private String phone;
	private String enabled;
	private String role;
	
	
	
	
	public UserDto() {
		super();
	}

	public UserDto(String email, String password, String nick, String phone, String enabled, String role) {
		super();
		this.email = email;
		this.password = password;
		this.nick = nick;
		this.phone = phone;
		this.enabled = enabled;
		this.role = role;
	}

	
	
	public UserDto(String email, String nick, String phone) {
		super();
		this.email = email;
		this.nick = nick;
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	@Override
	public String toString() {
		return "BoardDto [email=" + email + ", password=" + password + ", nick=" + nick + ", phone=" + phone
				+ ", enabled=" + enabled + ", role=" + role + "]";
	}
	
}
