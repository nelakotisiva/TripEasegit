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
import utilpackage.com.EmailUtil;

@WebServlet("/EditBooking")
public class EditBookingServlet extends HttpServlet {

    // ================= LOAD EDIT PAGE =================
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

    // ================= SAVE + SEND EMAIL =================
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

        BookingDAOImpl dao = new BookingDAOImpl();
        boolean updated = dao.updateBooking(bookingId, status, numPeople);

        // 🔹 SEND EMAIL AFTER UPDATE
        if (updated) {

            String userEmail = dao.getUserEmailByBookingId(bookingId);

            if (userEmail != null && !userEmail.isEmpty()) {
                EmailUtil.sendEmail(
                    userEmail,
                    "TripEase Booking Status Updated",
                    "Dear Customer,\n\n" +
                    "Your booking status has been updated.\n\n" +
                    "Booking ID : " + bookingId + "\n" +
                    "New Status : " + status + "\n" +
                    "People     : " + numPeople + "\n\n" +
                    "Regards,\n" +
                    "TripEase Team"
                );
            }

            resp.sendRedirect("AdminManageBookings?msg=Booking Updated Successfully");

        } else {
            resp.sendRedirect("AdminManageBookings?msg=Update Failed");
        }
    }
}
