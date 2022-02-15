/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;
import java.io.InputStream;
/**
 *
 * @author fauzi
 */
public class rewardsBean implements java.io.Serializable {
    
    private int id;
    private String name;
    private String description;
    private String image;
    private String category;
    private String img;
    private InputStream inputstream;
    private int total;
    
    public rewardsBean() {
    }

    public int getId() {
        return id;
    }
    
    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public String getImage() {
        return image;
    }
    
    public String getCategory() {
        return category;
    }
    
    public String getImg() {
        return img;
    }

    public InputStream getInputStream() {
        return inputstream;
    }

    public int getTotal() {
        return total;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    public void setImg(String img) {
        this.img = img;
    }

    public void setInputStream(InputStream inputstream) {
        this.inputstream = inputstream;
    }
    
    public void setTotal(int total) {
        this.total = total;
    }
}