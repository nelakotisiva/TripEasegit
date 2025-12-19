package controllerpackage.com;

import java.io.IOException;
import java.util.List;

import Daopackage.com.RestaurantBookingDAO;
import Daopackage.com.RestaurantBookingDAOImpl;
import Daopackage.com.RestaurantDAO;
import Daopackage.com.RestaurantDAOImpl;
import dtopackage.com.RestaurantBooking;
import dtopackage.com.User;
import utilpackage.com.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/bookRestaurant")
public class RestaurantBookingServlet extends HttpServlet {

    private RestaurantBookingDAO bookingDAO;

    @Override
    public void init() {
        bookingDAO = new RestaurantBookingDAOImpl();
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

        /* ---------- DATE ONLY ---------- */
        String bookingDateTimeStr = req.getParameter("bookingDateTime");
        java.sql.Date bookingDate =
                java.sql.Date.valueOf(bookingDateTimeStr.substring(0, 10));

        java.sql.Timestamp bookingTimestamp =
                new java.sql.Timestamp(bookingDate.getTime());

        RestaurantBooking rb = new RestaurantBooking();
        rb.setUserId(user.getUser_id());
        rb.setRestaurantId(restaurantId);
        rb.setNumPeople(people);
        rb.setBookingDate1(bookingTimestamp);
        rb.setStatus("Booked");

        boolean success = bookingDAO.bookRestaurantAndMainBooking(rb);

        String restaurantName = "Restaurant";
        String location = "Unknown location";

        if (success) {
            RestaurantDAO dao = new RestaurantDAOImpl();
            List<RestaurantBooking> bookings =
                    dao.getBookingsByUserId(user.getUser_id());

            if (!bookings.isEmpty()) {
                restaurantName = bookings.get(0).getRestaurantName();
                location = bookings.get(0).getLocation();
            }
        }

        if (success) {
            String body =
                    "Hello " + user.getFull_name() + ",\n\n" +
                    "Your restaurant booking has been CONFIRMED ✅\n\n" +
                    "🍽 Restaurant : " + restaurantName + "\n" +
                    "📍 Location   : " + location + "\n" +
                    "👥 People     : " + people + "\n" +
                    "📅 Date       : " + bookingDate + "\n\n" +
                    "— TripEase Team";

            EmailUtil.sendEmail(
                    user.getEmail(),
                    "🍽 Restaurant Booking Confirmed | TripEase",
                    body
            );

            session.setAttribute("msg",
                    "🎉 Restaurant booked successfully! Email sent 📧");
        } else {
            session.setAttribute("msg", "❌ Booking failed!");
        }

        resp.sendRedirect("nearbyRestaurants");
    }
}
