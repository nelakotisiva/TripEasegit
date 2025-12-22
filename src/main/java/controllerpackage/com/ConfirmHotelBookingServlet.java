package controllerpackage.com;

import java.io.IOException;
import java.net.URLEncoder;

import UserDaopackage.com.HotelBookingDAO;
import UserDaopackage.com.HotelBookingDAOImpl;
import UserDaopackage.com.HotelDAO;
import UserDaopackage.com.HotelDAOImpl;
import dtopackage.com.Hotel;
import dtopackage.com.User;
import utilpackage.com.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ConfirmHotelBooking")
public class ConfirmHotelBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userObj");

        try {
            int hotelId = Integer.parseInt(req.getParameter("hotelId"));
            String checkin = req.getParameter("checkin");
            String checkout = req.getParameter("checkout");
            int guests = Integer.parseInt(req.getParameter("guests"));

            HotelDAO hotelDAO = new HotelDAOImpl();
            Hotel hotel = hotelDAO.getHotelById(hotelId);

            double totalAmount = hotel.getPricePerNight() * guests;

            HotelBookingDAO bookingDAO = new HotelBookingDAOImpl();
            boolean success = bookingDAO.saveBooking(
                    user.getUser_id(),
                    hotelId,
                    checkin,
                    checkout,
                    guests,
                    totalAmount
            );

            if (success) {

                // ✅ SEND EMAIL (ONLY AFTER SUCCESS)
                String emailBody =
                        "Dear " + user.getFull_name() + ",\n\n" +
                        "Your hotel booking is CONFIRMED.\n\n" +
                        "Hotel: " + hotel.getHotelName() + "\n" +
                        "Location: " + hotel.getNearLocation() + "\n" +
                        "Check-in: " + checkin + "\n" +
                        "Check-out: " + checkout + "\n" +
                        "Guests: " + guests + "\n" +
                        "Total Amount: ₹" + totalAmount + "\n\n" +
                        "Thank you for choosing TripEase.";

                EmailUtil.sendEmail(
                        user.getEmail(),
                        "TripEase - Hotel Booking Confirmation",
                        emailBody
                );

                // ✅ REDIRECT WITH BOTH FLAGS (IMPORTANT)
                String city = URLEncoder.encode(hotel.getNearLocation(), "UTF-8");

                resp.sendRedirect(
                        "HotelListServlet?booked=true&city=" + city
                );
                return;
            }

            resp.sendRedirect("HotelListServlet?msg=failed");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("HotelListServlet?msg=error");
        }
    }
}
