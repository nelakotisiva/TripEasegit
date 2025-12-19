package controllerpackage.com;

import dtopackage.com.RestaurantBooking;
import dtopackage.com.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import Daopackage.com.RestaurantDAO;
import Daopackage.com.RestaurantDAOImpl;

@WebServlet("/myRestaurantsBookings")
public class UserRestauBooking extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userObj");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int userId = user.getUser_id();

        // ✅ USE THE DAO THAT ACTUALLY BUILDS restaurantName & location
        RestaurantDAO dao = new RestaurantDAOImpl();
        List<RestaurantBooking> bookings = dao.getBookingsByUserId(userId);

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("UserRestaurantBookings.jsp")
               .forward(request, response);
    }
}
