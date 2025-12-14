package controllerpackage.com;

import java.io.IOException;
import java.util.List;

import Daopackage.com.BookingDAOImpl;
import UserDaopackage.com.HotelBookingDAOImpl;
import Daopackage.com.CabDAO;


import dtopackage.com.Booking;
import dtopackage.com.Bookingg;
import dtopackage.com.Cab;

import dtopackage.com.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/MyBookingsServlet")
public class MyBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userObj");
        int userId = user.getUser_id();

        // 🏨 Hotels
        List<Bookingg> hotelBookings =
                new HotelBookingDAOImpl().getBookingsByUser(userId);

        // 🍽 Restaurants + 🗺 Places + 🚕 (from booking table)
        List<Booking> commonBookings =
                new BookingDAOImpl().getBookingsByUserId(userId);

        // 🚕 Cabs (detailed)
        List<Cab> cabBookings =
                new CabDAO().getMyBookings(userId);

        
        req.setAttribute("hotelBookings", hotelBookings);
        req.setAttribute("commonBookings", commonBookings);
        req.setAttribute("cabBookings", cabBookings);
       

        req.getRequestDispatcher("MyBooking.jsp").forward(req, resp);
    }
}
