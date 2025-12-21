package controllerpackage.com;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import UserDaopackage.com.FlightBookingDAO;
import UserDaopackage.com.FlightBookingDAOImpl;
import dtopackage.com.Flight;
import dtopackage.com.User;
import dtopackage.com.UserBooking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MyFlightBookings")
public class MyFlightBookingsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private FlightBookingDAO bookingDAO;

    @Override
    public void init() {
        bookingDAO = new FlightBookingDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔒 Session check
        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        // 👤 Logged-in user
        User user = (User) session.getAttribute("userObj");
        int userId = user.getUser_id();

        // ✅ Fetch flight bookings
        List<Flight> flightBookings =
                bookingDAO.getMyFlightBookings(userId);

        // ✅ Convert to common booking format
        List<UserBooking> allBookings = new ArrayList<>();

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

        // 📦 Send to JSP
        req.setAttribute("flightBookings", flightBookings);
        req.setAttribute("allBookings", allBookings);

        req.getRequestDispatcher("MyFlightBookings.jsp")
           .forward(req, resp);
    }
}
