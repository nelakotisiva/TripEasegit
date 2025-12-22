package controllerpackage.com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import Daopackage.com.CabDAO;
import dtopackage.com.Cab;
import dtopackage.com.User;
import utilpackage.com.EmailUtil;

@WebServlet("/VehicleListServlet")
public class CabServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CabDAO dao;

    @Override
    public void init() {
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

        String location = req.getParameter("location");

        List<Cab> vehicles =
                (location != null && !location.trim().isEmpty())
                        ? dao.getVehiclesByLocation(location.trim())
                        : dao.getAllVehicles();

        List<Integer> bookedIds = dao.getBookedVehicleIds(user.getUser_id());

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

        String rentalIdStr = req.getParameter("rentalId");
        String passengersStr = req.getParameter("passengers");
        String location = req.getParameter("location");

        if (rentalIdStr == null || passengersStr == null) {
            resp.sendRedirect("VehicleListServlet?msg=invalid");
            return;
        }

        int rentalId;
        int passengers;

        try {
            rentalId = Integer.parseInt(rentalIdStr);
            passengers = Integer.parseInt(passengersStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect("VehicleListServlet?msg=invalid");
            return;
        }

        boolean booked = dao.saveBooking(user.getUser_id(), rentalId, passengers);

        if (booked) {

            String subject = "🚕 TripEase - Cab Booking Confirmation";

            String message =
                    "Hello " + user.getFull_name() + ",\n\n" +
                    "Your cab booking is CONFIRMED.\n\n" +
                    "Cab ID      : " + rentalId + "\n" +
                    "Passengers  : " + passengers + "\n\n" +
                    "Thank you for choosing TripEase.\n\n" +
                    "Regards,\nTripEase Team";

            EmailUtil.sendEmail(user.getEmail(), subject, message);

            String loc = (location != null)
                    ? URLEncoder.encode(location, "UTF-8")
                    : "";

            resp.sendRedirect("VehicleListServlet?location=" + loc + "&msg=success");
        } else {
            resp.sendRedirect("VehicleListServlet?location=" + location + "&msg=fail");
        }
    }
}
