<%-- //[START all]--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%-- //[START imports]--%>
<%-- //[END imports]--%>

<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
  <link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCzpWuyrKMvV38dZEjt81rLtq9mw4DlwuA"></script>
  <script type="text/javascript" src="js/gmaps.min.js"></script>
 <script type="text/javascript">
    var map;
    var latitude;
    var longitude;
    $(document).ready(function(){
      var map = new GMaps({
        div: '#map',
        lat: -12.043333,
        lng: -77.028333,
        width: '500px',
        height: '500px'
      });

      GMaps.geolocate({
        success: function(position){
          map.setCenter(position.coords.latitude, position.coords.longitude);
          map.addMarker({
              lat: position.coords.latitude,
              lng: position.coords.longitude,
              title: 'You',
              click: function(e) {
                console.log('You clicked in this marker');
              },
              infoWindow: {
                  content: '<p>You are here!</p>'
                }
        });
          
        },
        error: function(error){
          alert('Geolocation failed: '+error.message);
        },
        not_supported: function(){
          alert("Your browser does not support geolocation");
        },
        always: function(){
          console.log("Done!");
        }
      });
    });
  </script>
</head>

<body>

<%
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
 Test
 <div id="map"></div>
 <%-- //[START datastore]--%>

<form action="kavachhq/aswini/" method="post">
<br/>
 Name of User:<input type="text" name="username" id="username" value=""><br/>
 Latitude:<input type="text" name ="latitude" id="latitude" value=""><br/>
 Longitude:<input type="text" name="longitude" id="longitude" value=""><br/>
 Health Status:<input type="text" name="healthstatus" id="healthstatus" value=""><br/>
    <div><input type="submit" value="Check in!"/></div>
</form>
<%-- //[END datastore]--%>
<script>

function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.watchPosition(showPosition);
    } else {
    	$( "#latitude" ).val("Geolocation not supported");
    	$( "#longitude" ).val("Geolocation not supported");
    }
}
function showPosition(position) {
	slatitude = position.coords.latitude;
	slongitude = position.coords.longitude;
	$( "#latitude" ).val(slatitude);
	$( "#longitude" ).val(slongitude);
}
getLocation();

</script>

</body>
</html>
<%-- //[END all]--%>
