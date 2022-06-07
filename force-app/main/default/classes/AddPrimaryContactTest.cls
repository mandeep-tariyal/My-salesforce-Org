@isTest
public class AddPrimaryContactTest {

    @isTest
    private static void testQueueableClass()
    {
    list<Account> accounts = new list<Account>();
    for(integer i = 0; i < 500; i++)
    {
        Account acc = new account(Name = 'Test Account');
        if(i<250)
        {
        	  acc.BillingState = 'NY';
        }
        else
        {
            acc.BillingState = 'CA';
        }
        accounts.add(acc);
    }
    insert accounts;
    
    
    Contact contact = new Contact(FirstName = 'Simon', LastName ='Canock');
    insert contact;
    
    //run the test
    Test.startTest();
    Id jobId = System.enqueueJob(new AddPrimaryContact(contact,'CA'));
    Test.stopTest();
        
        //Check result
    List<contact> contacts = [select id from contact where Contact.Account.billingState = 'CA'];
    System.assertEquals(200, contacts.size(),'error');
    
    }
}