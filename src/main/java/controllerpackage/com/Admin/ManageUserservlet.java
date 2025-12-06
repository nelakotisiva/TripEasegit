package controllerpackage.com.Admin;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import Daopackage.com.UserDao;
import Daopackage.com.UserDaoImpl;
import dtopackage.com.User;

@WebServlet("/ManageUsers")
public class ManageUserservlet extends HttpServlet {

    private UserDao userDAO = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            listUsers(request, response);
            return;
        }

        switch (action) {
            case "add":
                request.getRequestDispatcher("AdminAddUser.jsp").forward(request, response);
                break;

            case "edit":
                int idEdit = Integer.parseInt(request.getParameter("id"));
                User userEdit = userDAO.getid(idEdit);
                request.setAttribute("user", userEdit);
                request.getRequestDispatcher("AdminEditUser.jsp").forward(request, response);
                break;

            case "delete":
                int idDel = Integer.parseInt(request.getParameter("id"));
                userDAO.deleteUser(idDel);
                response.sendRedirect("ManageUsers");
                break;

            default:
                listUsers(request, response);
                break;
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> list = userDAO.getAllUsers();
        request.setAttribute("users", list);
        request.getRequestDispatcher("AdminManageUsers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            User u = new User();
            u.setUser_id((int)(Math.random()*9000)+1000);
            u.setFull_name(request.getParameter("full_name"));
            u.setUsername(request.getParameter("username"));
            u.setEmail(request.getParameter("email"));
            u.setPassword(request.getParameter("password"));
            u.setPhone(Long.parseLong(request.getParameter("phone")));
            u.setRole(request.getParameter("role"));

            userDAO.addUser(u);
            response.sendRedirect("ManageUsers");
        }

        else if ("update".equals(action)) {
            User u = new User();
            u.setUser_id(Integer.parseInt(request.getParameter("user_id")));
            u.setFull_name(request.getParameter("full_name"));
            u.setUsername(request.getParameter("username"));
            u.setEmail(request.getParameter("email"));
            u.setPhone(Long.parseLong(request.getParameter("phone")));
            u.setRole(request.getParameter("role"));

            userDAO.updatedetails(u);
            response.sendRedirect("ManageUsers");
        }
    }
}
