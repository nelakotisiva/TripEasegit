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
