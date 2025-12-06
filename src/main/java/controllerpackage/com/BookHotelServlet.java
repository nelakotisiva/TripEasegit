package controllerpackage.com;

import java.io.IOException;

import dtopackage.com.Hotel;
import UserDaopackage.com.HotelDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/BookHotel")
public class BookHotelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int hotelId = Integer.parseInt(req.getParameter("id"));

        HotelDAOImpl dao = new HotelDAOImpl();
        Hotel hotel = dao.getHotelById(hotelId);

        req.setAttribute("hotel", hotel);
        req.getRequestDispatcher("HotelBooking.jsp").forward(req, resp);
    }
}
