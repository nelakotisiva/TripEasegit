package UserDaopackage.com;

import dtopackage.com.User;

public class UserDaoImpl implements UserDao{

	@Override
	public boolean registerUser(User u) {
		String iqry="insert into user values(?,?,?,?,?,?,?)";
		
		
		return false;
	}

	@Override
	public User loginUser(String username, String password) {
		// TODO Auto-generated method stub
		return null;
	}

	

}
