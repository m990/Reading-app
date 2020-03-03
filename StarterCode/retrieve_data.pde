// Website that I was coppying: https://www.baeldung.com/java-http-request

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
