package controllerpackage.com;

import java.io.IOException;
import java.util.List;

import UserDaopackage.com.FlightDAOImpl;
import dtopackage.com.Flight;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/SearchFlight")
public class FlightServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

        String source = req.getParameter("source");
        String destination = req.getParameter("destination");

        List<Flight> flights = null;

        // normalize inputs
        source = (source == null) ? "" : source.trim();
        destination = (destination == null) ? "" : destination.trim();

        if (!source.isEmpty() && !destination.isEmpty()) {
            // pass raw values (DAO will handle lowercasing/trimming as well)
            flights = new FlightDAOImpl().searchFlights(source, destination);
        }

        req.setAttribute("flights", flights);
        req.setAttribute("source", source);
        req.setAttribute("destination", destination);

        req.getRequestDispatcher("flightSearch.jsp").forward(req, resp);
    }
}
