@isTest
public class DailyLeadProcessorTest {

    // Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
    private static string cron_exp = '0 0 0 ? * * *'; //midnight every day
    @isTest
    private static void testSchedulableClass()
    {
         //load data
    	List<Lead> leads = new List<Lead>();
        for(integer i = 0; i < 500; i++)
        {
            if(i < 250)
            {
                leads.add(new lead(lastName = 'tariyal',company ='Salesforce'));
            }
            else
            {
                leads.add(new lead(lastName = 'tariyal',company ='DreamForce',leadSource='other'));
            }
            
        }
        insert leads;
        
        //Perform the test
   		Test.startTest();
        Id jobId = system.schedule('Process Leads',Cron_exp, new dailyLeadProcessor());
        Test.stopTest();
        
        // check result
    	
        List<Lead> updatedLeads = [select id,LeadSource from lead where leadSource = 'DreamForce'];
        System.assertEquals(200, updatedLeads.size(),'Error');
        
        //check the scheduled time
    
        List<CronTrigger> cts =[select id,TimesTriggered,NextFireTime from CronTrigger where id = :jobId];
        System.debug('Next fire time is ' +cts[0].nextFireTime);
    
    }
   
	
}