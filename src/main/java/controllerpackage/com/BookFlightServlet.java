package controllerpackage.com;

import java.io.IOException;
import UserDaopackage.com.FlightBookingDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/BookFlight")
public class BookFlightServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String flightIdStr = req.getParameter("flightId");
            String seatsStr = req.getParameter("seats");

            int flightId = Integer.parseInt(flightIdStr);
            int seats = Integer.parseInt(seatsStr);

            HttpSession session = req.getSession();
            dtopackage.com.User user = (dtopackage.com.User) session.getAttribute("userObj");

            if (user == null) {
                session.setAttribute("msg", "Please login to book a flight.");
                resp.sendRedirect(req.getContextPath() + "/SearchFlight");
                return;
            }

            int userId = user.getUser_id();

            System.out.println("DEBUG: Booking attempt userId=" + userId + " flightId=" + flightId + " seats=" + seats);

            boolean success = new FlightBookingDAOImpl().bookFlight(userId, flightId, seats);

            if (success) session.setAttribute("msg", "Flight booked successfully!");
            else session.setAttribute("msg", "Booking failed. Not enough seats or error occurred.");

        } catch (NumberFormatException nfe) {
            nfe.printStackTrace();
            req.getSession().setAttribute("msg", "Invalid input provided.");
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("msg", "Booking failed due to error.");
        }

        resp.sendRedirect(req.getContextPath() + "/SearchFlight");
    }
}
