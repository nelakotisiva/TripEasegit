package controllerpackage.com;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dtopackage.com.User;
import UserDaopackage.com.UserDao;
import UserDaopackage.com.UserDaoImpl;

@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {

    UserDao dao = null;

    public RegisterServlet() {
        dao = new UserDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        // Read form data
        int id = Integer.parseInt(req.getParameter("User_id"));
        String username = req.getParameter("Username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullName = req.getParameter("full_name");
        long phone = Long.parseLong(req.getParameter("phone"));
        String role = req.getParameter("role");

        // Create User Object
        User u = new User(id, username, password, email, fullName, phone, role);

        // Call DAO
        boolean status = dao.registerUser(u);

        if (status) {
            resp.getWriter().print("Registration Successful!");
           req.getRequestDispatcher("Login.jsp").forward(req, resp);
        } else {
            resp.getWriter().print("Registration Failed!");
        }
    }
}
package controllerpackage.com;

import java.io.IOException;

import Daopackage.com.UserDao;
import Daopackage.com.UserDaoImpl;
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
	      
	   // ********** PASSWORD VALIDATION **********
	        if (!password.equals(conpass)) {

	            // Popup message using JavaScript
	            resp.setContentType("text/html");
	            resp.getWriter().println("<script type=\"text/javascript\">");
	            resp.getWriter().println("alert('Password and Confirm Password do not match!');");
	            resp.getWriter().println("location='Register.jsp';"); // redirect back to register page
	            resp.getWriter().println("</script>");
	            return;
	        }
	      
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
