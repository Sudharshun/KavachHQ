<%-- //[START all]--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%-- //[START imports]--%>
<%-- //[START imports]--%>
<%@ page import="com.kavach.neiu.sai.Logbook" %>
<%@ page import="com.kavach.neiu.sai.Checkin" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%-- //[END imports]--%>

<%-- //[END imports]--%>

<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="en">
<head>
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

   <title>KavachHQ- Protecting the Protectors</title>
  <link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCzpWuyrKMvV38dZEjt81rLtq9mw4DlwuA"></script>
  <script type="text/javascript" src="js/gmaps.min.js"></script>
  
  <!-- Theme -->
   <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/sb-admin.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  
  
  <!-- Theme end -->
  
  
 <script type="text/javascript">
    var map;
    var latitude;
    var longitude;
    $(document).ready(function(){
      var map = new GMaps({
        div: '#map',
        lat: -12.043333,
        lng: -77.028333,
        width: '300px',
        height: '300px'
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
%>   
<!-- Begin of Body Content -->
 <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.jsp">KavachHQ</a>
            </div>
            <!-- Top Menu Items -->
            <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <% 
  										  if (user != null) {
     									%>
                                            <strong><%=user.getNickname()%></strong>
                                        <%}else{ %>
                                        	<strong>Not Authorized</strong>
                                        <%} %><b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="#"><i class="fa fa-fw fa-user"></i> Profile</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-fw fa-gear"></i> Settings</a>
                        </li>
                        <li class="divider"></li>
                         <% if (user != null) {
     						%>
							 <li>
                            <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                        </li>
                        <%}%>
                    </ul>
                </li>
            </ul>
            <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                   <% if (user != null) {
     						%>
                    <li class="active">
                        <a href="index.jsp"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                    </li>
                    <li>
                        <a href="kavachhq"><i class="fa fa-fw fa-dashboard"></i> KavachHQ</a>
                    </li>
                      <li>
                        <a href="kavachhq/aswini/"><i class="fa fa-fw fa-dashboard"></i> Aswini</a>
                    </li>
                      <li >
                        <a href="kavachhq/garuda/"><i class="fa fa-fw fa-dashboard"></i> Garuda</a>
                    </li>
                    <%}
				%>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </nav>
  <% if (user != null) {
     						%>
        <div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Garuda
                            <small>Situational Awareness/Insights</small>
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="index.html">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-file"></i> Garuda
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
				<div class="row">
                    <div class="col-lg-4">
                        <div class="panel panel-default">
						<!-- Panel Heading -->
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-long-arrow-right fa-fw"></i>Garuda Insight</h3>
                            </div>
						<!-- Panel Heading -->
                            <div class="panel-body">
								<!-- Panel Content -->
                                 <div id="map"></div>
                               <!-- Panel Content -->
                            </div>
                        </div>
                    </div>
				<!-- Panel Heading -->	
				 <div class="col-lg-8">
                        <div class="panel panel-default">
						<!-- Panel Heading -->
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-money fa-fw"></i>Garuda View</h3>
                            </div>
						<!-- Panel Heading -->
                            <div class="panel-body">
								<!-- Panel Content -->
								 <%-- //[START datastore]--%>
									<%
  
											DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
											//Use class Query to assemble a query
											Query q = new Query("Checkin");
											
											//Use PreparedQuery interface to retrieve results
											PreparedQuery pq = datastore.prepare(q);
									%>
									
									
								<%-- //[END datastore]--%>
								
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th>Cop</th>
                                                <th>Latitude</th>
                                                <th>Longitude</th>
                                                <th>Health Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <!-- Table Content -->
                                        <% 		
											for (Entity result : pq.asIterable()) {
											String author_id = (String) result.getProperty("author_id");
											String healthstatus = (String) result.getProperty("healthstatus");
											String latitude = (String) result.getProperty("latitude");
											String longitude = (String) result.getProperty("longitude");
											System.out.println("-->"+author_id + "," + healthstatus + "," + latitude +"," + longitude);
											%>
											  <tr>
                                                <td><%=author_id %></td>
                                                <td><%=latitude %></td>
                                                <td><%=longitude %></td>
                                                <td><%=healthstatus%></td>
                                            </tr>
											<%
											}
											%>
                                         <!-- Table Content -->  
                                        </tbody>
                                    </table>
									<!-- Panel Content -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->
  <%}else{%>
   <div id="page-wrapper">
  <p>Hello!
    <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
    to Continue</p>
   </div>
  <%} %>
  
    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
<!-- End of Body Content -->    
 
</body>
</html>
<%-- //[END all]--%>
