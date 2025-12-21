package controllerpackage.com;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import Daopackage.com.CabDAO;
import Daopackage.com.RestaurantBookingDAO;
import Daopackage.com.RestaurantBookingDAOImpl;
import Daopackage.com.RestaurantDAOImpl;
import Daopackage.com.DestinationDAOImpl;

import UserDaopackage.com.FlightBookingDAOImpl;
import UserDaopackage.com.HotelBookingDAOImpl;

import dtopackage.com.Bookingg;
import dtopackage.com.Cab;
import dtopackage.com.Flight;
import dtopackage.com.Restaurant;
import dtopackage.com.RestaurantBooking;
import dtopackage.com.Destination;
import dtopackage.com.User;
import dtopackage.com.UserBooking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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

        /* ================= 🏨 HOTELS ================= */
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

        /* ================= 🚕 CABS ================= */
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

        /* ================= ✈ FLIGHTS ================= */
        List<Flight> flightBookings =
                new FlightBookingDAOImpl().getMyFlightBookings(userId);

        for (Flight f : flightBookings) {
            UserBooking ub = new UserBooking();
            ub.setBookingType("FLIGHT");
            ub.setTitle(f.getAirline());
            ub.setSubtitle(f.getSource() + " → " + f.getDestination());
            ub.setAmount(f.getPrice());
            ub.setStatus("CONFIRMED");
            ub.setDetailsUrl("FlightDetails?flightId=" + f.getFlightId());
            allBookings.add(ub);
        }

        /* ================= 🍽 RESTAURANTS ================= */
        RestaurantBookingDAO restaurantBookingDAO =
                new RestaurantBookingDAOImpl();
        RestaurantDAOImpl restaurantDAO =
                new RestaurantDAOImpl();
        DestinationDAOImpl destinationDAO =
                new DestinationDAOImpl();

        List<RestaurantBooking> restaurantBookings =
                restaurantBookingDAO.getBookingsByUserId(userId);

        List<Destination> destinations =
                destinationDAO.getAllDestinations();

        for (RestaurantBooking rb : restaurantBookings) {

            Restaurant restaurant =
                    restaurantDAO.getRestaurantById(rb.getRestaurantId());

            Destination destination = null;
            if (restaurant != null) {
                for (Destination d : destinations) {
                    if (d.getDestinationId() ==
                            restaurant.getDestinationId()) {
                        destination = d;
                        break;
                    }
                }
            }

            UserBooking ub = new UserBooking();
            ub.setBookingType("RESTAURANT");

            ub.setTitle(
                restaurant != null ? restaurant.getName() : "Restaurant"
            );

            ub.setSubtitle(
                destination != null
                    ? destination.getLocation()
                    : "Unknown location"
            );

            ub.setBookingDate(rb.getBookingDate1());

            ub.setAmount(
                restaurant != null ? restaurant.getAvgPrice() : 0
            );

            ub.setStatus(rb.getStatus());

            ub.setDetailsUrl(
                "RestaurantDetails?restaurantId=" +
                rb.getRestaurantId()
            );

            allBookings.add(ub);
        }

        /* ================= SEND TO JSP ================= */
        req.setAttribute("allBookings", allBookings);
        req.getRequestDispatcher("MyBooking.jsp")
           .forward(req, resp);
    }
}
