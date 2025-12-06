package controllerpackage.com;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import Daopackage.com.PackageDAO;
import Daopackage.com.BookingDAO;
import Daopackage.com.BookingDAOImpl;
import dtopackage.com.BookingDTO;
import dtopackage.com.PackageDTO;

public class Bookserv extends HttpServlet {

    private PackageDAO packageDAO = new PackageDAOImpl();
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

        PackageDTO p = packageDAO.findById(id);
        if (p == null) {
            resp.sendRedirect("tourpackage.jsp");
            return;
        }

        req.setAttribute("package", p);
        req.getRequestDispatcher("details.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        BookingDTO b = new BookingDTO();
        b.setPackageId(Integer.parseInt(req.getParameter("packageId")));
        b.setCustomerName(req.getParameter("customerName"));
        b.setEmail(req.getParameter("email"));
        b.setPhone(req.getParameter("phone"));
        b.setFromLocation(req.getParameter("from"));
        b.setToLocation(req.getParameter("to"));

        // Travellers with safe parsing
        try {
            b.setTravellers(Integer.parseInt(req.getParameter("travellers")));
        } catch (Exception ex) {
            b.setTravellers(1);
        }

        b.setTravelDate(req.getParameter("travelDate"));
        b.setReturnDate(req.getParameter("returnDate"));

        PackageDTO p = packageDAO.findById(b.getPackageId());
        if (p != null) {
            b.setPackageTitle(p.getTitle());
        }

        BookingDTO saved = bookingDAO.save(b);

        if (saved == null) {
            req.setAttribute("msg", "Booking Failed! Try again.");
            resp.sendRedirect("error.jsp");
            return;
        }

        req.setAttribute("booking", saved);
        req.getRequestDispatcher("confirmation.jsp").forward(req, resp);
    }
}
