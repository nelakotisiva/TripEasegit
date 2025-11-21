package dtopackage.com;


public class User {
  private int user_id;
  private String Username;
  private String password;
  private String email;
 
  private String Confirm_password;
  private String full_name;
  private long phone;
  private String role;
  
 public User() {
	// TODO Auto-generated constructor stub
}

  public User(int user_id, String username,  String password,String email, String full_name,
		long phone, String role) {
	super();
	this.user_id = user_id;
	this.Username = username;
	this.email = email;
	this.password = password;

	this.full_name = full_name;
	this.phone = phone;
	this.role = role;
}

 
  public int getUser_id() {
	return user_id;
  }

  public void setUser_id(int user_id) {
	this.user_id = user_id;
  }

  public String getUsername() {
	return Username;
  }

  public void setUsername(String username) {
	Username = username;
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

  public String getConfirm_password() {
	return Confirm_password;
  }

  public void setConfirm_password(String confirm_password) {
	Confirm_password = confirm_password;
  }

  public String getFull_name() {
	return full_name;
  }

  public void setFull_name(String full_name) {
	this.full_name = full_name;
  }

  public long getPhone() {
	return phone;
  }

  public void setPhone(long phone) {
	this.phone = phone;
  }

  public String getRole() {
	return role;
  }

  public void setRole(String role) {
	this.role = role;
  }

}
