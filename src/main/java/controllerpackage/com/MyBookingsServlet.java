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

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get existing session, don't create new
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        // Get logged-in user from session
        User user = (User) session.getAttribute("userObj");

        // Optional debug logs
        System.out.println("Fetching bookings for userId = " + user.getUser_id());

        // Use DAO to fetch bookings
        HotelBookingDAO dao = new HotelBookingDAOImpl();
        List<Bookingg> bookings = dao.getBookingsByUser(user.getUser_id());

        System.out.println("Bookings found = " + bookings.size());

        // Set data in request scope and forward to JSP
        req.setAttribute("bookings", bookings);
        req.getRequestDispatcher("MyBookings.jsp").forward(req, resp);
    }
}
