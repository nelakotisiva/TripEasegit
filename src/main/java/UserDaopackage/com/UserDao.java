package UserDaopackage.com;

import dtopackage.com.User;

public interface UserDao {
	boolean registerUser(User u);
	User loginUser(String username,String password);
	
}
