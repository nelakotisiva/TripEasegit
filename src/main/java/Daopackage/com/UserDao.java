package Daopackage.com;

import java.util.List;

import dtopackage.com.User;

public interface UserDao {
	boolean registerUser(User u);
	User loginUser(String username,String password);
	User getid(int id);
	boolean updatedetails(User u);
	
//	For ADMIN purpose
	List<User> getAllUsers();
	boolean deleteUser(int id);
	boolean addUser(User user);
}