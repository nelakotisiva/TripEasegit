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

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
	HttpSession session = req.getSession(false);

	if(session != null && session.getAttribute("userObj") != null) {
		
		User user = (User)session.getAttribute("userObj");
		UserDao dao = new UserDaoImpl();
		User userDetails = dao.getid(user.getUser_id());

		req.setAttribute("userdetails", userDetails);
		req.getRequestDispatcher("profile.jsp").forward(req, resp);

	} else {
		resp.sendRedirect("Login.jsp");
	}
}
}
