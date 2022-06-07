public class AccountProcessor {
    @future 
    public static void countContacts(list<id> accountIds)
    {
        list<account> accounts = [select id,(select id from contacts) from account where id in:accountIds];
		for(account ac:accounts)
        {
            ac.number_of_contacts__c = ac.contacts.size();
        }
        update accounts;
	}
}