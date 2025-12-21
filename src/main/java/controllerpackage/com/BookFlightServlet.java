package controllerpackage.com;

import java.io.IOException;
import java.sql.Date;

import UserDaopackage.com.FlightBookingDAO;
import UserDaopackage.com.FlightBookingDAOImpl;
import dtopackage.com.Flight;
import dtopackage.com.User;
import utilpackage.com.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookFlight")
public class BookFlightServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private FlightBookingDAO bookingDAO = new FlightBookingDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userObj");

        int flightId = Integer.parseInt(req.getParameter("flightId"));
        int seats = Integer.parseInt(req.getParameter("seats"));
        Date travelDate = Date.valueOf(req.getParameter("date"));

        // ✅ FETCH FLIGHT DETAILS FROM DB
        Flight flight = bookingDAO.getFlightById(flightId);

        boolean success = bookingDAO.bookFlight(
                user.getUser_id(),
                flightId,
                seats,
                travelDate
        );

        if (success && flight != null) {

            double totalPrice = flight.getPrice() * seats;

            String subject = "Flight Booking Confirmation - TripEase";

            String message =
                "Hello " + user.getFull_name() + ",\n\n" +
                "🎉 Your flight booking is CONFIRMED!\n\n" +
                "Airline: " + flight.getAirline() + "\n" +
                "Route: " + flight.getSource() + " - " + flight.getDestination() + "\n" +
                "Travel Date: " + travelDate + "\n" +
                "Seats Booked: " + seats + "\n" +
                "Total Price: ₹" + totalPrice + "\n\n" +
                "Thank you for booking with TripEase.\n" +
                "Have a safe and pleasant journey!\n\n" +
                "Regards,\nTripEase Team";

            EmailUtil.sendEmail(user.getEmail(), subject, message);

            session.setAttribute("msg", "Flight booked successfully! Confirmation email sent.");

        } else {
            session.setAttribute("msg", "Booking failed. Seats not available.");
        }

        resp.sendRedirect("SearchFlight");
    }
}
