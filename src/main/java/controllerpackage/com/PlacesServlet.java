package controllerpackage.com;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import Daopackage.com.DestinationDAO;
import Daopackage.com.DestinationDAOImpl;
import dtopackage.com.Destination;

@WebServlet("/PlacesServlet")
public class PlacesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String q = request.getParameter("q");

        DestinationDAO dao = new DestinationDAOImpl();
        List<Destination> places;

        if (q != null && !q.trim().isEmpty()) {
            places = dao.searchDestinations(q.trim());
        } else {
            places = dao.getAllDestinations();
        }

        request.setAttribute("placesList", places);
        request.setAttribute("q", q);

        request.getRequestDispatcher("/famousPlaces.jsp")
               .forward(request, response);
    }
}
