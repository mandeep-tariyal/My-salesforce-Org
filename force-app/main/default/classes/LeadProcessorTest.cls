@isTest
public class LeadProcessorTest {

    @isTest
    public static void batchTestClass()
    {
        //load test data
   		list<lead> leads = new list<lead>();
        for(integer i = 0; i < 200; i++)
        {
            leads.add(new lead(lastName = 'Connok', company = 'Salesforce'));
        }
        insert leads;
    
    
    //execute test
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = database.executeBatch(lp,200);
        Test.stopTest();
        
        
    //check Result
        List<lead> updatedLeads = [select id from lead where LeadSource ='Dreamforce' ];
        System.assertEquals(200, updatedLeads.size(),'error');
    }
    
}