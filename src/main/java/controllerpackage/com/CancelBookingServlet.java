package controllerpackage.com;

import java.io.IOException;

import Daopackage.com.CabDAO;
import Daopackage.com.RestaurantBookingDAOImpl;
import UserDaopackage.com.FlightBookingDAOImpl;
import UserDaopackage.com.HotelBookingDAOImpl;
import dtopackage.com.User;
import utilpackage.com.EmailUtil;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userObj");

        String bookingIdStr = req.getParameter("bookingId");
        String serviceType  = req.getParameter("serviceType");

        if (bookingIdStr == null || serviceType == null) {
            session.setAttribute("cancelMsg","❌ Invalid cancellation request.");
            resp.sendRedirect("MyBookingsServlet");
            return;
        }

        int bookingId = Integer.parseInt(bookingIdStr);
        serviceType = serviceType.toUpperCase();

        switch (serviceType) {
            case "HOTEL": new HotelBookingDAOImpl().cancelBooking(bookingId); break;
            case "FLIGHT": new FlightBookingDAOImpl().cancelBooking(bookingId); break;
            case "CAB": new CabDAO().cancelCabBooking(bookingId); break;
            case "RESTAURANT": new RestaurantBookingDAOImpl().cancelBooking(bookingId); break;
            default:
                session.setAttribute("cancelMsg","❌ Invalid booking type.");
                resp.sendRedirect("MyBookingsServlet");
                return;
        }

        EmailUtil.sendEmail(
            user.getEmail(),
            "❌ Booking Cancelled | TripEase",
            "Hello "+user.getFull_name()+
            ",\n\nYour "+serviceType+" booking has been cancelled."
        );

        session.setAttribute("cancelMsg",
            "✅ "+serviceType+" booking cancelled successfully!");
        resp.sendRedirect("MyBookingsServlet");
    }
}
