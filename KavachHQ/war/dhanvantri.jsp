<%-- //[START all]--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
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

    <title>KavachHQ- Dhanvantri</title>
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
    <style>
    div.humanHealth {
  	 width:320px; /*width of your image*/
  	 height:726px; /*height of your image*/
 	 background-image:url('img/Human.png');
  	 margin:0; /* If you want no margin */
   	padding:0; /*if your want to padding */
}
    #markerH{ 
    position: relative;
    top:70px;
    left:50px;
    width: 50px;
    height: 50px;
    background: orange;
    border: 1px solid red;
    opacity: 0.7;
    filter: alpha(opacity=70);
    border-radius: 50%;
    behavior: url(PIE.htc);
	}
    
    </style>

</head>

<body>

    <div id="wrapper">
<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
%>   
<%
	String topV="230px";
	String leftV="100px";
	String alertLevel="Safe!!";
	String alertMessage="Person is not at Risk!";

    String injuryCd = request.getParameter("injuryCd");
    if (injuryCd == null) {
    	injuryCd = "Sucess!!";
    }
    
    if(null!=injuryCd&&!injuryCd.trim().equalsIgnoreCase("")){
    	if(injuryCd.equalsIgnoreCase("HEAD")){
    		topV="10px";
    		leftV="130px";	
    		 alertLevel="Critical!!";
    		 alertMessage="Person is at Risk.Evacuate Immediately. Criticality Window :15 Mins";
    	}
    	if(injuryCd.equalsIgnoreCase("NECK")){
    		topV="70px";
    		leftV="130px";	
	   		 alertLevel="Danger!!";
			 alertMessage="Person is at Risk.Evacuate Immediately. Criticality Window :45 Mins";
	}
    	if(injuryCd.equalsIgnoreCase("CHEST")){
    		topV="130px";
    		leftV="130px";	
   			 alertLevel="Elevated Risk!!";
			 alertMessage="Person is at Risk.Evacuate Immediately. Criticality Window :35 Mins";

    	}
    	if(injuryCd.equalsIgnoreCase("HEART")){
    		topV="150px";
    		leftV="160px";	
   		 alertLevel="Super Critical!!";
		 alertMessage="Person is at Risk.Evacuate Immediately. Criticality Window :5 Mins";
		}
    	if(injuryCd.equalsIgnoreCase("CHEST RIGHT")){
    		topV="150px";
    		leftV="120px";	
   		 alertLevel="Critical!!";
		 alertMessage="Person is at Risk.Evacuate Immediately. Criticality Window :15 Mins";

    	}
    	if(injuryCd.equalsIgnoreCase("LEFT HAND")){
    		topV="160px";
    		leftV="200px";	
    		 alertLevel="At Risk!!";
    		 alertMessage="Person is at Risk.Evacuate Soon.Torniquet to Prevent Bleeding. Criticality Window :75 Mins";
	}
    	if(injuryCd.equalsIgnoreCase("RIGHT HAND")){
    		topV="160px";
    		leftV="70px";	
    		 alertLevel="At Risk!!";
    		 alertMessage="Person is at Risk.Evacuate Soon.Torniquet to Prevent Bleeding. Criticality Window :75 Mins";
	 	}
    	if(injuryCd.equalsIgnoreCase("TORSO")){
    		topV="250px";
    		leftV="130px";	
    		 alertLevel="At Risk!!";
    		 alertMessage="Person is at Risk.Evacuate Soon. Criticality Window :75 Mins";
		}
    	if(injuryCd.equalsIgnoreCase("STOMACH")){
    		topV="300px";
    		leftV="130px";	
    		 alertLevel="At Risk!!";
    		 alertMessage="Person is at Risk.Evacuate Soon. Criticality Window :75 Mins";
		}
    	if(injuryCd.equalsIgnoreCase("ABDOMEN")){
    		topV="350px";
    		leftV="130px";	
      		 alertLevel="Critical!!";
    		 alertMessage="Person is at Risk.Evacuate Immediately. Criticality Window :15 Mins";
    	}
    	if(injuryCd.equalsIgnoreCase("LEFT LEG")){
    		topV="430px";
    		leftV="105px";	
   		 alertLevel="At Risk!!";
		 alertMessage="Person is at Risk.Evacuate Soon.Torniquet to Prevent Bleeding. Criticality Window :75 Mins";
	}
    	if(injuryCd.equalsIgnoreCase("RIGHT LEG")){
    		topV="430px";
    		leftV="177px";	
   		 alertLevel="At Risk!!";
		 alertMessage="Person is at Risk.Evacuate Soon.Torniquet to Prevent Bleeding. Criticality Window :75 Mins";
    	}
    	
    	
    }
    
    
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
                            Kavach Dashboard <small> Dhanvantri</small>
                        </h1>
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-dashboard"></i> Dashboard
                            </li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                 <div class="jumbotron">
                    <table>
                    <tr><td style="vertical-align:top">
                    <h1>Risk Level:<%=alertLevel%></h1>
                    <p>The Data was Received from Integrated Kavach System</p>
                    <p>The Injury Code from Body Armor was <%=injuryCd%></p>
                    <p><h2><%=alertMessage%></h2></p>
                    
                    <p><a href="kavachhq/garuda/" class="btn btn-primary btn-lg" role="button">Back to Garuda</a>
                    </p>
                    </td>
                    <td>
                    <div class="humanHealth"><div id="markerH" style="top:<%=topV%>;left:<%=leftV%>;">&nbsp;</div></div>
                    </td>
                    </tr>
                    </table>
   				 </div>
                </div>
                <!-- /.row -->
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
</html>
