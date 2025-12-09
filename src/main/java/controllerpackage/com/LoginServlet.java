package controllerpackage.com;

import java.io.IOException;
import java.io.PrintWriter;

import Daopackage.com.UserDao;
import Daopackage.com.UserDaoImpl;
import dtopackage.com.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {

    UserDao dao = null;

    public LoginServlet() {
        dao = new UserDaoImpl();
    }

    // 🟦 Handles GET requests → open login page
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect("Login.jsp");
    }

    // 🟩 Handles POST requests → validate login
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User u = dao.loginUser(username, password);

        HttpSession session = req.getSession();
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        if (u != null) {
            session.setAttribute("userObj", u);
            resp.sendRedirect("Dashboard.jsp");  // Better than include()
        } else {
            session.setAttribute("msg", "Invalid email or password!");
            resp.sendRedirect("Login.jsp");
        }
    }
}
