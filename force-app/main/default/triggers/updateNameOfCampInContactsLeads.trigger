trigger updateNameOfCampInContactsLeads on CampaignMember (after insert) {
    public set<Id> getCampaignIdsFromContacts(List<Contact> contacts){
        Set<id> ids=new Set<id>();
        for(contact c:contacts){
            for(campaignmember cm:c.campaignMembers){
                ids.add(cm.CampaignId);
            }
        }
        return ids;
    }
    //set for Contact ids in campaign Member 
    set<id> contactIds = new set<id>();
    set<id> leadIds = new set<id>();
    set<id> campaignIds = new set<id>();
    for(CampaignMember campMe : trigger.new)
    {
       
        contactIds.add(CampMe.contactId);
        leadIds.add(campMe.leadId);
        campaignIds.add(campMe.CampaignId);
    }
    
   // system.debug(contactIds+'contact');
    //system.debug(leadIds+'lead');
    
    list<campaignMember> campMembers = [select contactId,leadId,campaignId from campaignMember where campaignId in:campaignIds ];
    system.debug(contactIds+'campaignMembers');
    list<contact> contactsToUpdate = [select id,name,(select campaignId from campaignMembers) from contact
                                      where id in : contactIds ];
   // system.debug(contactsToUpdate[0]+'contactsToUpdate');
    

    map<id,campaign> idToCampaignMap = new map<id,campaign>( [select id,name from campaign where Id in: getCampaignIds(contactsToUpdate)]);
    System.debug('idToCampaignMap'+idToCampaignMap.values());
    
  
        public static set<id> getCampaignIds(list<contact> contacts)
        {
            set<id> campaignIds = new set<id>();
			for(contact cc: contacts)
            {
                
                for(campaignMember cm: cc.campaignMembers)
                {
                    campaignIds.add(cm.campaignId);
                }
            }
            system.debug(campaignIds+'campaignIds');
            return campaignIds;
        }
    map<id,list<campaign>> contactIdToCampaignMap = new map<id,list<campaign>>();
   
    for(campaignMember cm : campMembers)
    {
        //Campaign recieved
        System.debug(cm.campaignId+' is Id of  '+idToCampaignMap.get(cm.campaignId));
       
        if(contactIdToCampaignMap.containsKey(cm.contactid))
        {  
            contactIdToCampaignMap.get(cm.contactId).add(idToCampaignMap.get(cm.campaignId));
        }
        else
        {
             list<campaign> camp = new list<campaign>();
            camp.add(idToCampaignMap.get(cm.campaignId));
            System.debug(camp+'campaignssss');
        	contactIdToCampaignMap.put(cm.ContactId,camp);
        }
    }
    System.debug(contactIdToCampaignMap+'ContactidToCampaignMap');
    
    for(contact c: contactsToUpdate)
    {
      
        if(contactIdToCampaignMap.containsKey(c.id))
        {
            
            set<string> names = new set<string>();
            for(campaign camp: contactIdToCampaignMap.get(c.Id))
            {
               names.add(camp.Name);
            }
            names.remove(null);
            
            c.name_of_campaigns__c = String.join(new List<String>(names),',');
            System.debug('getnames'+ String.join(new List<String>(names),','));
        	
        }
        
    }
    
    //getNamesfrom List of Names

	public static String getNamesFromList(list<string> names)
    {
        string s = '';
        for(string str : names)
        {
            if(str!=null)
            {
                s=str+',';
            }
        }
        System.debug(s);
        return s;
    }
    if(contactsToUpdate.size()>0)
    {
    update contactsToUpdate;
    }
    
}