package controllerpackage.com;

import java.io.IOException;
import java.util.List;

import UserDaopackage.com.UserDao;
import UserDaopackage.com.UserDaoImpl;
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
	HttpSession session=req.getSession(false);
	
	if(session!=null && session.getAttribute("userObj")!=null) {
		User user =(User)session.getAttribute("userObj");
		int id=user.getUser_id();
		UserDao dao=new UserDaoImpl();
		User userdetails= dao.getid(id);

		
		req.setAttribute("userdetails",userdetails );
		req.getRequestDispatcher("profile.jsp").forward(req, resp);
	}
	else {
		req.getRequestDispatcher("Login.jsp").forward(req, resp);
	}
}
}
