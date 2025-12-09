package controllerpackage.com;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import Daopackage.com.BookingDAO;
import Daopackage.com.BookingDAOImpl;
import dtopackage.com.Booking;

@WebServlet("/ManageBookings")
public class ManageBookings extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Object adminObj = (session != null) ? session.getAttribute("adminObj") : null;

        if (adminObj == null) {
            response.sendRedirect("Adminlogin.jsp");
            return;
        }

        BookingDAO bookingDao = new BookingDAOImpl();
        List<Booking> bookings = bookingDao.getAllBookings();

        request.setAttribute("bookings", bookings);

        request.getRequestDispatcher("ManageBookings.jsp").forward(request, response);
    }
}
