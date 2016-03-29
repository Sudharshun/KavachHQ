<%-- //[START all]--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%-- //[START imports]--%>
<%@ page import="com.kavach.neiu.sai.Message" %>
<%@ page import="com.kavach.neiu.sai.Messagebook" %>
<%@ page import="com.googlecode.objectify.Key" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%-- //[END imports]--%>

<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
</head>

<body>

<%
    String messagebookName = request.getParameter("messagebookName");
    if (messagebookName == null) {
    	messagebookName = "default";
    }
    pageContext.setAttribute("messagebookName", messagebookName);
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
        pageContext.setAttribute("user", user);
%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
    <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<%
    } else {
%>
<p>Hello!
    <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
    to include your name with Messages you post.</p>
<%
    }
%>

<%-- //[START datastore]--%>
<%
    // Create the correct Ancestor key
      Key<Messagebook> theBook = Key.create(Messagebook.class, messagebookName);

    // Run an ancestor query to ensure we see the most up-to-date
    // view of the Greetings belonging to the selected Guestbook.
      List<Message> messages = ObjectifyService.ofy()
          .load()
          .type(Message.class) // We want only Greetings
          .ancestor(theBook)    // Anyone in this book
          .order("-date")       // Most recent first - date is indexed.
          .limit(5)             // Only show 5 of them.
          .list();

    if (messages.isEmpty()) {
%>
<p>Messagebook ${fn:escapeXml(messagebookName)}' has no messages.</p>
<%
    } else {
%>
<p>Messages in Messagebook '${fn:escapeXml(messagebookName)}'.</p>
<%
      // Look at all of our greetings
        for (Message message : messages) {
            pageContext.setAttribute("message_content", message.content);
            String author;
            String meant_for="";
            if (message.author_email == null) {
                author = "An anonymous person";
            } else {
                author = message.author_email;
                String author_id = message.author_id;
                if (user != null && user.getUserId().equals(author_id)) {
                    author += " (You)";
                }
                 meant_for = message.meant_for;
                
            }
            pageContext.setAttribute("message_user", author);
            pageContext.setAttribute("message_meant_for", meant_for); 
%>
<p>For ${fn:escapeXml(message_meant_for)} from <b>${fn:escapeXml(message_user)}</b> wrote:</p>
<blockquote>${fn:escapeXml(message_content)}</blockquote>
<%
        }
    }
%>

<form action="kavachhq" method="post">
    <div>Message <textarea name="content" rows="3" cols="60"></textarea></div><br/>
    <div>Meant for <textarea name="meantfor" rows="1" cols="60"></textarea></div>
    <div><input type="submit" value="Post Message"/></div>
    <input type="hidden" name="messagebookName" value="${fn:escapeXml(messagebookName)}"/>
</form>
<%-- //[END datastore]--%>
<form action="/messagebook.jsp" method="get">
    <div><input type="text" name="messagebookName" value="${fn:escapeXml(messagebookName)}"/></div>
    <div><input type="submit" value="Switch Messagebook"/></div>
</form>

</body>
</html>
<%-- //[END all]--%>
