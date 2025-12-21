package controllerpackage.com;

import java.io.IOException;

import Daopackage.com.CabDAO;
import Daopackage.com.RestaurantBookingDAOImpl;
import UserDaopackage.com.FlightBookingDAOImpl;
import UserDaopackage.com.HotelBookingDAOImpl;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int bookingId = Integer.parseInt(req.getParameter("bookingId"));
        String type = req.getParameter("type");
        System.out.println(bookingId+"bookingid");
        switch (type.toUpperCase()) {

            case "HOTEL":
                new HotelBookingDAOImpl().cancelBooking(bookingId);
                break;

            case "CAB":
                new CabDAO().cancelCabBooking(bookingId); // ✅ status-based
                break;

            case "FLIGHT":
                new FlightBookingDAOImpl().cancelBooking(bookingId);
                break;

            case "RESTAURANT":
                new RestaurantBookingDAOImpl().cancelBooking(bookingId);
                break;
        }

        resp.sendRedirect("MyBookingsServlet");
    }
}
