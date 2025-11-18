package controllerpackage.com;

import java.io.IOException;
import java.io.PrintWriter;

import UserDaopackage.com.UserDao;
import UserDaopackage.com.UserDaoImpl;
import dtopackage.com.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/update")
public class UpdateServlet extends HttpServlet{
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	String fulname=req.getParameter("full_name");
	String username=req.getParameter("username");
	String email=req.getParameter("email");
	int phone=Integer.parseInt(req.getParameter("phone"));
	String role=req.getParameter("role");
	
	HttpSession session=req.getSession(false);
	if(session==null&&session.getAttribute("userObj")==null) {
		return ;
	}
	
	
	
	User loguser=(User)session.getAttribute("userObj");
	loguser.setFull_name(fulname);
	loguser.setUsername(username);
	loguser.setEmail(email);
	loguser.setPhone(phone);
	loguser.setRole(role);
	
	
	
	UserDao dao=new UserDaoImpl();
	boolean istrue=dao.updatedetails(loguser);
	
	if(istrue) {

	    req.setAttribute("msg", "Details Updated Successfully!");

	    req.setAttribute("userdetails", loguser);
	    req.getRequestDispatcher("profile.jsp").forward(req, resp);

	} else {

	    req.setAttribute("error", "Details Not Updated!");
	    req.getRequestDispatcher("Edit.jsp").forward(req, resp);
	}

}
}
