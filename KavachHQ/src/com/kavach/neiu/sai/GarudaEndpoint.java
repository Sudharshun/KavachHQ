package com.kavach.neiu.sai;

import java.util.Date;

import org.mortbay.log.Log;

import com.google.api.server.spi.config.Api;
import com.google.api.server.spi.config.ApiMethod;
import com.google.api.server.spi.config.Named;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;

@Api(name="garudaapi",version="v1", description="An API to manage Kavach HealthStatus Info")
public class GarudaEndpoint {

@ApiMethod(name="garudaapi.getcheckins")
 public Container getThing() {
  Container c = new Container();
//Get the Datastore Service
DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
//Use class Query to assemble a query
Query q = new Query("Checkin");

//Use PreparedQuery interface to retrieve results
PreparedQuery pq = datastore.prepare(q);

String response="";
for (Entity result : pq.asIterable()) {
String author_id = (String) result.getProperty("author_id");
String healthstatus = (String) result.getProperty("healthstatus");
String latitude = (String) result.getProperty("latitude");
String longitude = (String) result.getProperty("longitude");
response=response+"["+author_id+","+healthstatus+","+latitude+","+longitude+"]|";
System.out.println("-->"+author_id + "," + healthstatus + "," + latitude +"," + longitude);

}
  c.Text = response;
  return c;
 }
  
@ApiMethod(name = "garudaapi.addcheckin", httpMethod = "post")
public Container putThing(@Named("aid") String authorid, @Named("aemail") String email, @Named("hs") String healthstatus,
@Named("lat") String latitude,@Named("longt") String longitude){
 Container c = new Container();
//Get the Datastore Service
 
 if(null!=healthstatus&&!healthstatus.trim().equalsIgnoreCase("")){
DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
Date dateNow=new Date();
 Entity newCheckin = new Entity("Checkin");
 newCheckin.setProperty("author_id", authorid);
 newCheckin.setProperty("author_email", email);
 newCheckin.setProperty("healthstatus", healthstatus);
 newCheckin.setProperty("latitude", latitude);
 newCheckin.setProperty("longitude", longitude);
 newCheckin.setProperty("date", dateNow);
 datastore.put(newCheckin);
 Key insertedKey = newCheckin.getKey();
 c.Text = "Successfully Inserted:"+insertedKey.getId();
 }
 System.out.println("Insert Successfull");
 
 return c;
}



 public class Container {
  public String Text;
 }
 
}