public without sharing class LeadProcessor implements Database.Batchable<sObject> {
    public database.QueryLocator start(Database.BatchableContext abc)
    {
     	return database.getQueryLocator([ select id,name from lead]);   
    }
    
    public void execute(Database.BatchableContext bc, list<lead> leads)
    {
        for(lead ld:leads)
        {
            ld.leadSource = 'DreamForce';
        }
        update leads;
    }
    
    public void finish(Database.BatchableContext c)
    {
        System.debug('done!!');
    }

}