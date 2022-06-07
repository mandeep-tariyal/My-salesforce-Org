public class CloneRecordsByRest {

  public class deserializeResponse {
    public String id;        
    public String access_token;        
    }
  
   
    public static String getAccessToken()
    {
      
      String password = 'Bohemia123#wBxinjol7acw879MwqrY8MbRY';
      String username = 'mandeep_test@grazitti.com';
      String client_secret = '2525983C8DE4B77AD69F0B043F1DB91012116ABDF0ADB43EFEBC1C3CC82B320A';
      String client_id = '3MVG9pRzvMkjMb6no177_.4gkAHVOGwrRrDe.3jen.HQuKAOn2zZW1K.mKcdKyEZq..parS3y3LrlPZ1sU7Pw';
      

      HttpRequest req  = new HttpRequest();
      HttpResponse res = new HttpResponse();
      http http = new http();
      req.setEndpoint('https://graxitti2-dev-ed.my.salesforce.com/services/oauth2/token?grant_type=authorization_code'+'&client_id='+client_Id +'&client_secret='+client_secret +'&username='+userName +'&password='+password );
      req.setMethod('POST');
      req.setHeader('Content-Type', 'application/json');
      req.setHeader('Accept','application/json');
      //String body = 'grant_type=authorization_code' + '&client_id='+client_Id + '&client_secret=' +client_Secret +'&username='+userName + '&password='+password;
      //"/services/oauth2/token?grant_type=authorization_code"+"&client_id=" + CLIENTID + "&client_secret=" + CLIENTSECRET +
      String body = '';

     
      req.setBody(body);
      req.setCompressed(true); // otherwise we hit a limit of 32000
      
      
      try {
            res = http.send(req);
          } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
          }

      //req.setTimeout(60000);
    
    //getting acces token
      
    HttpResponse res1 = http.send(req);
  
    System.debug('Body ' + res1.getBody());
    System.debug('Status ' + res1.getStatus());
    System.debug('Status code ' + res1.getStatusCode());
    deserializeResponse resp1=(deserializeResponse)JSON.deserialize(res.getBody(),deserializeResponse.class);    
    System.debug(resp1+'By-AP-deserializeresponse');
    return resp1.access_token;
  }




    //-------->
    @future(Callout = true)
    public static void cloneData(String name, String billingCity){

    }
}