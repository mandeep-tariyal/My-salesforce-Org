public class PopulateNameHandler implements IPopulateTriggerHandler {

    public static Integer getMaxNumber(List<Integer> samplevalues){
        Integer maxvalue = samplevalues[0];
        For (integer i =0;i<samplevalues.size();i++)
        {
            
            if( samplevalues[i] > maxvalue)
                maxvalue = samplevalues[i];             
        }
        return maxvalue;    
    }
    
    public static  Map<String,Integer> getCounterValue(Map<Id,Account> accounts )
    {
        Map<Id,Map<String,List<Opportunity>> > accIdToUniqueOpprtunities = getAccIdToUniqueOpprtunities(accounts.values());

        Map<String,List<Integer>> keyToCounterMap = new Map<String,List<Integer>>();


        for(Account a:accounts.values()){
            //List<Integer> suffix=new List<Integer>();
            for(Opportunity op : a.Opportunities){
                String key = accounts.get(op.AccountId).Name+'_'+op.Type+'_'+op.rrr__c;
                if(keyToCounterMap.containsKey(key)){
                    
                keyToCounterMap.get(op.name.substringBeforeLast('_')).add(Integer.valueOf(op.name.substringAfterLast('_')) );                
            }
            else{
                    List<Integer> l=new List<Integer>{1};
                    keyToCounterMap.put(op.name.substringBeforeLast('_'),l);
                }   
                
                
            }
            System.debug('KeyToCounterMap '+keyToCounterMap);
     		}

             Map<String,integer> max = new Map<String,Integer>();

             for(String key:keyToCounterMap.keySet()){
                max.put(key,getMaxNumber(keyToCounterMap.get(key)));
             }
             System.debug('max '+max);
            System.debug('accIdToUniqueOpp ' + accIdToUniqueOpprtunities);

    return max;
           
    }
    
    
   //Getting Unique Opportunities
    public static Map<Id,Map<String,List<Opportunity>>> getAccIdToUniqueOpprtunities(List<Account> accounts){
        Map<Id,Map<String,List<Opportunity>> > accIdToUniqueOpprtunities = new Map<Id,Map<String,List<Opportunity>>>();
        
        for(Account a : accounts){
            for(Opportunity o:a.Opportunities){
                if(accIdToUniqueOpprtunities.containsKey(a.Id)){
                String key = a.Name+'_'+o.Type+'_'+o.rrr__c;
                    	 if(accIdToUniqueOpprtunities.containskey(o.AccountId) && accIdToUniqueOpprtunities.get(o.AccountId).containskey(key)){
                       	 accIdToUniqueOpprtunities.get(a.Id).get(key).add(o);
                   	 }
                   	 else{
                        	accIdToUniqueOpprtunities.get(a.Id).put(key,new List<Opportunity>{o});
                    	}
            		}
                
                
                else{
                   accIdToUniqueOpprtunities.put(a.Id, new Map<String,List<Opportunity>>()); 
                }
            }                       
        }
        return accIdToUniqueOpprtunities;
    }
    
    public static void onBeforeInsert(list<Opportunity> triggerValues)
    {
       
         Set<Id> accountIds = new Set<Id>();
        for(Opportunity o : (list<opportunity>)triggerValues)
        	{
            accountIds.add(o.AccountId);
        }
        
        Map<Id,Account> accounts = new Map<Id,account>( [SELECT Id,Name, (SELECT Id,Name,Type,rrr__c,accountID FROM Opportunities) FROM Account Where ID in :accountIds]);

        Map<String,Integer> StringToCounterMap = getCounterValue(accounts);
        
        for(Opportunity o : (list<opportunity>) TriggerValues){
            String key = accounts.get(o.AccountId).Name+'_'+o.Type+'_'+o.rrr__c;
         
                 if(StringToCounterMap.containskey(Key) )
                	{
						o.Name=key+'_'+(StringToCounterMap.get(Key) +1);              
            		}
                else {
                    o.Name=key+'_'+1;
                }        
                
        }
 
    }
    

    
    
    public static void onBeforeDelete(Map<id,sObject> oldOppsMap,Map<id,sObject> newOppsMap){
        Map<id,Opportunity> oldOppsMapp = (Map<id,Opportunity>) oldOppsMap;
        
        Set<Id> accountIds =new Set<Id>();
        for(Opportunity o:oldOppsMapp.values()){
            accountIds.add(o.AccountId);
        }
        System.debug('OnBefore delete');
        
        Map<Id,Account> accounts = new Map<Id,account>( [SELECT Id,Name, (SELECT Id,Type,rrr__c,accountID FROM Opportunities) FROM Account Where ID in :accountIds]);
         
        Map<Id,Map<String,List<Opportunity>> > accIdToUniqueOpprtunities =getAccIdToUniqueOpprtunities(accounts.values());
        List<Opportunity> oppToUpdate =  new List<Opportunity>();
        for(Id id : accIdToUniqueOpprtunities.keyset()){
            Map<String,List<Opportunity>> nameToOpps = accIdToUniqueOpprtunities.get(id);
            for(String key :nameToOpps.keyset()){
                Integer size = (nameToOpps.get(key) == null)?0:nameToOpps.get(key).size();
                for(Integer i = 0;i<size;i++){
                    Opportunity op = nameToOpps.get(key).get(i);
                    System.debug('opportunity deleted get i value' +op);
                    if(oldOppsMapp.get(op.Id) != null){
                        op.Name = key+'_'+(i-1);                    
                    	oppToUpdate.add(op);
                    }
                    
                }
            }
        }
        
        update oppToUpdate;
    }
       /* 
        public static void helperMethod(Map<id,sObject> oldOppsMap,Map<id,sObject> newOppsMap)
        {
               Map<id,Opportunity> oldOppsMapp = (Map<id,Opportunity>) oldOppsMap;
        
        Set<Id> accountIds =new Set<Id>();
        for(Opportunity o:oldOppsMapp.values()){
            accountIds.add(o.AccountId);
        }
        System.debug('OnBefore delete');
        
        Map<Id,Account> accounts = new Map<Id,account>( [SELECT Id,Name, (SELECT Id,Type,rrr__c FROM Opportunities) FROM Account Where ID in :accountIds]);
         
        Map<Id,Map<String,List<Opportunity>> > accIdToUniqueOpprtunities =getAccIdToUniqueOpprtunities(accounts.values());
        List<Opportunity> oppToUpdate =  new List<Opportunity>();
        for(Id id : accIdToUniqueOpprtunities.keyset()){
            Map<String,List<Opportunity>> nameToOpps = accIdToUniqueOpprtunities.get(id);
            for(String key :nameToOpps.keyset()){
                Integer size = (nameToOpps.get(key) == null)?0:nameToOpps.get(key).size();
                for(Integer i = 0;i<size;i++){
                    Opportunity op = nameToOpps.get(key).get(i);
                    System.debug('opportunity deleted get i value' +op);
                    if(oldOppsMapp.get(op.Id) != null){
                        op.Name = key+'_'+(i+1);                    
                    	oppToUpdate.add(op);
                    }
                    
                }
            }
        }
        
        update oppToUpdate;
        }
        
     */   
        /*
        
        for(Account a : accounts.values()){
            for(Opportunity o:a.Opportunities){
                if(accIdToUniqueOpprtunities.containsKey(a.Id)){
                String key = a.Name+'_'+o.Type+'_'+o.rrr__c;
                    	if(accIdToUniqueOpprtunities.get(a.Id).containsKey(key)){
                       	 accIdToUniqueOpprtunities.get(a.Id).get(key).add(o);
                   	 }
                   	 else{
                        	accIdToUniqueOpprtunities.get(a.Id).put(key,new List<Opportunity>{o});
                    	}
            		}
                
                
                else{
                   accIdToUniqueOpprtunities.put(a.Id, new Map<String,List<Opportunity>>()); 
                }
            }                       
        }
        //System.debug('accIdToUniqueOpprtunities'+accIdToUniqueOpprtunities);
       // System.debug('map '+accIdToUniqueOpprtunities.values());
       
        for(Opportunity o : oldOpps){
            String key = accounts.get(o.AccountId).Name+'_'+o.Type+'_'+o.rrr__c;
            
           
            
            if(accIdToUniqueOpprtunities.containskey(o.AccountId) && accIdToUniqueOpprtunities.get(o.AccountId).containskey(key)){
				o.Name=key+'_'+(accIdToUniqueOpprtunities.get(o.AccountId).get(key).size()+1)  ;              
            }
            else{
               o.Name = key+'_'+1; 
            }       
            
        }
       */ 
    
    
    public static void onBeforeUpdate(map<id,sObject> newValues, map<id,sObject> oldValues){
        
        List<Opportunity> kaamKiOppsNewList=new List<Opportunity>();
        Map<id,Opportunity> kaamKiOppsNewMap=new Map<id,Opportunity>();
        
         Map<id,Opportunity> kaamKiOppsOldMap=new Map<id,Opportunity>();
        for(Opportunity o:(List<Opportunity>)newValues.values()){
            if(o.AccountId!=((Opportunity)oldValues.get(o.Id)).AccountId){
                kaamKiOppsNewMap.put(o.Id,(Opportunity)o);
                kaamKiOppsOldMap.put(o.id,(Opportunity)oldValues.get(o.Id));
                //getCounterValue(kaamKiOppsNewMap,kaamKiOppsOldMap);
            }
            else{
        	//onBeforeInsert(kaamKiOppsNewList);
        	}
        }
        
        
        
         Set<Id> accountIds = new Set<Id>();
        for(Opportunity o : (list<opportunity>)kaamKiOppsNewMap.values())
        {
            accountIds.add(o.AccountId);
        }
        
        Map<Id,Account> accounts = new Map<Id,account>( [SELECT Id,Name, (SELECT Id,Name,Type,rrr__c,accountID FROM Opportunities)
                                                         FROM Account Where ID in :accountIds]);

        Map <string,Integer> StringToCounterMap = getCounterValue(accounts);
        
        for(Opportunity o : (list<opportunity>) newValues.values()){
            String key = accounts.get(o.AccountId).Name+'_'+o.Type+'_'+o.rrr__c;
            
           
          //  System.debug('Account id presents ' +accIdToUniqueOpprtunities.containskey(o.AccountId) +'map key' +accIdToUniqueOpprtunities.get(o.AccountId).get(key) + 'Key from new values'+key);
            
            if(StringToCounterMap.containskey(Key) ){
				o.Name=key+'_'+ (StringToCounterMap.get(Key)+1) ;              
            }
            else{
               o.Name = key+'_'+1; 
            }       
            
        }
        
        
        
        
        //onBeforeInsert(kaamKiOppsNew);
        //helperMethod(kaamKiOppsOldMap,kaamKiOppsNewMap);
        
        
     
        
    }
	    

}