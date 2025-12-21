package controllerpackage.com;

import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import dtopackage.com.Hotel;
import dtopackage.com.User;
import UserDaopackage.com.HotelBookingDAO;
import UserDaopackage.com.HotelBookingDAOImpl;
import UserDaopackage.com.HotelDAO;
import UserDaopackage.com.HotelDAOImpl;
import utilpackage.com.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ConfirmHotelBooking")
public class ConfirmHotelBookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

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

            LocalDate in = LocalDate.parse(checkin);
            LocalDate out = LocalDate.parse(checkout);

            long nights = ChronoUnit.DAYS.between(in, out);
            if (nights <= 0) nights = 1;

            // ✅ Fetch hotel
            HotelDAO hotelDao = new HotelDAOImpl();
            Hotel hotel = hotelDao.getHotelById(hotelId);

            if (hotel == null) {
                resp.sendRedirect("HotelListServlet");
                return;
            }

            double total = hotel.getPricePerNight() * nights * guests;

            // ✅ Save booking
            HotelBookingDAO bookingDAO = new HotelBookingDAOImpl();
            boolean success = bookingDAO.saveBooking(
                    user.getUser_id(),
                    hotelId,
                    checkin,
                    checkout,
                    guests,
                    total
            );

            if (success) {

                // ✅ SEND EMAIL (KEEP THIS)
                String body =
                        "Dear " + user.getFull_name() + ",\n\n" +
                        "Your hotel booking is confirmed.\n\n" +
                        "Hotel: " + hotel.getHotelName() + "\n" +
                        "Check-in: " + checkin + "\n" +
                        "Check-out: " + checkout + "\n" +
                        "Guests: " + guests + "\n" +
                        "Total Amount: ₹" + total + "\n\n" +
                        "Thank you for choosing TripEase.";

                EmailUtil.sendEmail(
                        user.getEmail(),
                        "TripEase - Hotel Booking Confirmation",
                        body
                );

                // ✅ TRIGGER POPUP (MATCHES JSP)
                String city = URLEncoder.encode(
                        hotel.getNearLocation(), "UTF-8"
                );

                resp.sendRedirect(
                        "HotelListServlet?msg=success&city=" + city
                );
                return;
            } else {
                req.setAttribute("error", "Booking failed. Try again.");
                req.getRequestDispatcher("HotelBooking.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("HotelListServlet");
        }
    }
}
