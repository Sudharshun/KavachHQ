package com.kavach.neiu.sai;

import java.io.IOException;
import javax.servlet.http.*;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

public class AswiniServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		Checkin checkin;
		
		String userName="";
		String latitude="";
		String longitude="";
		String healthstatus="";
		String responseTxt="Bad response";
	   userName=req.getParameter("username");
	   latitude=req.getParameter("latitude");
	   longitude=req.getParameter("longitude");
	   healthstatus=req.getParameter("healthstatus");
	
	    	checkin = new Checkin("kavachchkn", latitude,longitude,healthstatus,userName,"sai");
	   

	    // Use Objectify to save the greeting and now() is used to make the call synchronously as we
	    // will immediately get a new page using redirect and we want the data to be present.
	   
	responseTxt="Username:"+userName+",Latitude/Longitude:"+latitude+":"+longitude+",Healthstatus:"+healthstatus+" Saved!!!";
	
  
   ObjectifyService.ofy().save().entity(checkin).now();
	
	//resp.getWriter().println(responseTxt);
   	resp.sendRedirect("/confirmation.jsp?responseMsg=" + responseTxt);
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	

	    UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();  // Find out who the user is.
   
	 if(user!=null){
	    resp.sendRedirect("/aswinikumara.jsp?userName=" + user.getUserId());
	 }else{
		    resp.sendRedirect("/aswinikumara.jsp");
			
	 }
	 
	}
	
	
}
