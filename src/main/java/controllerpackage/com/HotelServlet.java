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
        String booked = req.getParameter("booked"); // ✅ NEW

        HotelDAOImpl dao = new HotelDAOImpl();

        // 🔹 CASE 1: Hotel booked → show popup only, NO hotel list
        if ("true".equals(booked) && (location == null || location.trim().isEmpty())) {
            req.setAttribute("hotels", null);   // keep search-only rule
            req.getRequestDispatcher("hotelList.jsp").forward(req, resp);
            return;
        }

        // 🔹 CASE 2: First load → show nothing
        if (location == null || location.trim().isEmpty()) {
            req.setAttribute("hotels", null);
            req.getRequestDispatcher("hotelList.jsp").forward(req, resp);
            return;
        }

        // 🔹 CASE 3: Search performed → show hotels
        List<Hotel> hotels = dao.searchHotelsByCity(location.trim());
        req.setAttribute("hotels", hotels);
        req.setAttribute("searched", location);

        req.getRequestDispatcher("hotelList.jsp").forward(req, resp);
    }
}
