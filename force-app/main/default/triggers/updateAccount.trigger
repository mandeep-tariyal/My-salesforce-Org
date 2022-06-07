trigger updateAccount on Batch__c (before insert) 
{
    set<String> companyNames = new set<String>();
    
    for(Batch__c bt:trigger.new)
    {
        companyNames.add(bt.Company_name__c);                    
    } 
    
    list<Account> listOfAccountDetails = new list<Account>([select name from account where name in :companyNames]);
    string accountName = listOfAccountDetails[0].name;
    
    for(batch__c b: trigger.new )
    {
        if(b.Company_name__c == accountName)
        {
            b.account__c = listOfAccountDetails[0].id;
        }
        else
        {
            b.name = 'error';
        }
    }

}