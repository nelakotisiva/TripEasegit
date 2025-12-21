package controllerpackage.com;

import java.io.IOException;
import java.util.*;
import Daopackage.com.RestaurantDAO;
import Daopackage.com.RestaurantDAOImpl;
import dtopackage.com.Restaurant;
import dtopackage.com.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/nearbyRestaurants")
public class NearbyRestaurantsServlet extends HttpServlet {

    private RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
  
    private static final double MAX_DISTANCE_KM = 10;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userObj") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userObj");
        int userId = user.getUser_id();

        String latStr = req.getParameter("lat");
        String lonStr = req.getParameter("lon");

        Double userLat = (latStr != null) ? Double.parseDouble(latStr) : null;
        Double userLon = (lonStr != null) ? Double.parseDouble(lonStr) : null;

        double budget = restaurantDAO.getLastBookingAmountRestaurant(userId);

        List<Restaurant> list =
                (budget > 0 ? restaurantDAO.getRestaurantsByMaxPrice(budget)
                            : restaurantDAO.getAllRestaurants());

        List<Restaurant> finalList = new ArrayList<>();

        if (userLat != null && userLon != null) {

            for (Restaurant r : list) {
                double dist = distance(userLat, userLon, r.getLatitude(), r.getLongitude());
                if (dist <= MAX_DISTANCE_KM) finalList.add(r);
            }

            finalList.sort(Comparator.comparingDouble(
                    r -> distance(userLat, userLon, r.getLatitude(), r.getLongitude())
            ));

        } else {
            finalList = list;
        }

        req.setAttribute("restaurants", finalList);
        req.setAttribute("budget", budget);

        req.getRequestDispatcher("Restaurant.jsp").forward(req, resp);
    }

    private double distance(double lat1, double lon1, double lat2, double lon2) {
        final double R = 6371;
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat/2)*Math.sin(dLat/2) +
                   Math.cos(Math.toRadians(lat1)) *
                   Math.cos(Math.toRadians(lat2)) *
                   Math.sin(dLon/2)*Math.sin(dLon/2);
        return R * (2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a)));
    }
}
