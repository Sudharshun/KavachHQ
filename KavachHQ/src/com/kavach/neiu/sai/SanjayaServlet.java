package com.kavach.neiu.sai;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

public class SanjayaServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		 Message messageToStore;

		String messagefrom="";
		String messagecontent="";
		String messagefor="";
	
		String responseTxt="Bad response";
		messagefrom=req.getParameter("messagefrom");
		messagecontent=req.getParameter("messagecontent");
		messagefor=req.getParameter("messagefor");
		
	   
	     	messageToStore = new Message("sai", messagecontent, messagefrom,"sai" ,messagefor);
	 	   
	    // Use Objectify to save the greeting and now() is used to make the call synchronously as we
	    // will immediately get a new page using redirect and we want the data to be present.
	   
	responseTxt="From :"+messagefrom+",For :"+messagefor+", Content: "+messagecontent+" Saved!!!";
	
  
   ObjectifyService.ofy().save().entity(messageToStore).now();
	
	//resp.getWriter().println(responseTxt);
 	resp.sendRedirect("/confirmation.jsp?responseMsg=" + responseTxt);
	
	
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	

	    UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();  // Find out who the user is.
   
	 if(user!=null){
	    resp.sendRedirect("/vayuview.jsp?userName=" + user.getUserId());
	 }else{
		    resp.sendRedirect("/vayuview.jsp");
			
	 }
	 
	}
	
	
}
