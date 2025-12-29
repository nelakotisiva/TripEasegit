package controllerpackage.com.Admin;

import java.io.IOException;

import Daopackage.com.AdminBookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/AdminManageBookings")
public class AdminManageBookingsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("adminObj") == null) {
            resp.sendRedirect("Adminlogin.jsp");
            return;
        }

        AdminBookingDAO dao = new AdminBookingDAO();
        req.setAttribute("bookings", dao.getAllAdminBookings());
        req.getRequestDispatcher("AdminManageBookings.jsp").forward(req, resp);
    }
}
