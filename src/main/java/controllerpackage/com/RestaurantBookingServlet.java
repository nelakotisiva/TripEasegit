package controllerpackage.com;

import java.io.IOException;
import java.sql.Date;

import Daopackage.com.ResBookingDAO;
import Daopackage.com.ResBookingDaoImpl;
import dtopackage.com.RestaurantBooking;
import dtopackage.com.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/bookRestaurant")
public class RestaurantBookingServlet extends HttpServlet {

    private ResBookingDAO bookingDAO = new ResBookingDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userObj");

        RestaurantBooking rb = new RestaurantBooking();
        rb.setUserId(user.getUser_id());
        rb.setRestaurantId(Integer.parseInt(req.getParameter("restaurantId")));
        rb.setNumPeople(Integer.parseInt(req.getParameter("people")));
        rb.setBookingDate(new Date(System.currentTimeMillis()));
        rb.setStatus("Booked");

        boolean ok = bookingDAO.bookRestaurant(rb);

        if (ok)
            session.setAttribute("msg", "🎉 Restaurant booked successfully!");
        else
            session.setAttribute("msg", "❌ Booking failed. Try again!");

        resp.sendRedirect("nearbyRestaurants");
    }
}
