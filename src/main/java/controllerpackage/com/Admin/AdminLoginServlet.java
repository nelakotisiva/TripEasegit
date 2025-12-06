package controllerpackage.com.Admin;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import Daopackage.com.AdminDAO;
import dtopackage.com.Admin;

@WebServlet("/AdminServlet")
public class AdminLoginServlet extends HttpServlet {

    private AdminDAO dao = new AdminDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Admin admin = dao.adminLogin(username, password);

        if (admin != null) {

            HttpSession session = req.getSession();
            session.setAttribute("adminObj", admin);

            // ----------------------------
            // SET ALL DASHBOARD COUNTS
            // ----------------------------

            session.setAttribute("totalUsers", dao.count("user"));
            session.setAttribute("totalBookings", dao.count("booking"));
            session.setAttribute("totalDestinations", dao.count("destination"));
            session.setAttribute("totalPayments", dao.count("payment"));

            // New tables for full admin dashboard
            session.setAttribute("totalHotels", dao.count("hotel"));
            session.setAttribute("totalRestaurants", dao.count("restaurant"));
            session.setAttribute("totalCabs", dao.count("cab_rental"));
            session.setAttribute("totalReviews", dao.count("review"));

            // Redirect to dashboard
            resp.sendRedirect("AdminDashboard.jsp");

        } else {

            req.setAttribute("msg", "Invalid Credentials!");
            req.getRequestDispatcher("Adminlogin.jsp").forward(req, resp);
        }
    }
}
