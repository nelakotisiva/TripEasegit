package controllerpackage.com;

import java.io.IOException;
import java.util.List;

import UserDaopackage.com.HotelDAOImpl;
import dtopackage.com.Hotel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ManageHotels")
public class ManageHotelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("adminObj") == null) {
            resp.sendRedirect("Adminlogin.jsp");
            return;
        }

        HotelDAOImpl dao = new HotelDAOImpl();
        List<Hotel> hotelList = dao.getAllHotels();

        req.setAttribute("hotelList", hotelList);
        req.getRequestDispatcher("manageHotels.jsp").forward(req, resp);
    }
}
