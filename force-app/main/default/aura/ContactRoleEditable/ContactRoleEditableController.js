({
	closeModal : function(component, event, helper) {
        helper.handleClose(component,event);
       
	},
    saveAndNew : function(component,event,helper)
    {
        console.log('saveAndNew');
       
        var saveAndNew = false;
        helper.fetchRecordDetails(component,event,helper,saveAndNew);

    },
  
    doInit : function(cmp, event, helper) {
        var recordId = cmp.get("v.recordId");//LINE 4
        
        // alert(recordId);
        // Code to get parentrecordId for ovverride action

        var pageRef = cmp.get("v.pageReference");
        console.log('REF'+pageRef.toString);
        var state = pageRef.state; // state holds any query params
       //console.log(`pageRed.state${JSON.parse(pageRef.state)}`);
        var base64Context = state.inContextOfRef;

        // For some reason, the string starts with "1."
        if (base64Context.startsWith("1\.")) {
            base64Context = base64Context.substring(2);
        }
        var addressableContext = JSON.parse(window.atob(base64Context));
        
            
            

        
            cmp.set("v.recordId", addressableContext.attributes.recordId);//OppId
            cmp.set("v.currentRecordId",recordId);//ocrId
            cmp.set("v.OcrId",recordId);

        
      
        
    },
    handleSuccess : function(comp,event,helper)
    {
        var callFromSave  = true;
        console.log("handle success");
        helper.fetchRecordDetails(comp,event,helper,callFromSave);
        
    }
})