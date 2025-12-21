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
        for (Bookingg h : new HotelBookingDAOImpl().getBookingsByUser(userId)) {

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
        for (Cab c : new CabDAO().getMyBookings(userId)) {

            UserBooking ub = new UserBooking();
            ub.setBookingId(c.getBookingId());      // ✅ NOT 0
            ub.setIcon("🚕");
            ub.setBookingType("CAB");
            ub.setTitle(c.getModel());
            ub.setSubtitle(c.getLocation());
            ub.setBookingDate(new Date());
            ub.setAmount(c.getPricePerDay());
            ub.setStatus(c.getStatus());            // ✅ shows Cancelled
            allBookings.add(ub);
        }


        /* ================= ✈ FLIGHTS ================= */
        for (Flight f : new FlightBookingDAOImpl().getMyFlightBookings(userId)) {

            UserBooking ub = new UserBooking();
            ub.setBookingId(f.getBookingId());              // ✅ FIXED
            ub.setIcon("✈");
            ub.setBookingType("FLIGHT");
            ub.setTitle(f.getAirline());
            ub.setSubtitle(f.getSource() + " → " + f.getDestination());
            ub.setBookingDate(new Date());
            ub.setAmount(f.getPrice());
            ub.setStatus(f.getStatus());                    // ✅ FIX
            ub.setDetailsUrl("FlightDetails?flightId=" + f.getFlightId());

            allBookings.add(ub);
        }

        /* ================= 🍽 RESTAURANTS ================= */
        RestaurantBookingDAO rbDAO = new RestaurantBookingDAOImpl();
        RestaurantDAOImpl rDAO = new RestaurantDAOImpl();
        DestinationDAOImpl dDAO = new DestinationDAOImpl();

        for (RestaurantBooking rb : rbDAO.getBookingsByUserId(userId)) {

            Restaurant r = rDAO.getRestaurantById(rb.getRestaurantId());

            Destination d = null;
            if (r != null) {
                for (Destination x : dDAO.getAllDestinations()) {
                    if (x.getDestinationId() == r.getDestinationId()) {
                        d = x;
                        break;
                    }
                }
            }

            UserBooking ub = new UserBooking();
            ub.setBookingId(rb.getBookingId());
            ub.setIcon("🍽");
            ub.setBookingType("RESTAURANT");
            ub.setTitle(r != null ? r.getName() : "Restaurant");
            ub.setSubtitle(d != null ? d.getLocation() : "Unknown");
            ub.setBookingDate(rb.getBookingDate1());
            ub.setAmount(r != null ? r.getAvgPrice() : 0);
            ub.setStatus(rb.getStatus());                   // already correct
            ub.setDetailsUrl("RestaurantDetails?restaurantId=" + rb.getRestaurantId());

            allBookings.add(ub);
        }

        /* ================= SORT BY DATE ================= */
        Collections.sort(allBookings, (a, b) -> {
            if (a.getBookingDate() == null && b.getBookingDate() == null) return 0;
            if (a.getBookingDate() == null) return 1;
            if (b.getBookingDate() == null) return -1;
            return b.getBookingDate().compareTo(a.getBookingDate());
        });

        req.setAttribute("allBookings", allBookings);
        req.getRequestDispatcher("MyBooking.jsp").forward(req, resp);
    }
}
