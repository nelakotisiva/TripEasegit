package controllerpackage.com;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utilpackage.com.Bookingemail;
import Daopackage.com.PackageDAO;
import Daopackage.com.BookingDAO;
import Daopackage.com.BookingDAOImpl;
import dtopackage.com.BookingDTO;
import dtopackage.com.PackageDTO;

@WebServlet("/book")
public class Bookserv extends HttpServlet {

	private PackageDAO packageDAO = new PackageDAO();
	// FIXED
	private BookingDAO bookingDAO = new BookingDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("entering");
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

	    BookingDTO booking = new BookingDTO();

	    booking.setUserId(1); // TEMP USER
	    booking.setDestinationId(
	        getDestinationId(req.getParameter("to"))
	    );

	    booking.setFromLocation(req.getParameter("from"));
	    booking.setToLocation(req.getParameter("to"));
	    booking.setEmail(req.getParameter("email"));

	    booking.setTravelDate(
	        java.sql.Date.valueOf(req.getParameter("travelDate"))
	    );

	    try {
	        booking.setTravellers(
	            Integer.parseInt(req.getParameter("travellers")));
	    } catch (Exception e) {
	        booking.setTravellers(1);
	    }

	    BookingDTO saved = bookingDAO.save(booking);

	    if (saved == null) {
	        resp.sendRedirect("tourpackage.jsp");
	        return;
	    }

	    Bookingemail.sendBookingConfirmation(
	        booking.getEmail(),
	        saved.getId(),
	        booking.getToLocation(),
	        booking.getTravellers(),
	        booking.getTravelDate()
	    );

	    req.setAttribute("booking", saved);
	    req.getRequestDispatcher("confirmation.jsp").forward(req, resp);
	}


	private int getDestinationId(String dest) {
		switch (dest) {
		case "Goa":
			return 1;
		case "Mysore":
			return 2;
		case "Ooty":
			return 3;
		case "Kerala":
			return 4;
		default:
			return 1;
		}
	}
}
