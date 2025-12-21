package controllerpackage.com;

import java.io.IOException;

import Daopackage.com.CabDAO;
import Daopackage.com.RestaurantBookingDAOImpl;
import UserDaopackage.com.FlightBookingDAOImpl;
import UserDaopackage.com.HotelBookingDAOImpl;
import dtopackage.com.User;
import utilpackage.com.EmailUtil;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userObj");

        try {
            int bookingId = Integer.parseInt(req.getParameter("bookingId"));
            String type = req.getParameter("type").toUpperCase();

            /* ================= CANCEL LOGIC ================= */
            switch (type) {

                case "HOTEL":
                    new HotelBookingDAOImpl().cancelBooking(bookingId);
                    break;

                case "CAB":
                    new CabDAO().cancelCabBooking(bookingId);
                    break;

                case "FLIGHT":
                    new FlightBookingDAOImpl().cancelBooking(bookingId);
                    break;

                case "RESTAURANT":
                    new RestaurantBookingDAOImpl().cancelBooking(bookingId);
                    break;

                default:
                    session.setAttribute("cancelMsg", "❌ Invalid booking type!");
                    resp.sendRedirect("MyBookingsServlet");
                    return;
            }

            /* ================= EMAIL NOTIFICATION ================= */
            String subject = "❌ " + type + " Booking Cancelled | TripEase";

            String emailBody =
                    "Hello " + user.getFull_name() + ",\n\n" +
                    "Your booking has been successfully CANCELLED ❌\n\n" +
                    "📌 Booking Type : " + type + "\n" +
                    "🆔 Booking ID   : " + bookingId + "\n" +
                    "📅 Status       : Cancelled\n\n" +
                    "We’re sorry to see you cancel. We hope to serve you again soon!\n\n" +
                    "— TripEase Team";

            EmailUtil.sendEmail(
                    user.getEmail(),
                    subject,
                    emailBody
            );

            /* ================= UI POPUP MESSAGE ================= */
            session.setAttribute(
                    "cancelMsg",
                    "✅ " + type + " booking cancelled successfully! Email sent 📧"
            );

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute(
                    "cancelMsg",
                    "❌ Cancellation failed. Please try again."
            );
        }

        resp.sendRedirect("MyBookingsServlet");
    }
}
