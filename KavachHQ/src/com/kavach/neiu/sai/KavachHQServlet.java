package com.kavach.neiu.sai;

import java.io.IOException;
import javax.servlet.http.*;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

public class KavachHQServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

	    Message messageToStore;

	    UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();  // Find out who the user is.

	    String messagebookName = req.getParameter("messagebookName");
	    String content = req.getParameter("content");
	    String meantfor = req.getParameter("meantfor");
	    
	    if (user != null) {
	    	messageToStore = new Message(messagebookName, content, user.getUserId(), user.getEmail(),meantfor);
	    } else {
	    	messageToStore = new Message(messagebookName, content);
	    }

	    // Use Objectify to save the greeting and now() is used to make the call synchronously as we
	    // will immediately get a new page using redirect and we want the data to be present.
	    ObjectifyService.ofy().save().entity(messageToStore).now();

	    resp.sendRedirect("/messagebook.jsp?messagebookName=" + messagebookName);
	  
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		

	doPost(req,resp);
	 
	}
}
