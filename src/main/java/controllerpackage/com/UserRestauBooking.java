package controllerpackage.com;

import dtopackage.com.RestaurantBooking;
import dtopackage.com.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

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
        if (session == null || session.getAttribute("userObj") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userObj");

        RestaurantDAO dao = new RestaurantDAOImpl();
        List<RestaurantBooking> bookings =
                dao.getBookingsByUserId(user.getUser_id());

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("UserRestaurantBookings.jsp")
               .forward(request, response);
    }
}
