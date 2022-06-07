public class PopulateNameOnOpportunityDispatcher {
    public static void Run(IPopulateTriggerHandler PopulateNameHandler)
    {
        if(Trigger.isBefore)
        {
            if(Trigger.isInsert)
            {
               PopulateNameHandler.onBeforeInsert(trigger.new);
            }
            if(Trigger.isUpdate)
            {
                PopulateNameHandler.onBeforeUpdate(Trigger.newMap, Trigger.oldMap);
            }
            if(Trigger.isDelete) {
               
                //	PopulateNameHandler.onBeforeDelete(Trigger.oldMap, Trigger.NewMap);
            }
            
        }
    }

}