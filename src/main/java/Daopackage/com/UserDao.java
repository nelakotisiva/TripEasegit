package Daopackage.com;

import java.util.List;

import dtopackage.com.User;

public interface UserDao {
	boolean registerUser(User u);
	User loginUser(String username,String password);
	User getid(int id);
	boolean updatedetails(User u);
}
