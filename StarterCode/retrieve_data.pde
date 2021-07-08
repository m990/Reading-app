// Website that I was coppying: https://www.baeldung.com/java-http-request

// Dummy data to put into the h2-console: 

//INSERT INTO BOOK VALUES(0, 'Eric Park', 2020, 'The story of a promising man who left his friends for volley ball.', 'image_The Life and Tragedy of Eli William Browne.png', 1, 'The Life and Tragedy of Eli William Browne');
//INSERT INTO BOOK VALUES(1, 'Max J. Norman', 2020, 'The life of the greatest drummer, author, and motorcyclist to ever have lived.', 'image_The Best Drummer.png', 2, 'The Best Drummer');
//INSERT INTO BOOK VALUES(2, 'Max J. Norman', 2020, 'Moving pictures.', 'image_The Making of Moving Pictures.png', 1, 'Moving Pictures');

//INSERT INTO PAGE VALUES (0, '', 'best_drummer_page_1.png', 1, 'Neil Peart was the drummer in Rush', 1);
//INSERT INTO PAGE VALUES (1, '', 'best_drummer_page_1.png', 1, 'Neil was the best drummer in the world, but he hated his job.', 1);

import java.net.*;
import java.util.*;
import java.io.*;
import java.lang.*;

class RetrieveData {

  String retrieveData(String address) throws Exception {
    String response = "";
    URL url = new URL(address);
    HttpURLConnection con = (HttpURLConnection) url.openConnection();
    con.setRequestMethod("GET");
    con.setDoOutput(true);
    Reader streamReader = null;
    if (con.getResponseCode() > 299) {  
      streamReader = new InputStreamReader(con.getErrorStream());
    } else {
      streamReader = new InputStreamReader(con.getInputStream());
    }
    BufferedReader in = new BufferedReader(streamReader);
    String inputLine;

    while ((inputLine = in.readLine()) != null) {
      response+=inputLine+"\n";
    }

    return response;
  }
}
