package controllerpackage.com;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import Daopackage.com.CabDAO;
import dtopackage.com.Cab;
import dtopackage.com.User;

@WebServlet("/VehicleListServlet")
public class CabServlet extends HttpServlet {

    CabDAO dao = new CabDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String location = req.getParameter("location");

        List<Cab> vehicles;

        if (location != null && !location.trim().isEmpty()) {
            vehicles = dao.getVehiclesByLocation(location);
        } else {
            vehicles = dao.getAllVehicles();
        }

        List<Integer> bookedIds = dao.getBookedVehicleIds();

        req.setAttribute("vehicles", vehicles);
        req.setAttribute("bookedIds", bookedIds);
        req.setAttribute("location", location);

        req.getRequestDispatcher("Cabs.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int rentalId = Integer.parseInt(req.getParameter("rentalId"));
        int passengers = Integer.parseInt(req.getParameter("passengers"));
        String location = req.getParameter("location");

        User user = (User) req.getSession().getAttribute("userObj");
        int userId = user.getUser_id();

        dao.saveBooking(userId, rentalId, passengers);

        resp.sendRedirect("VehicleListServlet?location=" + location);
    }
}
