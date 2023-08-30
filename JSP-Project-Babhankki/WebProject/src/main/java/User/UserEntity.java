package User;

public class UserEntity {
	int id;
	String name;
	String userid;
	String email;
	String password;
	String role;
	String[] disease;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
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
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getDiseaseString() {
		if(disease != null) {
			return String.join(",", disease);
		}
		return null;
	}
	public void setDisease(String[] disease) {
		this.disease = disease;
	}
}
