public Interface IPopulateTriggerHandler {
    
    void onBeforeInsert(List<sObject> newList );
    void onBeforeUpdate(Map<Id,sobject> newItems, Map<Id,sObject> oldItems );
    void onBeforeDelete(Map<Id,sObject> oldItems,Map<Id,sobject> newItems);
    

}