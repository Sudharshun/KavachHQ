<%-- //[START all]--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <meta name="description" content="KavachH1">
    <meta name="author" content="Sudharshun Ravichander">

    <title>KavachHQ- Protecting the Protectors</title>
	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
  	<script type="text/javascript" src="js/jquery.min.js"></script>
  	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCzpWuyrKMvV38dZEjt81rLtq9mw4DlwuA"></script>
  	<script type="text/javascript" src="js/gmaps.min.js"></script>
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/sb-admin.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <link href="css/plugins/morris.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

    <div id="wrapper">
<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
%>   
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
                <a class="navbar-brand" href="index.jsp">Kavach HQ</a>
            </div>
            <!-- Top Menu Items -->  <!-- Top Menu Items -->
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
                        <a href="sanjaya.jsp"><i class="fa fa-fw fa-dashboard"></i> Sanjaya</a>
                     </li>
                     <li >
                        <a href="kavachhq/sanjaya/"><i class="fa fa-fw fa-dashboard"></i> Vayu</a>
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
                            Kavach Dashboard <small> Overview</small>
                        </h1>
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-dashboard"></i> Dashboard
                            </li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                 <div class="col-lg-3 col-md-6">
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-crosshairs fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">Sanjaya</div>
                                    </div>
                                </div>
                            </div>
                            <a href="sanjaya.jsp">
                                <div class="panel-footer">
                                    <span class="pull-left">Send Message</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-comments fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">Vayu</div>
                                    </div>
                                </div>
                            </div>
                            <a href="kavachhq/sanjaya/">
                                <div class="panel-footer">
                                    <span class="pull-left">View Messages</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-tasks fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">Aswini</div>
                                    </div>
                                </div>
                            </div>
                            <a href="kavachhq/aswini/">
                                <div class="panel-footer">
                                    <span class="pull-left">Report Status</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-red">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-support fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">Garuda</div>
                                    </div>
                                </div>
                            </div>
                            <a href="kavachhq/garuda/">
                                <div class="panel-footer">
                                    <span class="pull-left">Situation Report</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
				<!-- Map Area -->
    <!-- /.row -->
				<div class="row">
               <!-- Panel Heading -->	
				 <div style="width:100%;">
                        <div class="panel panel-default">
						<!-- Panel Heading -->
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-money fa-fw"></i>Garuda View</h3>
                            </div>
						<!-- Panel Heading -->
                            <div class="panel-body">
							        <!-- Panel Content -->
                                		 <div id="map"></div>
                               		<!-- Panel Content -->
									<!-- Panel Content -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->

				<!-- Map Area -->
            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->
 <%}else{%>
   <div id="page-wrapper">
   <br>
   <br>
   
   <div class="jumbotron">
                    <h1>Hello,!</h1>
                    <p>This tool is meant as the Final year Project for Sudharshun Ravichander- Masters Seeking Student at North Eastern Illinois Univesity 
					This is the Login Screen for Unauthorized Users to Sign in. Well, I hate to do this to you,But I would miss a few points If I didnt have a sign in page & besides..The Project is to Provide a Monitoring Dashboard..So you get the idea.. .</p>
                    <p><a href="<%= userService.createLoginURL(request.getRequestURI()) %>" class="btn btn-primary btn-lg" role="button">Sign in »</a>
                    </p>
   </div>
   
 
   </div>
  <%} %>
    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="js/plugins/morris/raphael.min.js"></script>
    <script src="js/plugins/morris/morris.min.js"></script>
    <script src="js/plugins/morris/morris-data.js"></script>

</body>
<script>
map = new GMaps({
    div: '#map',
    lat: 42.0441447,
    lng: -87.8533265,
    width: '100%',
    height: '400px'
  });
<%-- //[START datastore]--%>
		<%
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		//Use class Query to assemble a query
		Query q = new Query("Checkin");
		
		//Use PreparedQuery interface to retrieve results
		PreparedQuery pq = datastore.prepare(q);
			for (Entity result : pq.asIterable()) {
			String author_id = (String) result.getProperty("author_id");
			String healthstatus = (String) result.getProperty("healthstatus");
			String latitude = (String) result.getProperty("latitude");
			String longitude = (String) result.getProperty("longitude");
			System.out.println("-->"+author_id + "," + healthstatus + "," + latitude +"," + longitude);
			%>
			
			map.addMarker({
				  lat: <%=latitude%>,
				  lng: <%=longitude%>,
				  title: '<%=author_id%>',
				  click: function(e) {
				    alert('This is <%=author_id%>');
				  },
				  infoWindow: {
					  content: '<p><%=author_id%></p>'
				  }
				});
			<%
			}
			%>


<%-- //[END datastore]--%>


</script>
</html>
