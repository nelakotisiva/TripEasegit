package controllerpackage.com;

import java.io.IOException;

import UserDaopackage.com.UserDao;
import UserDaopackage.com.UserDaoImpl;
import dtopackage.com.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    int id=Integer.parseInt(req.getParameter("User_id")) ;
	    
		String username=req.getParameter("Username");
	      String email=req.getParameter("email");
	      String password=req.getParameter("password");
	      String conpass=req.getParameter("Confirm_password");
	      String fullname=req.getParameter("full_name");
	      long phone=Long.parseLong(req.getParameter("phone"));
	      String role=req.getParameter("role");
	      
	      User u=new User(id, username, email, password, fullname, phone, role);
	      
	      UserDao dao=new UserDaoImpl();
	      boolean isregistered=dao.registerUser(u);
	      
	      if(isregistered) {
	    	  req.getRequestDispatcher("Login.jsp").forward(req, resp);
	      }
	      else {
	    	  req.getRequestDispatcher("Register.jsp").forward(req, resp);
	      }
	      
	      
	}
}
