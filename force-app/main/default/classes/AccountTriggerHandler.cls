public class AccountTriggerHandler implements ITriggerHandler{   
   // public static Boolean TriggerDisabled = false; 
   // public Boolean IsDisabled(){
        
     //   return TriggerDisabled;
    //}
    ///Logic for account duplicacy
    public void BeforeInsert(List<SObject> newItems){
       
     list<string> accList = new list<string>();
     for(Account acc:(list<account>)newItems)
     {
         accList.add(acc.name);
         
     }
     System.debug('accList' +accList);
     
     map<String,Account> accountMap = new map<String,Account>();
     for(Account n: [Select id,name  from account where name  in: accList ])
     {
     accountMap.put(n.Name,n);
     }
  	System.debug('map' +accountMap); 
    list<account> dummyacc =  [Select name from account];
     
     System.debug('pehle se ye account hai'+dummyacc);
    for(account ac: (list<account>)newItems)
     {
        if(accountMap.containsKey(ac.Name))
        {
            ac.addError('Error : Duplicate Account found Through Trigger Factory');
        }
     }
    }
    

    
    public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
     Set<String> names = getNamesFromNewMap(newItems);
        System.debug('before Update Executing');
        Map<string,account> accountsToCheck = new Map<string,account>();
        for(account acc: [select name from account where name in : names])
        {
            accountsToCheck.put(acc.name,acc);
            
        }
        System.debug('AccountsToCheck Map' +accountsToCheck);
        Set<String> NewNames = getNamesFromNewMap(newItems);
        System.debug('NewSEt toUpdate'+newNames);
        
        for(account acc:(List<Account>)newItems.values())
        {
            System.debug('Iteration' +acc);
            if(accountsToCheck.containsKey(acc.name))
            {
              
                acc.addError('Updation not Allowed');
                System.debug('Updation Failed');
            }
        }
        
       
    }
    public void BeforeDelete(Map<Id, SObject> oldItems) {}
    public void AfterInsert(Map<Id, SObject> newItems) {}
    
    
    public void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
          
       
    } 
    public void AfterDelete(Map<Id, SObject> oldItems) {}
    public void AfterUndelete(Map<Id, SObject> oldItems) {}
    
    
        //Helper method for Update operations
    public set<String> getNamesFromNewMap(Map<Id,sObject> newItems)
    {
        list<account> NewAccountNames = new list<account>();
        for(id key : newItems.keySet())
        {
            newAccountNames.add((account)newItems.get(key) );
            System.debug('List of Acount'+newAccountNames);
        }
        
        Set<String> accNames = new Set<String>();
        for(account ac:newAccountNames)
        {
            accNames.add(ac.Name);
        } 
        return accNames;
    }
}