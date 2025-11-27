package controllerpackage.com;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import Daopackage.com.ResBookingDAO;
import Daopackage.com.ResBookingDaoImpl;
import Daopackage.com.RestaurantDAO;
import Daopackage.com.RestaurantDAOImpl;
import dtopackage.com.Restaurant;
import dtopackage.com.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/nearbyRestaurants")
public class NearbyRestaurantsServlet extends HttpServlet{
    private ResBookingDAO bookingDAO = new ResBookingDaoImpl();
    private RestaurantDAO restaurantDAO = new RestaurantDAOImpl();

    private static final double MAX_DISTANCE_KM = 10.0;  // radius
    Double userlat=null;
	Double userlon=null;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session=req.getSession(false);
		User user=(User)session.getAttribute("userObj");
		if(session==null||session.getAttribute("userObj")==null) {
			resp.sendRedirect("Login.jsp");
			return ;
		}
		
		int UID=user.getUser_id();
		String latstr=req.getParameter("lat");
		String lonstr=req.getParameter("lon");
		
		if(latstr!=null && lonstr!=null && !latstr.isEmpty() && !lonstr.isEmpty()) {
			userlat=Double.parseDouble(latstr);
			userlon=Double.parseDouble(lonstr);
		}
		
		double budget=bookingDAO.getLastBookingAmountRestaurent(UID);
		if(budget<=0) {
			  req.setAttribute("message", "No previous booking amount found. Showing all nearby restaurants by location.");
		}
		
		List<Restaurant> baselist;
		if(budget>0) {
			baselist = restaurantDAO.getRestaurantsByMaxPrice(budget);
		}
		else {
			baselist=restaurantDAO.getAllRestaurants();
		}
		
		
		List<Restaurant> finallist=new ArrayList<Restaurant>(); 
		if(userlat!=null && userlon!=null) {
			for(Restaurant r: baselist) {
				double dist=distanceKM(userlat,userlon,r.getLatitude(),r.getLongitude());
				if(!Double.isNaN(dist)&&dist<=MAX_DISTANCE_KM) {
					finallist.add(r);
				}
			}
			finallist.sort(Comparator.comparingDouble(
					r->distanceKM(userlat, userlon, r.getLatitude(), r.getLongitude())
					
					));
		}
		else {
			finallist=baselist;
			if(budget<=0) {
            req.setAttribute("message", "No location & no previous budget found. Showing all restaurants.");
			}
			 else {
	                req.setAttribute("message", "Showing restaurants within your previous budget (Location unavailable).");
	            }
		}
	req.setAttribute("restaurants", finallist);
	req.setAttribute("budget", budget);
	req.setAttribute("userlat", userlat);
	req.setAttribute("userlon", userlon);
	req.getRequestDispatcher("Restaurant.jsp").forward(req, resp);
		
	}


	private double distanceKM(double lat1, double lon1, double lat2, double lon2) {
		if(lat2==0 && lon2==0) return Double.NaN;
		final int R=6371;
		double dlat=Math.toRadians(lat2-lat1);
		double dlon=Math.toRadians(lon2-lon1);
		double a = Math.sin(dlat / 2) * Math.sin(dlat / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(dlon / 2) * Math.sin(dlon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
		return R*c;
	}
}
