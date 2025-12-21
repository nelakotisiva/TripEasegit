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

        /* ================= 🏨 HOTELS ================= */
        HotelBookingDAOImpl hotelDAO = new HotelBookingDAOImpl();
        for (Bookingg h : hotelDAO.getBookingsByUser(userId)) {

            UserBooking ub = new UserBooking();
            ub.setBookingId(h.getBookingId());
            ub.setIcon("🏨");
            ub.setBookingType("HOTEL");
            ub.setTitle(h.getHotelName());
            ub.setSubtitle(h.getHotelLocation());
            ub.setBookingDate(h.getBookingDate());
            ub.setAmount(h.getTotalAmount());
            ub.setStatus(h.getStatus());

            allBookings.add(ub);
        }

        /* ================= 🚕 CABS ================= */
        CabDAO cabDAO = new CabDAO();
        for (Cab c : cabDAO.getMyBookings(userId)) {

            UserBooking ub = new UserBooking();
            ub.setBookingId(c.getBookingId());
            ub.setIcon("🚕");
            ub.setBookingType("CAB");
            ub.setTitle(c.getModel());
            ub.setSubtitle(c.getLocation());
            ub.setBookingDate(new Date()); // fallback (no date column)
            ub.setAmount(c.getPricePerDay());
            ub.setStatus(c.getStatus());

            allBookings.add(ub);
        }

        /* ================= ✈ FLIGHTS ================= */
        FlightBookingDAOImpl flightDAO = new FlightBookingDAOImpl();
        for (Flight f : flightDAO.getMyFlightBookings(userId)) {

            UserBooking ub = new UserBooking();
            ub.setBookingId(f.getBookingId());
            ub.setIcon("✈");
            ub.setBookingType("FLIGHT");
            ub.setTitle(f.getAirline());
            ub.setSubtitle(f.getSource() + " → " + f.getDestination());
            ub.setBookingDate(new Date()); // fallback
            ub.setAmount(f.getPrice());
            ub.setStatus(f.getStatus());
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

        List<Destination> destinations =
                destinationDAO.getAllDestinations();

        for (RestaurantBooking rb :
                restaurantBookingDAO.getBookingsByUserId(userId)) {

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
            ub.setBookingId(rb.getBookingId());
            ub.setIcon("🍽");
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

        /* ================= SORT BY DATE (LATEST FIRST) ================= */
        Collections.sort(allBookings, (a, b) -> {
            if (a.getBookingDate() == null && b.getBookingDate() == null) return 0;
            if (a.getBookingDate() == null) return 1;
            if (b.getBookingDate() == null) return -1;
            return b.getBookingDate().compareTo(a.getBookingDate());
        });

        /* ================= SEND TO JSP ================= */
        req.setAttribute("allBookings", allBookings);
        req.getRequestDispatcher("MyBooking.jsp")
           .forward(req, resp);
    }
}
