package controllerpackage.com;

import java.io.IOException;
import java.sql.Date;

import UserDaopackage.com.FlightBookingDAO;
import UserDaopackage.com.FlightBookingDAOImpl;
import dtopackage.com.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookFlight")
public class BookFlightServlet extends HttpServlet {

    private FlightBookingDAO bookingDAO;

    @Override
    public void init() {
        bookingDAO = new FlightBookingDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // -------------------------------
        // LOGIN CHECK
        // -------------------------------
        User user = (session != null) ? (User) session.getAttribute("userObj") : null;
        if (user == null) {
            req.getSession().setAttribute("msg", "Please login to book flights.");
            resp.sendRedirect("Login.jsp");
            return;
        }

        // -------------------------------
        // READ PARAMETERS
        // -------------------------------
        int flightId;
        int seats;
        Date travelDate;

        try {
            flightId = Integer.parseInt(req.getParameter("flightId"));
            seats = Integer.parseInt(req.getParameter("seats"));
            travelDate = Date.valueOf(req.getParameter("date"));
        } catch (Exception e) {
            session.setAttribute("msg", "Invalid booking details!");
            resp.sendRedirect("SearchFlight");
            return;
        }

        // -------------------------------
        // BOOK FLIGHT
        // -------------------------------
        boolean success = bookingDAO.bookFlight(
                user.getUser_id(),
                flightId,
                seats,
                travelDate
        );

        // -------------------------------
        // RESPONSE
        // -------------------------------
        if (success) {
            session.setAttribute("msg", "✈ Flight booked successfully!");
            resp.sendRedirect("SearchFlight?msg=success");
        } else {
            session.setAttribute("msg", "❌ Booking failed. Not enough seats.");
            resp.sendRedirect("SearchFlight");
        }
    }
}
