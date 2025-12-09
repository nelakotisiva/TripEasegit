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

@WebServlet("/ProfileEditServlet")
public class ProfileEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session != null && session.getAttribute("userObj") != null) {

            User logUser = (User) session.getAttribute("userObj");
            UserDao dao = new UserDaoImpl();
            User userDetails = dao.getid(logUser.getUser_id());

            req.setAttribute("userdetails", userDetails);
            req.getRequestDispatcher("Edit.jsp").forward(req, resp);
        } 
        else {
            resp.sendRedirect("Login.jsp");
        }
    }
}
