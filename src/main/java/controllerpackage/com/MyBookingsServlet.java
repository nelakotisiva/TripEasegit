package controllerpackage.com;

import java.io.IOException;
import java.util.*;

import Daopackage.com.CabDAO;
import Daopackage.com.RestaurantBookingDAO;
import Daopackage.com.RestaurantBookingDAOImpl;
import Daopackage.com.RestaurantDAOImpl;
import Daopackage.com.DestinationDAOImpl;

import UserDaopackage.com.FlightBookingDAOImpl;
import UserDaopackage.com.HotelBookingDAOImpl;

import dtopackage.com.*;

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

        List<UserBooking> allBookings = new ArrayList<>();

        /* 🏨 HOTELS */
        for (Bookingg h : new HotelBookingDAOImpl().getBookingsByUser(userId)) {
            UserBooking ub = new UserBooking();
            ub.setBookingId(h.getBookingId());
            ub.setServiceType("HOTEL");
            ub.setIcon("🏨");
            ub.setBookingType("Hotel Booking");
            ub.setTitle(h.getHotelName());
            ub.setSubtitle(h.getHotelLocation());
            ub.setBookingDate(h.getBookingDate());
            ub.setAmount(h.getTotalAmount());
            ub.setStatus(h.getStatus());
            allBookings.add(ub);
        }

        /* ✈ FLIGHTS */
        FlightBookingDAOImpl flightDAO = new FlightBookingDAOImpl();
        for (Flight f : flightDAO.getMyFlightBookings(userId)) {
            UserBooking ub = new UserBooking();
            ub.setBookingId(f.getBookingId());
            ub.setServiceType("FLIGHT");
            ub.setIcon("✈");
            ub.setBookingType("Flight Booking");
            ub.setTitle(f.getAirline());
            ub.setSubtitle(f.getSource()+" → "+f.getDestination());
            ub.setBookingDate(f.getBookingDate());
            ub.setAmount(f.getPrice());
            ub.setStatus(f.getStatus());
            allBookings.add(ub);
        }

        /* 🚕 CABS */
        CabDAO cabDAO = new CabDAO();
        for (Cab c : cabDAO.getMyBookings(userId)) {
            UserBooking ub = new UserBooking();
            ub.setBookingId(c.getBookingId());
            ub.setServiceType("CAB");
            ub.setIcon("🚕");
            ub.setBookingType("Cab Booking");
            ub.setTitle(c.getModel());
            ub.setSubtitle(c.getLocation());
            ub.setBookingDate(new Date());
            ub.setAmount(c.getPricePerDay());
            ub.setStatus(c.getStatus());
            allBookings.add(ub);
        }

        /* 🍽 RESTAURANTS */
        RestaurantBookingDAOImpl rDAO = new RestaurantBookingDAOImpl();
        RestaurantDAOImpl restDAO = new RestaurantDAOImpl();
        DestinationDAOImpl destDAO = new DestinationDAOImpl();

        for (RestaurantBooking rb : rDAO.getBookingsByUserId(userId)) {
            Restaurant r = restDAO.getRestaurantById(rb.getRestaurantId());
            Destination d = destDAO.getDestinationById(r.getDestinationId());

            UserBooking ub = new UserBooking();
            ub.setBookingId(rb.getBookingId());
            ub.setServiceType("RESTAURANT");
            ub.setIcon("🍽");
            ub.setBookingType("Restaurant Booking");
            ub.setTitle(r.getName());
            ub.setSubtitle(d.getLocation());
            ub.setBookingDate(rb.getBookingDate1());
            ub.setAmount(r.getAvgPrice());
            ub.setStatus(rb.getStatus());
            allBookings.add(ub);
        }

        allBookings.sort((a,b) ->
            b.getBookingDate().compareTo(a.getBookingDate()));

        req.setAttribute("allBookings", allBookings);
        req.getRequestDispatcher("MyBooking.jsp").forward(req, resp);
    }
}
