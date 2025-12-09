package controllerpackage.com;

import java.io.IOException;
import dtopackage.com.Hotel;
import UserDaopackage.com.HotelDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddHotel")
public class AddHotelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Show add hotel page (admin must be logged in)
        req.getRequestDispatcher("AddHotel.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // read form fields (we assume manual image URL input)
        String name = req.getParameter("hotelName");
        String location = req.getParameter("nearLocation");
        String priceStr = req.getParameter("price");
        String roomsStr = req.getParameter("rooms");
        String imageUrl = req.getParameter("imageUrl"); // manual URL field
        String ratingStr = req.getParameter("rating");
        String contact = req.getParameter("contact");
        String destIdStr = req.getParameter("destinationId");

        double price = 0;
        int rooms = 0;
        double rating = 0;
        int destId = 0;

        try { price = Double.parseDouble(priceStr); } catch (Exception ignored) {}
        try { rooms = Integer.parseInt(roomsStr); } catch (Exception ignored) {}
        try { rating = Double.parseDouble(ratingStr); } catch (Exception ignored) {}
        try { destId = Integer.parseInt(destIdStr); } catch (Exception ignored) {}

        Hotel h = new Hotel();
        h.setHotelName(name);
        h.setNearLocation(location);
        h.setPricePerNight(price);
        h.setRoomsAvailable(rooms);
        h.setImageUrl(imageUrl);
        h.setRating(rating);
        h.setContact(contact);
        h.setDestinationId(destId);

        HotelDAOImpl dao = new HotelDAOImpl();
        boolean ok = dao.addHotel(h);

        if (ok) {
            resp.sendRedirect("ManageHotels"); // admin list
        } else {
            req.setAttribute("error", "Failed to add hotel. Try again.");
            req.getRequestDispatcher("AddHotel.jsp").forward(req, resp);
        }
    }
}
