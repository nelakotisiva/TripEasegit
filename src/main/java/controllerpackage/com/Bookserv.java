package controllerpackage.com;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Bookserv extends HttpServlet {
	 private Daopackage.com.PackageDAO packageDAO = new Daopackage.com.PackageDAO();
	    private Daopackage.com.BookingDAO bookingDAO = new Daopackage.com.BookingDAO();
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

          dtopackage.com.PackageDTO p = packageDAO.findById(id);
          if (p == null) {
              resp.sendRedirect("tourpackage.jsp");
              return;
          }

          req.setAttribute("package", p);
          req.getRequestDispatcher("details.jsp").forward(req, resp);
      }


      protected void doPost(HttpServletRequest req, HttpServletResponse resp)
              throws ServletException, IOException {

    	  dtopackage.com.BookingDTO b = new dtopackage.com.BookingDTO();
          b.setPackageId(Integer.parseInt(req.getParameter("packageId")));
          b.setCustomerName(req.getParameter("customerName"));
          b.setEmail(req.getParameter("email"));
          b.setPhone(req.getParameter("phone"));
          b.setFromLocation(req.getParameter("from"));
          b.setToLocation(req.getParameter("to"));

          String travellersParam = req.getParameter("travellers");
          int travellers = 1;
          try {
              travellers = Integer.parseInt(travellersParam);
          } catch (Exception ignored) {}
          b.setTravellers(travellers);

          b.setTravelDate(req.getParameter("travelDate"));   // expected yyyy-MM-dd
          b.setReturnDate(req.getParameter("returnDate"));   // expected yyyy-MM-dd

          dtopackage.com.PackageDTO p = packageDAO.findById(b.getPackageId());
          if (p != null) b.setPackageTitle(p.getTitle());

          dtopackage.com.BookingDTO saved = bookingDAO.save(b);

          if (saved == null) {
              resp.getWriter().write("Booking failed. Please try again later.");
              return;
          }

          req.setAttribute("booking", saved);
          req.getRequestDispatcher("confirmation.jsp").forward(req, resp);
      }
   
	}

