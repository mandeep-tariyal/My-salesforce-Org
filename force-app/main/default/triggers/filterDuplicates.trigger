trigger filterDuplicates on Account (before insert,after update)
 {
     list<string> accList = new list<string>();
     for(Account acc: trigger.new)
     {
         accList.add(acc.name);
         
     }
     System.debug('accList' +accList);
     
     map<string,Account> accountMap = new map<string ,Account>();
     for(Account n: [Select name  from account where Name in:accList])
     {
     accountMap.put(n.Name,n);
     }
    System.debug('map' +accountMap); 
    list<account> dummyacc =  [Select name from account];
     
     System.debug('pehle se ye account hai'+dummyacc);
    for(account ac: trigger.new)
    {
        if(accountMap.containsKey(ac.Name))
        {
            ac.addError('Error : Duplicate Account found');
        }
    }
}