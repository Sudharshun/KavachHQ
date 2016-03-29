package com.kavach.neiu.sai;

import java.io.IOException;
import javax.servlet.http.*;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

public class GarudaServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

				
	    UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();  // Find out who the user is.
   if(user!=null){
	     

	   resp.sendRedirect("/garudaview.jsp");
		  
	
   }else{

		resp.getWriter().println("Sorry but your are not AUthorised!!!");

	   
   }

	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	
		doPost(req,resp);
		 
	}
	
	
}
