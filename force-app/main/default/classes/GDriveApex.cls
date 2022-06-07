public class GDriveApex {
    private static String key = '408718039777-3v4shv9d4rc3lmsktib4snsa8lkgp5vs.apps.googleusercontent.com';
    private Static String secert = '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';
    private Static string redirect_uri = 'https://grazittiinteractive-1fb-dev-ed.my.salesforce.com';
        @AuraEnabled
    public static String getAccessToken(String code)
    {
        //Getting access token from google
        system.debug('Acces');
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://accounts.google.com/o/oauth2/token');
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        String messageBody = 'code='+code+'&client_id='+key+'&client_secret='+secert+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);

        Http h = new Http();
        String resp;
        HttpResponse res = h.send(req);
        resp = res.getBody();
         Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(res.getBody()) ;  
          String token =  String.valueOf(responseMap.get('access_token'));
        system.debug('access token >'+token);
         return token;

   }

}