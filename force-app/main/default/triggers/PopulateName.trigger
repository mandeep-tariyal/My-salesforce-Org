trigger PopulateName on Opportunity (before insert,before update) {
   
    Set<Id> OppoIds = new Set<Id>();
    list<Id> AccountIds = new List<Id>();
    for(opportunity op : trigger.new)
    {
        OppoIds.add(op.id);
        AccountIds.add(op.AccountId);
    }
    
    Map<opportunity,id> opportunityToAccountMap = new Map<opportunity,id>();
    for(opportunity o : trigger.new)
    {
        opportunityToAccountMap.put(o, o.accountId);
    }
    
    Map<id,string> AccountIdToNameMap = new Map<id,String>();
    for(Account ac :  [select name from account where id in : AccountIds])
    {
        
        accountIdToNameMap.put(ac.id,ac.name);
    }
    
    for(opportunity op : trigger.new)
    {
        if(AccountIdToNameMap.containsKey(op.AccountId))
        {
            op.Name = accountIdToNameMap.get(op.AccountId)+'-'+op.type+'-'+op.rrr__c;
        }
    }
    
    

}