public without sharing class DailyLeadProcessor implements schedulable {
    
    public  void execute(SchedulableContext sc)
    {
        // get leads without leadSource
        List<Lead> leads = [select id,LeadSource from lead where LeadSource = null limit 200];
        
        //update leadsoure
        for(Lead l : leads)
        {
            l.leadSource = 'DreamForce';
        }
        update leads;
    }
    

}