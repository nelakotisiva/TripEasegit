package controllerpackage.com;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import Daopackage.com.PackageDAO;
import Daopackage.com.BookingDAO;
import Daopackage.com.BookingDAOImpl;
import dtopackage.com.BookingDTO;
import dtopackage.com.PackageDTO;

@WebServlet("/book")
public class Bookserv extends HttpServlet {

    private PackageDAO packageDAO = new PackageDAO();   // FIXED
    private BookingDAO bookingDAO = new BookingDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String pid = req.getParameter("packageId");

        if (pid == null || pid.trim().isEmpty()) {
            resp.sendRedirect("tourpackage.jsp");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(pid);
        } catch (NumberFormatException ex) {
            resp.sendRedirect("tourpackage.jsp");
            return;
        }

        PackageDTO pack = packageDAO.findById(id);

        if (pack == null) {
            resp.sendRedirect("tourpackage.jsp");
            return;
        }

        req.setAttribute("package", pack);
        req.getRequestDispatcher("details.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        BookingDTO booking = new BookingDTO();

        try {
            booking.setPackageId(Integer.parseInt(req.getParameter("packageId")));
        } catch (Exception ex) {
            resp.sendRedirect("error.jsp");
            return;
        }

        booking.setCustomerName(req.getParameter("customerName"));
        booking.setEmail(req.getParameter("email"));
        booking.setPhone(req.getParameter("phone"));
        booking.setFromLocation(req.getParameter("from"));
        booking.setToLocation(req.getParameter("to"));

        try {
            booking.setTravellers(Integer.parseInt(req.getParameter("travellers")));
        } catch (Exception e) {
            booking.setTravellers(1); // default
        }

        booking.setTravelDate(req.getParameter("travelDate"));
        booking.setReturnDate(req.getParameter("returnDate"));

        // Fetching package title
        PackageDTO pack = packageDAO.findById(booking.getPackageId());
        if (pack != null) {
            booking.setPackageTitle(pack.getTitle());
        }

        // Save booking
        BookingDTO saved = bookingDAO.save(booking);

        if (saved == null) {
            req.setAttribute("msg", "Booking failed! Try again.");
            resp.sendRedirect("error.jsp");
            return;
        }

        req.setAttribute("booking", saved);
        req.getRequestDispatcher("confirmation.jsp").forward(req, resp);
    }
}
