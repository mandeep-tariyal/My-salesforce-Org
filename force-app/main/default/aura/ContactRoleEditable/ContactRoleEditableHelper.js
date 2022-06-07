({
    fetchRecordDetails : function(cmp,event,helper,callFromSave)
    {
       console.log(callFromSave);
      
       
        var isPrimary = cmp.find("isPrimary").get("v.value");
        var role = cmp.find("role").get("v.value");
       
       var contactId = cmp.find("contactId").get("v.value");
       var oppId = cmp.find("opportunityId").get("v.value");
       console.log('oppdId'+oppId);      
       var currOcr = cmp.get("v.OcrId");
       
        
       
           console.log("inside if")
            var action = cmp.get("c.updatePrimaryRoleId");
            action.setParams({  contactId:contactId,
                                isPrimary:isPrimary,
                                role:role,
                                ocrId:currOcr,
                                oppId:oppId
                            });
                                
            action.setCallback(this,function(Response){
                console.log('TEST');
                var state = Response.getState();
                console.log("state",state);
                if(state != 'SUCCESS')
                {
                    return window.alert("Cannot save  record");
                } 
                else if(callFromSave){
                this.handleClose(cmp,event);
                }
                else{
                    cmp.find("opportunityId").set("v.value","");
                    cmp.find("contactId").set("v.value","");
                    cmp.find("role").set("v.value","");
                    cmp.find("isPrimary").set("v.value",false);
                    cmp.set("v.OcrId",currOcr);
                    cmp.set("v.currentRecordId",null)
                }
                
            });
            $A.enqueueAction(action);

      
       },
        handleClose : function(Component,event)
       {
    /*    var urlEvent = $A.get("e.force:navigateToURL");
        console.log(Component.get("v.recordId"));
        
    urlEvent.setParams({
        "url": `/lightning/r/OpportunityContactRole/${Component.get('v.recordId')}/related/OpportunityContactRoles/view`
    });

    urlEvent.fire();
	*/	
    window.location.href=  `/lightning/r/OpportunityContactRole/${Component.get('v.recordId')}/related/OpportunityContactRoles/view`;
       },
       handleSaveAndNew : function(component,event) {
           
           console.log('save and new');
           var callFromSaveAndNew = true;
           //window.location.href=  `/lightning/o/OpportunityContactRole/new?`;
           //$A.get('e.force:refreshView').fire();

           
       }
    
})