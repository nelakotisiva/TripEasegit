package controllerpackage.com.Admin.Cab;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import Daopackage.com.AdminCabDAO;
import dtopackage.com.Cab;

@WebServlet("/AdminManageCabs")
public class AdminManageCabsServlet extends HttpServlet {

    AdminCabDAO dao = new AdminCabDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        if(session.getAttribute("adminObj") == null){
            resp.sendRedirect("Adminlogin.jsp");
            return;
        }

        List<Cab> list = dao.getAllCabs();
        req.setAttribute("list", list);
        req.getRequestDispatcher("AdminManageCabs.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if("add".equals(action)){
            dao.addCab(req);
        } 
        else if("delete".equals(action)){
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteCab(id);
        }

        resp.sendRedirect("AdminManageCabs");
    }
}
