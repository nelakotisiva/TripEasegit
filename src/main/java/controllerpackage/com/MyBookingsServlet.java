package controllerpackage.com;

import UserDaopackage.com.FlightBookingDAOImpl;
import dtopackage.com.Flight;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import Daopackage.com.BookingDAOImpl;
import Daopackage.com.CabDAO;
import UserDaopackage.com.HotelBookingDAOImpl;

import dtopackage.com.Booking;
import dtopackage.com.Bookingg;
import dtopackage.com.Cab;
import dtopackage.com.User;
import dtopackage.com.UserBooking;

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

        // ✅ ONE UNIFIED LIST
        List<UserBooking> allBookings = new ArrayList<>();

        /* ---------------- 🏨 HOTELS ---------------- */
        List<Bookingg> hotelBookings =
                new HotelBookingDAOImpl().getBookingsByUser(userId);

        for (Bookingg h : hotelBookings) {
            UserBooking ub = new UserBooking();
            ub.setBookingType("HOTEL");
            ub.setTitle(h.getHotelName());
            ub.setSubtitle(h.getHotelLocation());
            ub.setBookingDate(h.getBookingDate());

            ub.setAmount(h.getTotalAmount());
            ub.setStatus("CONFIRMED");
            ub.setDetailsUrl("HotelDetails?id=" + h.getHotelId());
            allBookings.add(ub);
        }

        /* ---------------- 🚕 CABS ---------------- */
        List<Cab> cabBookings =
                new CabDAO().getMyBookings(userId);

        for (Cab c : cabBookings) {
            UserBooking ub = new UserBooking();
            ub.setBookingType("CAB");
            ub.setTitle(c.getModel());
            ub.setSubtitle(c.getLocation());
            ub.setAmount(c.getPricePerDay());
            ub.setStatus("CONFIRMED");
            ub.setDetailsUrl("CabDetails?rentalId=" + c.getRentalId());
            allBookings.add(ub);
        }

        
        /* ---------------- ✈ FLIGHTS ---------------- */
        List<Flight> flightBookings =
                new FlightBookingDAOImpl().getMyFlightBookings(userId);

        for (Flight f : flightBookings) {
            UserBooking ub = new UserBooking();
            ub.setBookingType("FLIGHT");
            ub.setTitle(f.getAirline());
            ub.setSubtitle(f.getSource() + " → " + f.getDestination());
            ub.setAmount(f.getPrice());
            ub.setDetailsUrl("FlightDetails?flightId=" + f.getFlightId());

            allBookings.add(ub);
        }

        
        
        
        /* -------- 🍽 RESTAURANTS / 🗺 PLACES / 🎒 TOURS -------- */
        List<Booking> commonBookings =
                new BookingDAOImpl().getBookingsByUserId(userId);

        for (Booking b : commonBookings) {
            UserBooking ub = new UserBooking();
            ub.setBookingType("SERVICE"); // ✅ FIXED (NO getServiceType())
            ub.setTitle("Destination ID: " + b.getDestinationId());
            ub.setBookingDate(b.getBookingDate());
            ub.setTravelDate(b.getTravelDate());
            ub.setAmount(0);
            ub.setStatus(b.getStatus());
            ub.setDetailsUrl("ServiceDetails?bookingId=" + b.getBookingId());
            allBookings.add(ub);
        }

        // ✅ SEND TO JSP
        req.setAttribute("allBookings", allBookings);
        req.getRequestDispatcher("MyBooking.jsp").forward(req, resp);
    }
}
