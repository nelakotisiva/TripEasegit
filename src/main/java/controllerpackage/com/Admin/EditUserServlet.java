package controllerpackage.com.Admin;

import java.io.IOException;

import Daopackage.com.UserDao;
import Daopackage.com.UserDaoImpl;
import dtopackage.com.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/edit")
public class EditUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        UserDao dao = new UserDaoImpl();
        User u = dao.getid(id);

        if (u != null) {
            req.setAttribute("userObj", u);  // Set user for JSP
            req.getRequestDispatcher("edit_user.jsp").forward(req, resp);
        } else {
            req.setAttribute("msg", "User not found!");
            req.getRequestDispatcher("Adminmanage_users.jsp").forward(req, resp);
        }
    }
}

