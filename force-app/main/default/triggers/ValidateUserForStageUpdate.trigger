trigger ValidateUserForStageUpdate on Opportunity (before update) {
    
    for(opportunity op : trigger.new)
    {
        system.debug('triggeroldmap'+trigger.oldMap);
        System.debug('op.stagename'+op.StageName);
        
        Opportunity oldStage = Trigger.oldMap.get(op.id);
        System.debug('oldstage'+oldStage.StageName);
        if(op.StageName != oldStage.StageName)
        {
            
		   if(UserInfo.getUserId() == '0055g00000CrMGFAA3'&& op.stageName == 'closed Won' )
           {
               op.addError( 'Operation Not Allowed');
           }
        }
    }

}