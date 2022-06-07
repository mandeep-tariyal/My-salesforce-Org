global  with sharing class CampingListApexController {
    
    @AuraEnabled
    public static list<camping_item__c> getItemsList()
    {
        System.debug('Apex controller'  );
        list<camping_item__c> campingList = [SELECT Id,Name,Packed__c,Price__c,Quantity__c from camping_item__c];
        
        return [SELECT Id,Name,Packed__c,Price__c,Quantity__c from camping_item__c];
        
    }
    
    @AuraEnabled
    public static camping_item__c saveItems(camping_item__c newItem)
    {
        
        upsert newItem;
        return newItem;
    }

}