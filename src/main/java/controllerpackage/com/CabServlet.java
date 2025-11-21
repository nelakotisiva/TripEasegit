package controllerpackage.com;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import Daopackage.com.CabDAO;
import dtopackage.com.Cab;

@WebServlet("/VehicleListServlet")
public class CabServlet extends HttpServlet {

    CabDAO dao = new CabDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Cab> rentals = dao.getAllRentals();
        req.setAttribute("rentals", rentals);

        RequestDispatcher rd = req.getRequestDispatcher("Cabs.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int rentalId = Integer.parseInt(req.getParameter("rentalId"));

        boolean success = dao.bookRental(rentalId);

        if (success) {
            req.setAttribute("message", "Booking Successful!");
        } else {
            req.setAttribute("message", "Booking Failed!");
        }

        doGet(req, resp);
    }
}
