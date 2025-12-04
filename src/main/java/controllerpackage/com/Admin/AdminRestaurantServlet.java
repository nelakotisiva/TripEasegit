package controllerpackage.com.Admin;

import java.io.IOException;
import java.util.List;

import Daopackage.com.RestaurantDAO;
import Daopackage.com.RestaurantDAOImpl;
import dtopackage.com.Restaurant;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/adminRestaurant")
public class AdminRestaurantServlet extends HttpServlet {

    private RestaurantDAO dao = new RestaurantDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                Restaurant r = dao.getRestaurantById(id);
                req.setAttribute("restaurant", r);
                req.getRequestDispatcher("editRestaurant.jsp").forward(req, resp);
                break;

            case "delete":
                int deleteId = Integer.parseInt(req.getParameter("id"));
                dao.deleteRestaurant(deleteId);
                resp.sendRedirect("adminRestaurant?action=list");
                break;

            default: // list
                List<Restaurant> list = dao.getAllRestaurants();
                req.setAttribute("list", list);
                req.getRequestDispatcher("adminRestaurantList.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        Restaurant r = new Restaurant();
        r.setRestaurantId(Integer.parseInt(req.getParameter("id")));
        r.setDestinationId(Integer.parseInt(req.getParameter("destinationId")));
        r.setName(req.getParameter("name"));
        r.setType(req.getParameter("type"));
        r.setRating(Double.parseDouble(req.getParameter("rating")));
        r.setContact(req.getParameter("contact"));
        r.setAvgPrice(Double.parseDouble(req.getParameter("avgPrice")));
        r.setLatitude(Double.parseDouble(req.getParameter("latitude")));
        r.setLongitude(Double.parseDouble(req.getParameter("longitude")));

        if ("add".equals(action)) {
            dao.addRestaurant(r);
        } else if ("update".equals(action)) {
            dao.updateRestaurant(r);
        }

        resp.sendRedirect("adminRestaurant?action=list");
    }
}
