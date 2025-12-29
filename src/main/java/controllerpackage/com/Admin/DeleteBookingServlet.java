package controllerpackage.com.Admin;

import java.io.IOException;

import Daopackage.com.BookingDAOImpl;
import Daopackage.com.CabDAO;
import Daopackage.com.RestaurantBookingDAOImpl;
import UserDaopackage.com.FlightBookingDAOImpl;
import UserDaopackage.com.HotelBookingDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import utilpackage.com.EmailUtil;

@WebServlet("/AdminDeleteBooking")
public class DeleteBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 🔐 Admin session check
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("adminObj") == null) {
            resp.sendRedirect("Adminlogin.jsp");
            return;
        }

        int bookingId = Integer.parseInt(req.getParameter("bookingId"));
        String serviceType = req.getParameter("service");

        if (serviceType == null) {
            resp.sendRedirect("AdminManageBookings");
            return;
        }

        // 🔹 DAO
        BookingDAOImpl bookingDAO = new BookingDAOImpl();

        // 🔹 Fetch user email BEFORE cancelling
        String userEmail = bookingDAO.getUserEmailByBookingId(bookingId);

        // 🔹 Cancel based on service type
        switch (serviceType.toUpperCase()) {

            case "HOTEL":
                new HotelBookingDAOImpl().cancelBooking(bookingId);
                break;

            case "FLIGHT":
                new FlightBookingDAOImpl().cancelBooking(bookingId);
                break;

            case "CAB":
                new CabDAO().cancelCabBooking(bookingId);
                break;

            case "RESTAURANT":
                new RestaurantBookingDAOImpl().cancelBooking(bookingId);
                break;

            default:
                System.out.println("❌ Unknown service type: " + serviceType);
        }

        // 🔹 Update main booking table
        bookingDAO.updateBooking(bookingId, "Cancelled", 0);

        // 🔹 Send cancellation email
        if (userEmail != null && !userEmail.isEmpty()) {

            EmailUtil.sendEmail(
                userEmail,
                "TripEase Booking Cancelled",
                "Dear Customer,\n\n" +
                "Your booking has been CANCELLED successfully.\n\n" +
                "Booking ID : " + bookingId + "\n" +
                "Service    : " + serviceType + "\n\n" +
                "Regards,\n" +
                "TripEase Team"
            );
        }

        // 🔁 Back to admin page
        resp.sendRedirect("AdminManageBookings");
    }
}
