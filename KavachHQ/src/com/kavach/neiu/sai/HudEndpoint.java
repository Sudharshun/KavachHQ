package com.kavach.neiu.sai;

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

@Api(name="hudapi",version="v1", description="An API to manage HUD Messages Info")
public class HudEndpoint {

@ApiMethod(name="hudapi.getmessages")
 public Container getHUDThing() {
	 Container c = new Container();
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		//Use class Query to assemble a query
		Query q = new Query("Message");
		
		//Use PreparedQuery interface to retrieve results
		PreparedQuery pq = datastore.prepare(q);

		String response="Result-";
		for (Entity result : pq.asIterable()) {
			String author_id = (String) result.getProperty("author_id");
			String content = (String) result.getProperty("content");
			String meantfor = (String) result.getProperty("meant_for");
			response=response+"["+author_id+":"+author_id+",content:"+content+",meantfor:"+meantfor+"],";
		}
	  System.out.println("-->"+response);
	  c.Text =response;
	 return c;
 }
  
@ApiMethod(name = "hudapi.addmessage", httpMethod = "post")
public Container putHUDThing(@Named("aid") String authorid, @Named("content") String content, @Named("meantfor") String meantfor){
 Container c = new Container();
//Get the Datastore Service
DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

 Entity newMessage = new Entity("Message");
 newMessage.setProperty("author_id", authorid);
 newMessage.setProperty("content", content);
 newMessage.setProperty("meant_for", meantfor);
 datastore.put(newMessage);
 Key insertedKey = newMessage.getKey();
 c.Text = "Successfully Inserted Message:"+insertedKey.getId();
 System.out.println("Insert Successfull");
 return c;
}





 public class Container {
  public String Text;
 }
 
}