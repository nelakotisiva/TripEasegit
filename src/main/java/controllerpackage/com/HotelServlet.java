package controllerpackage.com;

import java.io.IOException;
import java.util.List;

import UserDaopackage.com.HotelDAOImpl;
import dtopackage.com.Hotel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/HotelListServlet")
public class HotelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String location = req.getParameter("location");

        HotelDAOImpl dao = new HotelDAOImpl();
        List<Hotel> hotelList = null;

        // ONLY show hotels when user searches
        if (location != null && !location.trim().isEmpty()) {
            hotelList = dao.getHotelsByLocation(location);
        }

        req.setAttribute("hotels", hotelList);
        req.setAttribute("searched", location);
        req.getRequestDispatcher("hotelList.jsp").forward(req, resp);
    }
}
