package controllerpackage.com;

import java.io.IOException;
import java.util.List;

import dtopackage.com.Bookingg;
import dtopackage.com.User;
import UserDaopackage.com.HotelBookingDAO;
import UserDaopackage.com.HotelBookingDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MyBookingsServlet")
public class MyBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userObj");

        // DEBUG
        System.out.println("Fetching bookings for userId = " + user.getUser_id());

        HotelBookingDAO dao = new HotelBookingDAOImpl();
        List<Bookingg> bookings = dao.getBookingsByUser(user.getUser_id());

        System.out.println("Bookings found = " + bookings.size());

        req.setAttribute("bookings", bookings);
        req.getRequestDispatcher("MyBooking.jsp").forward(req, resp); // FIXED NAME
    }
}
