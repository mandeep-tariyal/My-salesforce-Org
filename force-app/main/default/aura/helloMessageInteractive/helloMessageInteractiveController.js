({
	handleClick : function(component, event, helper) {
        var btnClicked = event.getSource();//calling event.getSource() gets us a 
        					//reference to the specific <lightning:button> that was clicked.
        var btnMessage = btnClicked.get("v.label");
        console.log('handleClick1',event.getSource());
        component.set("v.message",btnMessage);
		
	},
        handleClick2: function(component, event, helper) {
        let newMessage = event.getSource().get("v.label");
            console.log('handleClick2',event.getSource());
        component.set("v.message", newMessage);
            
    },
    handleClick3: function(component, event, helper) {
        component.set("v.message", event.getSource().get("v.label"));
        console.log('handleClick3',event.getSource());
    },
})