package controllerpackage.com;

import java.io.IOException;
import java.sql.Date;

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

        // --------------------------------------------------
        // SESSION CHECK
        // --------------------------------------------------
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userObj");

        // --------------------------------------------------
        // READ FORM DATA
        // --------------------------------------------------
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

        // --------------------------------------------------
        // CREATE BOOKING DTO
        // --------------------------------------------------
        RestaurantBooking rb = new RestaurantBooking();
        rb.setUserId(user.getUser_id());
        rb.setRestaurantId(restaurantId);
        rb.setNumPeople(people);
        rb.setBookingDate(new Date(System.currentTimeMillis()));
        rb.setStatus("Booked");

        // --------------------------------------------------
        // SAVE BOOKING (restaurant_booking + booking)
        // --------------------------------------------------
        boolean success = bookingDAO.bookRestaurantAndMainBooking(rb);

        // --------------------------------------------------
        // RESPONSE
        // --------------------------------------------------
        if (success) {
            session.setAttribute("msg", "🎉 Restaurant booked successfully!");
        } else {
            session.setAttribute("msg", "❌ Booking failed. Please try again!");
        }

        resp.sendRedirect("nearbyRestaurants");
    }
}
