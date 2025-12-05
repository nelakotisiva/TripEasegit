package controllerpackage.com;

import java.io.IOException;

import UserDaopackage.com.HotelBookingDAO;
import UserDaopackage.com.HotelBookingDAOImpl;
import dtopackage.com.User;
import dtopackage.com.Hotel;
import UserDaopackage.com.HotelDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ConfirmHotelBooking")
public class ConfirmHotelBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("userObj");

        if (user == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        int userId = user.getUser_id();
        int hotelId = Integer.parseInt(req.getParameter("hotelId"));
        String checkin = req.getParameter("checkin");
        String checkout = req.getParameter("checkout");
        int guests = Integer.parseInt(req.getParameter("guests"));

        Hotel hotel = new HotelDAOImpl().getHotelById(hotelId);
        double total = hotel.getPricePerNight();

        HotelBookingDAO bookingDao = new HotelBookingDAOImpl();
        boolean saved = bookingDao.saveBooking(userId, hotelId, checkin, checkout, guests, total);

        if (saved) {
            // ⭐ SUCCESS → DIRECTLY GO TO DASHBOARD (no success page)
            resp.sendRedirect("Dashboard.jsp?msg=success");
        } else {
            resp.getWriter().println("Booking failed, please try again.");
        }
    }
}
