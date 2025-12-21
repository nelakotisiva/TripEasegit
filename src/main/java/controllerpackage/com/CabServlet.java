package controllerpackage.com;
//hi
import jakarta.servlet.ServletException;
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
    public void init() throws ServletException {
        dao = new CabDAO();   // safe initialization
    }

    /* -------------------- SHOW CABS -------------------- */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("userObj");

        if (user == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        String location = req.getParameter("location");

        List<Cab> vehicles;
        if (location != null && !location.trim().isEmpty()) {
            vehicles = dao.getVehiclesByLocation(location);
        } else {
            vehicles = dao.getAllVehicles();
        }

        // block already booked cabs for this user
        List<Integer> bookedIds = dao.getBookedVehicleIds(user.getUser_id());

        req.setAttribute("vehicles", vehicles);
        req.setAttribute("bookedIds", bookedIds);
        req.setAttribute("location", location);

        req.getRequestDispatcher("Cabs.jsp").forward(req, resp);
    }

    /* -------------------- BOOK CAB -------------------- */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("userObj");

        if (user == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        int rentalId = Integer.parseInt(req.getParameter("rentalId"));
        int passengers = Integer.parseInt(req.getParameter("passengers"));
        String location = req.getParameter("location");

        // 🔹 SAVE CAB BOOKING (ONLY cab_booking table)
        boolean booked = dao.saveBooking(user.getUser_id(), rentalId, passengers);

        if (booked) {

            /* ---------------- EMAIL TO ADMIN ---------------- */
           

            String subject = "🚕 New Cab Booking - TripEase";

            String message =
                    "New Cab Booking Received\n\n" +
                    "User Name   : " + user.getFull_name() + "\n" +
                    "User Email  : " + user.getEmail() + "\n" +
                    "Cab ID      : " + rentalId + "\n" +
                    "Passengers  : " + passengers + "\n\n" +
                    "Please login to admin panel for details.";

            EmailUtil.sendEmail(user.getEmail(), subject, message);

            resp.sendRedirect("VehicleListServlet?location=" + location + "&msg=success");

        } else {
            resp.sendRedirect("VehicleListServlet?location=" + location + "&msg=fail");
        }
    }
}