package controllerpackage.com;

import java.io.IOException;
import java.io.PrintWriter;

import Daopackage.com.UserDao;
import Daopackage.com.UserDaoImpl;
import dtopackage.com.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/update")
public class UpdateServlet extends HttpServlet {
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	String fullName = req.getParameter("full_name");
	String username = req.getParameter("username");
	String email = req.getParameter("email");
	long phone = Long.parseLong(req.getParameter("phone"));
	String role = req.getParameter("role");

	HttpSession session = req.getSession(false);

	if(session == null || session.getAttribute("userObj") == null) {
		resp.sendRedirect("Login.jsp");
		return;
	}

	User user = (User)session.getAttribute("userObj");

	user.setFull_name(fullName);
	user.setUsername(username);
	user.setEmail(email);
	user.setPhone(phone);
	user.setRole(role);

	UserDao dao = new UserDaoImpl();
	boolean updated = dao.updatedetails(user);

	if(updated) {
		session.setAttribute("userObj", user);
		req.setAttribute("msg", "Profile Updated Successfully!");
		req.setAttribute("userdetails", user);
		req.getRequestDispatcher("profile.jsp").forward(req, resp);
	} 
	else {
		req.setAttribute("error", "Update Failed!");
		req.setAttribute("userdetails", user);
		req.getRequestDispatcher("Edit.jsp").forward(req, resp);
	}
}
}
