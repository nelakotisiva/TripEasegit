package controllerpackage.com;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import UserDaopackage.com.HotelBookingDAO;
import UserDaopackage.com.HotelBookingDAOImpl;
import dtopackage.com.Bookingg;
import dtopackage.com.User;
import dtopackage.com.UserBooking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MyHotelBookings")
public class MyHotelBookingsServlet extends HttpServlet {

    private HotelBookingDAO bookingDAO;

    @Override
    public void init() {
        bookingDAO = new HotelBookingDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔐 Session check
        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        // ✅ Get logged-in user
        User user = (User) session.getAttribute("userObj");
        int userId = user.getUser_id();

        // 🔥 Final list for JSP
        List<UserBooking> allBookings = new ArrayList<>();

        /* ================= 🏨 HOTEL BOOKINGS ================= */
        List<Bookingg> hotelBookings = bookingDAO.getBookingsByUser(userId);

        for (Bookingg h : hotelBookings) {
            UserBooking ub = new UserBooking();
            ub.setBookingType("HOTEL");
            ub.setTitle(h.getHotelName());
            ub.setSubtitle(h.getHotelLocation());
            ub.setBookingDate(h.getBookingDate());
            ub.setAmount(h.getTotalAmount());
            ub.setStatus("CONFIRMED");
            ub.setDetailsUrl("HotelDetails?id=" + h.getHotelId());
            allBookings.add(ub);
        }

        // 📦 Send data to JSP
        req.setAttribute("hotelBookings", hotelBookings);
        req.setAttribute("allBookings", allBookings);

        req.getRequestDispatcher("MyHotelBookings.jsp")
           .forward(req, resp);
    }
}
