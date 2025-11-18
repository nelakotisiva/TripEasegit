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
import jakarta.servlet.http.HttpSession;

@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {
	UserDao dao=null;
	public RegisterServlet() {
		dao=new UserDaoImpl();
	}

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
	      
	      User u=new User(id, username, password, email, fullname, phone, role);
	      boolean istrue=dao.registerUser(u);
	      if(istrue) {
	    	  req.getRequestDispatcher("Login.jsp").forward(req, resp);;
	      }
	      else {
	    	  req.getRequestDispatcher("Register.jsp").forward(req, resp);;

	      }
	}
}
