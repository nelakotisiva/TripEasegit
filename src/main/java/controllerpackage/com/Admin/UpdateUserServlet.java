package controllerpackage.com.Admin;

import java.io.IOException;

import Daopackage.com.UserDao;
import Daopackage.com.UserDaoImpl;
import dtopackage.com.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateUser")
public class UpdateUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String username = req.getParameter("username");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        long phone = Long.parseLong(req.getParameter("phone"));
        String role = req.getParameter("role");

        UserDao dao = new UserDaoImpl();

        User u = new User(id, username, null, email, fullname, phone, role);

        boolean updated = dao.updatedetails(u);

        if (updated) {
            resp.sendRedirect("ManageUsers");
        } else {
            req.setAttribute("error", "Update failed!");
            req.setAttribute("userObj", u);
            req.getRequestDispatcher("edit_user.jsp").forward(req, resp);
        }
    }
}

