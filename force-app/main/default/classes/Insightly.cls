public  class Insightly {
   
  //Method to get the populate Header For Authorization
  public static HttpRequest getAuthorizationHeaderObj()
  {
    HttpRequest req = new HttpRequest();
    req.setEndpoint('https://api.na1.insightly.com/v3.1/contacts');
    
    Blob secret = Blob.valueOf('0cafc39c-d18c-4569-aedb-7a97f642481e');
    String AuthorizationHeader = 'Basic ' + EncodingUtil.Base64Encode(secret);
    System.debug('AuthorizationHeader'+AuthorizationHeader);
    req.setHeader('Authorization',AuthorizationHeader);
    req.setHeader('Content-Type', 'application/json');
    return req;
  }
  //Adding New Contact
  @future(Callout =  true)
    public static void createContact(String name) {
    
      try{   
      http https = new http();
      HttpRequest req = getAuthorizationHeaderObj();
      req.setMethod('POST');
      Map<String,Object> obj = new Map<String,Object>();
      obj.put('FIRST_NAME',name);
      req.setBody(JSON.serialize(obj));
     
     //sent Request
      HttpResponse res1 = https.send(req);
      //Checking Response
      System.debug('Response'+res1.getBody());
      System.debug('Response'+res1.getStatus());
      System.debug('Response'+res1.toString());
      
      
       
      } catch(System.CalloutException e) {
        System.debug('Callout error: '+ e);
        //System.debug(res.toString());
      }
      

    }


    //Getting All Contacts 

    @future(Callout = true)
    public static void getContacts()
    {  
      try{
      HttpRequest req = getAuthorizationHeaderObj();
      req.setMethod('GET');
      req.setHeader('Accept','Application/Json');
      http https = new http();
      HttpResponse response = https.send(req);
      System.debug('Response body' + Response.getBody());

      //Parsing  Json
      List<Object> lst_JsonParse = (List<Object>)Json.deserializeUntyped(Response.getBody());
      //Map for Contact id to contact Name
      Map<Integer,String>  IdToNameOfContacts = new Map<Integer,string>();
      for(Object obj : lst_JsonParse)
      {
           Map<String,Object> mp_StrObj = (Map<string,Object>)obj;           
           IdToNameOfContacts.put(Integer.valueOf(mp_StrObj.get('CONTACT_ID')) ,String.valueOf( mp_StrObj.get('FIRST_NAME')) );
      }
      System.debug('IdToNameOfContacts' +IdToNameOfContacts);
      }
      catch(CalloutException e)
      {
        System.debug('Callout Exception' +e);
      }
      
      
    
    }

    // get particular account
    @future(Callout = true)
    public static void getContactById(Integer id)
    { 
      try{
      HttpRequest req = getAuthorizationHeaderObj();
      req.setMethod('GET');
      req.setEndpoint('https://api.na1.insightly.com/v3.1/contacts/'+id);
        
      req.setHeader('Accept','Application/Json');
      http https = new http();
      HttpResponse response = https.send(req);
      System.debug('Response body' + Response.getBody());
  
        //Parsing Response
       Map<String,Object> lst_JsonParse = (Map<String,Object>)Json.deserializeUntyped(Response.getBody());
       System.debug('lst_JsonParse'+lst_JsonParse);
       system.debug(lst_JsonParse.get('FIRST_NAME'));

      } 
      catch(CalloutException e)
      {
        System.debug('CallOutException' +e);
      }

    
    

    }
    
   
}