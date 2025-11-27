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
            int flightId = Integer.parseInt(req.getParameter("flightId"));
            int seats = Integer.parseInt(req.getParameter("seats"));

            HttpSession session = req.getSession();
            dtopackage.com.User user = (dtopackage.com.User) session.getAttribute("userObj");

            if (user == null) {
                session.setAttribute("msg", "Please login to book a flight.");
                resp.sendRedirect("SearchFlight");
                return;
            }

            int userId = user.getUser_id();

            boolean success = new FlightBookingDAOImpl().bookFlight(userId, flightId, seats);

            if (success) session.setAttribute("msg", "Flight booked successfully!");
            else session.setAttribute("msg", "Booking failed. Not enough seats.");

        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("msg", "Booking failed due to error.");
        }

        resp.sendRedirect("SearchFlight");
    }
}
