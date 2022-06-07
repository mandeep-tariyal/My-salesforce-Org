({
	packItem : function(component, event, helper) {
        //alert("You clicked: " + event.getSource().get("v.label"));
        var item  = component.get("v.item",true);
        //console.log("Button clicked"+markedStatus);
        item.Packed__c = true;
        component.set("v.item",item);
        event.getSource().set("v.disabled",true);
		
	},


})