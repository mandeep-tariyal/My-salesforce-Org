@isTest
public class AccountProcessorTest {
	@isTest
    public static void countContactsTest(){
    //load the dummy data for test
		list<account> accounts = new list<account>();
    	for(integer i = 0; i < 300; i++)
        {
            
            accounts.add(new account(Name = 'TestAccount '+i, billingStreet='adas'));
        }
    insert accounts;
    
    //assigning contacts to a account

        List<contact> newContacts = new list<contact>();
        list<id>accountIds = new list<id>();
    for(account acc:accounts)
    {
       newContacts.add( new contact(FirstName = acc.name,Lastname = 'Test Contact',accountId = acc.id )); 
        accountIds.add(acc.id);
    }
insert newContacts;    
    
    //load the test
        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();
        
    //check results
	List<Account> accs = [select id,number_of_contacts__c from account];
        for(account acc:accs)
        {
            System.assertEquals(1, acc.number_of_contacts__c,'Error');
        }

    }
}