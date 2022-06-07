public with sharing class  getCase { 
    @InvocableMethod(label='Get Case Desc' description='Returns the Desc of case' category='Case')
    public static List<case> getCaseDesc(List<String> Nums)
        
        

    {
         List<Case> Cases =  [select id,Account.name,contact__c,description from case where CaseNumber in :Nums WITH SECURITY_ENFORCED];
       	SObjectAccessDecision decision = Security.stripInaccessible(
	                                   AccessType.READABLE,
	                                   Cases);
        
        System.debug('Cases'+decision.getRecords());
              List<String> descriptions = new List<String>();
        for(Case cs : Cases)
              {
                 descriptions.add(cs.account.name);
              }
        System.debug('Desc>'+Cases[0].description);
         return cases;
    }
    

}