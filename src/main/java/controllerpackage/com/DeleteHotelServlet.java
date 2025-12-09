package controllerpackage.com;

import java.io.IOException;

import UserDaopackage.com.HotelDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DeleteHotel")
public class DeleteHotelServlet extends HttpServlet {

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
        boolean deleted = dao.deleteHotel(id);

        if (deleted) {
            session.setAttribute("msg", "Hotel deleted successfully!");
        } else {
            session.setAttribute("msg", "Error deleting hotel!");
        }

        resp.sendRedirect("ManageHotels");
    }
}
