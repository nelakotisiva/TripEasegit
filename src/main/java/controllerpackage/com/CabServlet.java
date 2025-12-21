package controllerpackage.com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import Daopackage.com.CabDAO;
import dtopackage.com.Cab;
import dtopackage.com.User;

@WebServlet("/VehicleListServlet")
public class CabServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CabDAO dao;

    @Override
    public void init() throws ServletException {
        dao = new CabDAO();
    }

    /* ===================== SHOW CABS ===================== */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("userObj") : null;

        if (user == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        int userId = user.getUser_id();
        String location = req.getParameter("location");

        List<Cab> vehicles;
        if (location != null && !location.trim().isEmpty()) {
            vehicles = dao.getVehiclesByLocation(location.trim());
        } else {
            vehicles = dao.getAllVehicles();
        }

        List<Integer> bookedIds = dao.getBookedVehicleIds(userId);

        req.setAttribute("vehicles", vehicles);
        req.setAttribute("bookedIds", bookedIds);
        req.setAttribute("location", location);

        req.getRequestDispatcher("Cabs.jsp").forward(req, resp);
    }

    /* ===================== BOOK CAB ===================== */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("userObj") : null;

        if (user == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        int rentalId;
        int passengers;

        try {
            rentalId = Integer.parseInt(req.getParameter("rentalId"));
            passengers = Integer.parseInt(req.getParameter("passengers"));
        } catch (NumberFormatException e) {
            resp.sendRedirect("VehicleListServlet?msg=invalid");
            return;
        }

        boolean success = dao.saveBooking(user.getUser_id(), rentalId, passengers);

        if (success) {
            resp.sendRedirect("VehicleListServlet?msg=success");
        } else {
            resp.sendRedirect("VehicleListServlet?msg=fail");
        }
    }
}
