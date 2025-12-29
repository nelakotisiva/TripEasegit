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

@WebServlet("/DeleteBooking")   // ok to keep; web.xml will also map it
public class DeleteBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("adminObj") == null) {
            resp.sendRedirect("Adminlogin.jsp");
            return;
        }

        String idParam = req.getParameter("bookingId");
        int bookingId;

        try {
            bookingId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            resp.sendRedirect("AdminManageBookings?msg=Invalid+booking+id");
            return;
        }

        BookingDAO dao = new BookingDAOImpl();
        boolean result = dao.deleteBooking(bookingId);

        if (result) {
            resp.sendRedirect("AdminManageBookings?msg=Booking+Deleted+Successfully");
        } else {
            resp.sendRedirect("AdminManageBookings?msg=Delete+Failed");
        }
    }
}
