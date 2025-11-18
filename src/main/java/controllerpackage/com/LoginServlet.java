package controllerpackage.com;

import java.io.IOException;
import java.io.PrintWriter;

import UserDaopackage.com.UserDao;
import UserDaopackage.com.UserDaoImpl;
import dtopackage.com.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/Login")
public class LoginServlet extends HttpServlet{

	UserDao dao=null;
	public LoginServlet() {
		dao=new UserDaoImpl();
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username=req.getParameter("username");
		String password=req.getParameter("password");
		User u=dao.loginUser(username,password);
		
		HttpSession session=req.getSession();
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		if(u!=null)
		{
			session.setAttribute("userObj", u);
			out.print("Logged in Successfully");
			RequestDispatcher rd=req.getRequestDispatcher("Dashboard.jsp");
			rd.include(req, resp);
		}else {
			out.print("Invalid email or password");
			RequestDispatcher rd=req.getRequestDispatcher("Login.jsp");
			rd.include(req,resp);
		}
	}
}
