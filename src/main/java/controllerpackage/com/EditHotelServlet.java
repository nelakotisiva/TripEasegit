package controllerpackage.com;

import java.io.IOException;

import UserDaopackage.com.HotelDAOImpl;
import dtopackage.com.Hotel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/EditHotel")
public class EditHotelServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        if (session.getAttribute("adminObj") == null) {
            resp.sendRedirect("Adminlogin.jsp");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));

        HotelDAOImpl dao = new HotelDAOImpl();
        Hotel hotel = dao.getHotelById(id);

        req.setAttribute("hotel", hotel);
        req.getRequestDispatcher("EditHotel.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        if (session.getAttribute("adminObj") == null) {
            resp.sendRedirect("Adminlogin.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(req.getParameter("hotelId"));
            String name = req.getParameter("hotelName");
            String location = req.getParameter("nearLocation");
            double price = Double.parseDouble(req.getParameter("price"));
            int rooms = Integer.parseInt(req.getParameter("rooms"));
            String imageUrl = req.getParameter("imageUrl");

            Hotel h = new Hotel();
            h.setHotelId(id);
            h.setHotelName(name);
            h.setNearLocation(location);
            h.setPricePerNight(price);
            h.setRoomsAvailable(rooms);
            h.setImageUrl(imageUrl);

            HotelDAOImpl dao = new HotelDAOImpl();
            boolean updated = dao.updateHotel(h);

            if (updated) {
                session.setAttribute("msg", "Hotel updated successfully!");
            } else {
                session.setAttribute("msg", "Error updating hotel!");
            }

            resp.sendRedirect("ManageHotels");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("ManageHotels");
        }
    }
}
