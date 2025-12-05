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
import dtopackage.com.User;

@WebServlet("/MyBookingsServlet")
public class MyBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        HttpSession session = request.getSession();
        User userObj = (User) session.getAttribute("userObj");

        if (userObj == null) {
        	
            response.sendRedirect("Login.jsp");
            return;
        }
        
        
        
        BookingDAO bookingDao = new BookingDAOImpl();
       
        List<Booking> bookings = bookingDao.getBookingsByUserId(userObj.getUser_id());
     
        request.setAttribute("bookings", bookings);
     
        request.getRequestDispatcher("MyBookings.jsp").forward(request, response);
        
    }
}
