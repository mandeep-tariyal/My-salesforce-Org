trigger update_batch_account_name on Batch__c (before insert) {
    
    list<String> lt= new list<String>();
    
    for(Batch__c b: Trigger.New)
    {
        lt.add(b.Company_name__c);
        
    }
    
    
    List<Account> acc= new List<Account> ( [ SELECT  name from Account where name in :lt] );
    
    System.debug(acc);
    map<string,id>  m = new map<string,id>();
      
     for(Account ac : acc)
     {
          m.put(ac.name,ac.id);
    
     } 
   
    for(batch__c b: trigger.new)
    {
        if(m.containsKey(b.company_Name__c))
        {
            b.Account__c = m.get(b.company_Name__c);
        }        
    }
    
   
    

}