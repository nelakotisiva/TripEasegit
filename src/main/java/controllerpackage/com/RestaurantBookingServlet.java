package controllerpackage.com;

import java.io.IOException;

import Daopackage.com.RestaurantBookingDAO;
import Daopackage.com.RestaurantBookingDAOImpl;
import Daopackage.com.RestaurantDAO;
import Daopackage.com.RestaurantDAOImpl;
import dtopackage.com.RestaurantBooking;
import dtopackage.com.User;
import utilpackage.com.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/bookRestaurant")
public class RestaurantBookingServlet extends HttpServlet {

    private RestaurantBookingDAO bookingDAO;
    private RestaurantDAO restaurantDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new RestaurantBookingDAOImpl();
        restaurantDAO = new RestaurantDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userObj");

        int restaurantId;
        int people;

        try {
            restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
            people = Integer.parseInt(req.getParameter("people"));
        } catch (Exception e) {
            session.setAttribute("msg", "❌ Invalid booking details!");
            resp.sendRedirect("nearbyRestaurants");
            return;
        }

        String bookingDateTimeStr = req.getParameter("bookingDateTime");

        java.sql.Timestamp bookingTimestamp =
                java.sql.Timestamp.valueOf(
                        bookingDateTimeStr.replace("T", " ") + ":00"
                );

        RestaurantBooking rb = new RestaurantBooking();
        rb.setUserId(user.getUser_id());
        rb.setRestaurantId(restaurantId);
        rb.setNumPeople(people);
        rb.setBookingDate1(bookingTimestamp);
        rb.setStatus("Booked");

        boolean success = bookingDAO.bookRestaurantAndMainBooking(rb);

        String userEmail = user.getEmail();
        String userName  = user.getFull_name();

        // 🔹 FETCH RESTAURANT NAME + LOCATION
        String[] details = restaurantDAO.getRestaurantNameAndLocationById(restaurantId);
        String restaurantName = details[0];
        String restaurantLocation = details[1];

        if (success) {

            String subject = "🍽 Restaurant Booking Confirmed | TripEase";
            String body =
                    "Hello " + userName + ",\n\n" +
                    "Your restaurant booking has been CONFIRMED ✅\n\n" +
                    "🍽 Restaurant : " + restaurantName + "\n" +
                    "📍 Location   : " + restaurantLocation + "\n" +
                    "👥 People     : " + people + "\n" +
                    "🕒 Date & Time: " + bookingTimestamp + "\n\n" +
                    "Thank you for choosing TripEase!\n\n" +
                    "— TripEase Team";

            EmailUtil.sendEmail(userEmail, subject, body);
            session.setAttribute("msg", "🎉 Restaurant booked successfully! Email sent 📧");

        } else {

            String subject = "❌ Restaurant Booking Failed | TripEase";
            String body =
                    "Hello " + userName + ",\n\n" +
                    "Unfortunately, your restaurant booking could NOT be completed.\n\n" +
                    "Please try again later.\n\n" +
                    "— TripEase Team";

            EmailUtil.sendEmail(userEmail, subject, body);
            session.setAttribute("msg", "❌ Booking failed! Email notification sent 📧");
        }

        resp.sendRedirect("nearbyRestaurants");
    }
}
