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

            // Debug
            System.out.println("------ BOOKING DEBUG ------");
            System.out.println("userId = " + user.getUser_id());
            System.out.println("hotelId = " + hotelId);
            System.out.println("checkin = " + checkinStr);
            System.out.println("checkout = " + checkoutStr);
            System.out.println("guests = " + guests);
            System.out.println("---------------------------");

            if (checkinStr == null || checkoutStr == null ||
                checkinStr.isEmpty() || checkoutStr.isEmpty()) {

                req.setAttribute("error", "Please select check-in and check-out dates.");
                req.getRequestDispatcher("HotelBooking.jsp").forward(req, resp);
                return;
            }

            LocalDate checkin = LocalDate.parse(checkinStr);
            LocalDate checkout = LocalDate.parse(checkoutStr);

            // 🔥 Allow same-day booking (1 day stay)
            long nights = ChronoUnit.DAYS.between(checkin, checkout);
            if (nights <= 0) {
                nights = 1;
            }

            // fetch hotel
            HotelDAOImpl hotelDao = new HotelDAOImpl();
            Hotel hotel = hotelDao.getHotelById(hotelId);

            if (hotel == null) {
                req.setAttribute("error", "Hotel not found.");
                req.getRequestDispatcher("hotelList.jsp").forward(req, resp);
                return;
            }

            double pricePerNight = hotel.getPricePerNight();
            double total = pricePerNight * nights * Math.max(1, guests);

            // save booking
            HotelBookingDAO bookingDao = new HotelBookingDAOImpl();
            boolean ok = bookingDao.saveBooking(
                    user.getUser_id(), hotelId, checkinStr, checkoutStr, guests, total
            );

            if (ok) {
                System.out.println("BOOKING SAVED SUCCESSFULLY!");
                resp.sendRedirect("MyBookingsServlet");
            } else {
                System.out.println("BOOKING FAILED!");
                req.setAttribute("error", "Failed to save booking. Try again.");
                req.getRequestDispatcher("HotelBooking.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Invalid input. Try again.");
            req.getRequestDispatcher("hotelList.jsp").forward(req, resp);
        }
    }
}
