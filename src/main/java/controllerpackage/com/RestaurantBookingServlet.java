package controllerpackage.com;

import java.io.IOException;
import java.sql.Date;

import Daopackage.com.ResBookingDAO;
import Daopackage.com.ResBookingDaoImpl;
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

    private ResBookingDAO bookingDAO = new ResBookingDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userObj");
        int userId = user.getUser_id();

        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
        int people = Integer.parseInt(req.getParameter("people"));

        RestaurantBooking rb = new RestaurantBooking();
        rb.setUserId(userId);
        rb.setRestaurantId(restaurantId);
        rb.setBookingDate(new Date(System.currentTimeMillis()));
        rb.setNumPeople(people);
        rb.setStatus("Booked");

        boolean ok = bookingDAO.bookRestaurant(rb);

        if (ok) {
            session.setAttribute("msg", "🎉 Restaurant Booked Successfully!");
        } else {
            session.setAttribute("msg", "❌ Booking Failed! Try Again.");
        }

        resp.sendRedirect("nearbyRestaurants");
    }
}
