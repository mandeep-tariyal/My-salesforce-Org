trigger updateContactsCount on Contact (after insert,after delete,after update) 
{
    set<id> accIds = new set<id>();
    
    if(trigger.isInsert ){
    for(contact con: trigger.new)
     {
        accIds.add(con.accountId);
     }
    }
    
    if(trigger.isDelete || trigger.isUpdate){
    for(contact con: trigger.old)
     {
        accIds.add(con.accountId);
     }
    }
    
    
    list<account> accounts = [select id, name , (select id from contacts) from account where id in:accIds];
    system.debug(accounts);
    system.debug(accIds);
    for(account a: accounts)
    {
        a.number_of_contacts__c = a.Contacts.size();
        system.debug(a.contacts.size());
        system.debug(a.contacts);
    }
    
   
update accounts;
}