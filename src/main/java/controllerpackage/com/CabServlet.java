package controllerpackage.com;
import jakarta.mail.Message;
import jakarta.mail.Transport;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import Daopackage.com.CabDAO;
import dtopackage.com.Cab;
import dtopackage.com.User;

import utilpackage.com.EmailUtil;


@WebServlet("/VehicleListServlet")
public class CabServlet extends HttpServlet {

    private CabDAO dao;

    @Override
    public void init() {
        dao = new CabDAO();
    }

    // -----------------------------------
    // SHOW CABS (GET)
    // -----------------------------------
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
            vehicles = dao.getVehiclesByLocation(location);
        } else {
            vehicles = dao.getAllVehicles();
        }

        // Already booked cabs by this user
        List<Integer> bookedIds = dao.getBookedVehicleIds(userId);

        req.setAttribute("vehicles", vehicles);
        req.setAttribute("bookedIds", bookedIds);
        req.setAttribute("location", location);

        req.getRequestDispatcher("Cabs.jsp").forward(req, resp);
    }

    // -----------------------------------
    // BOOK CAB (POST)
    // -----------------------------------
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
        } catch (Exception e) {
            resp.sendRedirect("VehicleListServlet?msg=invalid");
            return;
        }


        boolean ok = dao.saveBooking(user.getUser_id(), rentalId, passengers);

        if (ok) {
            // Fetch cab details
            Cab cab = dao.getCabById(rentalId); // create this DAO method

            EmailUtil.sendBookingMail(
                user.getFull_name(),
                user.getEmail(),
                cab.getModel(),
                cab.getSeaterType(),
                cab.getLocation(),
                cab.getPricePerDay()
            );

            resp.sendRedirect("VehicleListServlet?location=" + req.getParameter("location") + "&msg=success");
        } else {
            resp.sendRedirect("VehicleListServlet?location=" + req.getParameter("location") + "&msg=fail");
        }

    }
}
