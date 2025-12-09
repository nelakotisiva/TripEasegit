package controllerpackage.com;

import java.io.IOException;
import dtopackage.com.Hotel;
import UserDaopackage.com.HotelDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BookHotel")
public class BookHotelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect("HotelListServlet");
            return;
        }

        int hotelId;
        try {
            hotelId = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect("HotelListServlet");
            return;
        }

        HotelDAOImpl dao = new HotelDAOImpl();
        Hotel hotel = dao.getHotelById(hotelId);

        if (hotel == null) {
            req.setAttribute("error", "Hotel not found.");
            req.getRequestDispatcher("hotelList.jsp").forward(req, resp);
            return;
        }

        // User session
        Object userObj = req.getSession().getAttribute("userObj");
        if (userObj == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        req.setAttribute("hotel", hotel);
        req.getRequestDispatcher("HotelBooking.jsp").forward(req, resp);
    }
}
