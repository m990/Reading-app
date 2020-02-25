// Website that I was coppying: https://www.baeldung.com/java-http-request

import java.net.*;
import java.util.*;
import java.io.*;
import java.lang.*;

public class RetrieveData {
  void getData(){
    try{
      URL url = new URL("http://localhost:8080/h2-console");
      HttpURLConnection con = (HttpURLConnection) url.openConnection();
      con.setRequestMethod("GET");
      
      Map<String, String> parameters = new HashMap<>();
      parameters.put("param1", "val");
       
      con.setDoOutput(true);
      DataOutputStream out = new DataOutputStream(con.getOutputStream());
      out.writeBytes(ParameterStringBuilder.getParamsString(parameters));
      out.flush();
      out.close();
    }
    catch(Exception e){
      println(e);
    }
  }
}

public class ParameterStringBuilder {
    public static String getParamsString(Map<String, String> params) 
      throws UnsupportedEncodingException{
        StringBuilder result = new StringBuilder();
 
        for (Map.Entry<String, String> entry : params.entrySet()) {
          result.append(URLEncoder.encode(entry.getKey(), "UTF-8"));
          result.append("=");
          result.append(URLEncoder.encode(entry.getValue(), "UTF-8"));
          result.append("&");
        }
 
        String resultString = result.toString();
        return resultString.length() > 0
          ? resultString.substring(0, resultString.length() - 1)
          : resultString;
    }
}
