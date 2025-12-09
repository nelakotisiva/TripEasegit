package controllerpackage.com;

import java.io.IOException;
import java.sql.Date;

import UserDaopackage.com.FlightBookingDAOImpl;
import dtopackage.com.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/BookFlight")
public class BookFlightServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // --- Read parameters ---
            String flightIdStr = req.getParameter("flightId");
            String seatsStr = req.getParameter("seats");
            String travelDateStr = req.getParameter("date");

            System.out.println("DEBUG Booking Params: flightId=" + flightIdStr + 
                               ", seats=" + seatsStr + ", date=" + travelDateStr);

            if (flightIdStr == null || seatsStr == null || travelDateStr == null) {
                req.getSession().setAttribute("msg", "Invalid booking details.");
                resp.sendRedirect("SearchFlight");
                return;
            }

            int flightId = Integer.parseInt(flightIdStr);
            int seats = Integer.parseInt(seatsStr);

            // Convert String → SQL Date
            Date travelDate = Date.valueOf(travelDateStr);

            // --- Check login ---
            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("userObj");

            if (user == null) {
                session.setAttribute("msg", "Please login to book flights.");
                resp.sendRedirect("Login.jsp");
                return;
            }

            int userId = user.getUser_id();

            // --- Perform booking ---
            boolean success = new FlightBookingDAOImpl()
                    .bookFlight(userId, flightId, seats, travelDate);

            if (success) {
                session.setAttribute("msg", "Flight booked successfully!");
                resp.sendRedirect("SearchFlight?msg=success");
            } else {
                session.setAttribute("msg", "Booking failed. Not enough seats.");
                resp.sendRedirect("SearchFlight");
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("msg", "Booking failed due to an error.");
            resp.sendRedirect("SearchFlight");
        }
    }
}
