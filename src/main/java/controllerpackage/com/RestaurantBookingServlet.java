package controllerpackage.com;

import java.io.IOException;

import Daopackage.com.RestaurantBookingDAO;
import Daopackage.com.RestaurantBookingDAOImpl;
import dtopackage.com.RestaurantBooking;
import dtopackage.com.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/bookRestaurant")
public class RestaurantBookingServlet extends HttpServlet {

    private RestaurantBookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
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

     // READ datetime from JSP
        String bookingDateTimeStr = req.getParameter("bookingDateTime");

        // IMPORTANT: treat as LOCAL time (no timezone conversion)
        java.sql.Timestamp bookingTimestamp =
                java.sql.Timestamp.valueOf(
                        bookingDateTimeStr.replace("T", " ") + ":00"
                );

        RestaurantBooking rb = new RestaurantBooking();
        rb.setUserId(user.getUser_id());
        rb.setRestaurantId(restaurantId);
        rb.setNumPeople(people);
        rb.setBookingDate1(bookingTimestamp); // ✅ USE bookingDate1
        rb.setStatus("Booked");


        boolean success = bookingDAO.bookRestaurantAndMainBooking(rb);

        if (success) {
            session.setAttribute("msg", "🎉 Restaurant booked successfully!");
        } else {
            session.setAttribute("msg", "❌ Booking failed. Please try again!");
        }

        resp.sendRedirect("nearbyRestaurants");
    }
}
