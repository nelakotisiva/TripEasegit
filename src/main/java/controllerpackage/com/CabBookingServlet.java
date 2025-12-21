package controllerpackage.com;

import dtopackage.com.User;
import dtopackage.com.Cab;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import Daopackage.com.CabDAO;

@WebServlet("/CabBookingServlet")
public class CabBookingServlet extends HttpServlet {

    private CabDAO dao;

    @Override
    public void init() {
        dao = new CabDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("userObj") : null;

        if (user == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        List<Cab> bookedCabs = dao.getMyBookings(user.getUser_id());
        req.setAttribute("bookedCabs", bookedCabs);

        req.getRequestDispatcher("CabBookings.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("userObj") : null;

        if (user == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        int rentalId = Integer.parseInt(req.getParameter("rentalId"));
        dao.cancelBooking(user.getUser_id(), rentalId);

        resp.sendRedirect("CabBookingServlet");
    }
}

