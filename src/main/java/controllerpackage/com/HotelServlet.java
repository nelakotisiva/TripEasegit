package controllerpackage.com;

import java.io.IOException;
import java.util.List;

import UserDaopackage.com.HotelDAOImpl;
import dtopackage.com.Hotel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/HotelListServlet")
public class HotelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String location = req.getParameter("location");

        // ❌ DO NOT SHOW HOTELS BY DEFAULT
        if (location == null || location.trim().isEmpty()) {
            req.setAttribute("hotels", null);
            req.setAttribute("searched", "");
            req.getRequestDispatcher("hotelList.jsp").forward(req, resp);
            return;
        }

        // ✅ SHOW ONLY AFTER SEARCH
        HotelDAOImpl dao = new HotelDAOImpl();
        List<Hotel> hotels = dao.searchHotelsByCity(location.trim());

        req.setAttribute("hotels", hotels);
        req.setAttribute("searched", location);

        req.getRequestDispatcher("hotelList.jsp").forward(req, resp);
    }
}
