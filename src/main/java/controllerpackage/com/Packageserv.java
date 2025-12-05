package controllerpackage.com;

import java.io.IOException;
import java.util.List;

import dtopackage.com.PackageDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/packages")
public class Packageserv  extends HttpServlet{
	 private Daopackage.com.PackageDAO dao = new Daopackage.com.PackageDAO(); 
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 String dest = req.getParameter("to");
	        if (dest == null) dest = "";

	        List<PackageDTO> list = dao.getByDestination(dest);

	        req.setAttribute("packages", list);
	        req.setAttribute("destination", dest);

	        req.getRequestDispatcher("packages.jsp").forward(req, resp);
	}
}
