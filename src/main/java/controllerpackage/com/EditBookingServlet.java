package controllerpackage.com;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import Daopackage.com.BookingDAO;
import Daopackage.com.BookingDAOImpl;
import dtopackage.com.Booking;

@WebServlet("/EditBooking")
public class EditBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("adminObj") == null) {
            resp.sendRedirect("Adminlogin.jsp");
            return;
        }

        int bookingId = Integer.parseInt(req.getParameter("bookingId"));

        BookingDAO dao = new BookingDAOImpl();
        Booking booking = dao.getBookingById(bookingId);

        req.setAttribute("booking", booking);
        req.getRequestDispatcher("EditBooking.jsp").forward(req, resp);
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

        BookingDAO dao = new BookingDAOImpl();

        boolean updated = dao.updateBooking(bookingId, status, numPeople);

        if (updated) {
            resp.sendRedirect("ManageBookings?msg=Booking Updated Successfully");
        } else {
            resp.sendRedirect("ManageBookings?msg=Update Failed");
        }
    }
}
