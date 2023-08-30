package About;

public class aboutEntity {
	private int id;
	private String name;
	private String image_url;
	private String definition;
	private String causes;
	private String symptoms;
	private String precautions;
	private String diet_management;
	
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
	public String getImage_url() {
		return image_url;
	}
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	public String getDefinition() {
		return definition;
	}
	public void setDefinition(String definition) {
		this.definition = definition;
	}
	public String getCauses() {
		return causes;
	}
	public void setCauses(String causes) {
		this.causes = causes;
	}
	public String getSymptoms() {
		return symptoms;
	}
	public void setSymptoms(String symptoms) {
		this.symptoms = symptoms;
	}
	public String getPrecautions() {
		return precautions;
	}
	public void setPrecautions(String precautions) {
		this.precautions = precautions;
	}
	public String getDiet_management() {
		return diet_management;
	}
	public void setDiet_management(String diet_management) {
		this.diet_management = diet_management;
	}
}
