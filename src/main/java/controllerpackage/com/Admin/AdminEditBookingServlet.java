package controllerpackage.com.Admin;


import java.io.IOException;

import Daopackage.com.BookingDAOImpl;
import dtopackage.com.Booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminEditBooking")
public class AdminEditBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("adminObj") == null) {
            resp.sendRedirect("Adminlogin.jsp");
            return;
        }

        String idParam = req.getParameter("bookingId");
        if (idParam == null) {
            resp.sendRedirect("AdminManageBookings");
            return;
        }

        int bookingId = Integer.parseInt(idParam);

        Booking booking = new BookingDAOImpl().getBookingById(bookingId);
        if (booking == null) {
            resp.sendRedirect("AdminManageBookings");
            return;
        }

        req.setAttribute("booking", booking);
        req.getRequestDispatcher("adminEditBooking.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("adminObj") == null) {
            resp.sendRedirect("Adminlogin.jsp");
            return;
        }

        int bookingId = Integer.parseInt(req.getParameter("bookingId"));
        String status = req.getParameter("status");
        int numPeople = Integer.parseInt(req.getParameter("numPeople"));

        new BookingDAOImpl().updateBooking(bookingId, status, numPeople);

        resp.sendRedirect("AdminManageBookings");
    }
}
