trigger updateName on Lead (before insert) {

    Map<String,String> leadNewMap = new Map<String,string>();
    leadNewMap.put('Engineer','ER.');
    leadNewMap.put('Farmer','Mr.');
    leadNewMap.put('Doctor','Dr.');
    
    
    
    for(lead lt:trigger.new)
    {
      lt.FirstName  = lt.get(lt.Occupation__c) + lt.FirstName;
      
    }

}