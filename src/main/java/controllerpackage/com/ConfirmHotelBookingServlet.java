package controllerpackage.com;

import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import dtopackage.com.Hotel;
import dtopackage.com.User;
import UserDaopackage.com.HotelBookingDAO;
import UserDaopackage.com.HotelBookingDAOImpl;
import UserDaopackage.com.HotelDAOImpl;

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
            String checkinStr = req.getParameter("checkin");
            String checkoutStr = req.getParameter("checkout");
            int guests = Integer.parseInt(req.getParameter("guests"));

            if (checkinStr == null || checkoutStr == null ||
                checkinStr.isEmpty() || checkoutStr.isEmpty()) {

                req.setAttribute("error", "Please select dates.");
                req.getRequestDispatcher("HotelBooking.jsp").forward(req, resp);
                return;
            }

            LocalDate checkin = LocalDate.parse(checkinStr);
            LocalDate checkout = LocalDate.parse(checkoutStr);

            long nights = ChronoUnit.DAYS.between(checkin, checkout);
            if (nights <= 0) nights = 1;

            HotelDAOImpl hotelDao = new HotelDAOImpl();
            Hotel hotel = hotelDao.getHotelById(hotelId);

            if (hotel == null) {
                req.setAttribute("error", "Hotel not found.");
                req.getRequestDispatcher("hotelList.jsp").forward(req, resp);
                return;
            }

            double total =
                    hotel.getPricePerNight() * nights * Math.max(1, guests);

            HotelBookingDAO bookingDao = new HotelBookingDAOImpl();
            boolean success = bookingDao.saveBooking(
                    user.getUser_id(),
                    hotelId,
                    checkinStr,
                    checkoutStr,
                    guests,
                    total
            );

            if (success) {
                // ✅ SUCCESS POPUP MESSAGE
                session.setAttribute(
                        "bookingSuccess",
                        "Hotel booked successfully!"
                );

                // redirect to hotel list
                resp.sendRedirect("HotelListServlet");
                return;
            } else {
                req.setAttribute("error", "Booking failed. Try again.");
                req.getRequestDispatcher("HotelBooking.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Invalid booking details.");
            req.getRequestDispatcher("hotelList.jsp").forward(req, resp);
        }
    }
}
