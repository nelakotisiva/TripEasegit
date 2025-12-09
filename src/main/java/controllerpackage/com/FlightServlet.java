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

        String sourceRaw = req.getParameter("source");
        String destinationRaw = req.getParameter("destination");
        String date = req.getParameter("date");

        if (sourceRaw == null) sourceRaw = "";
        if (destinationRaw == null) destinationRaw = "";
        if (date == null) date = "";

        List<Flight> flights = null;

        if (!sourceRaw.trim().isEmpty() && !destinationRaw.trim().isEmpty()) {
            flights = new FlightDAOImpl().searchFlights(sourceRaw, destinationRaw);
        }

        req.setAttribute("source", sourceRaw);
        req.setAttribute("destination", destinationRaw);
        req.setAttribute("date", date);
        req.setAttribute("flights", flights);

        req.getRequestDispatcher("flightSearch.jsp").forward(req, resp);
    }
}
