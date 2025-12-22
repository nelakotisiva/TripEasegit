package controllerpackage.com;

import java.io.IOException;
import java.util.List;

import UserDaopackage.com.HotelBookingDAO;
import UserDaopackage.com.HotelBookingDAOImpl;
import dtopackage.com.Bookingg;
import dtopackage.com.User;

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
        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userObj");

        List<Bookingg> bookings =
                bookingDAO.getBookingsByUser(user.getUser_id());

        req.setAttribute("hotelBookings", bookings);
        req.getRequestDispatcher("MyHotelBookings.jsp").forward(req, resp);
    }
}
