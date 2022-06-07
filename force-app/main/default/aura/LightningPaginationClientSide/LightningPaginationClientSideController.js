({
    /*
     * This finction defined column header
     * and calls getAccounts helper method for column data
     * editable:'true' will make the column editable
     * */
	doInit : function(component, event, helper) {        
        component.set('v.columns', [
            {label: 'First Name', fieldName: 'FirstName', type: 'text'},
            {label: 'Last Name', fieldName: 'LastName', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'phone'},
           
        ]);
        console.log("cur PAge Size", component.get("v.pageSize"));
        
        helper.getAccounts(component, helper);
    },
    chanegPageSize : function(component,event,helper)
    {
       var currPageSize =  component.find("selectItem").get("v.value");
       console.log("currPageSize",currPageSize);
       component.set("v.pageSize" ,currPageSize);
       helper.buildData(component,helper);
       

    },
    searchContact: function(component, event, helper) {
      
        helper.setFilteredContacts(component,event,helper);
    },
    
    onNext : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        console.log("pageSize on nesxt", component.get("V.PageSize"))
        component.set("v.currentPageNumber", pageNumber+1);
        helper.buildData(component, helper);
    },
    keyPressed : function(component,event,helper)
    {
        if(event.which == 13)
        {
        var searchText = component.get("v.searchString");
       
        if(searchText === '' || searchText === null){
            component.set("v.pageNumber",1);
            helper.buildData(component,helper);
        }else
            helper.setFilteredContacts(component,event,helper);
        }
    },
    
    onPrev : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber-1);
        helper.buildData(component, helper);
    },
    
    processMe : function(component, event, helper) {
        component.set("v.currentPageNumber", parseInt(event.target.name));
        helper.buildData(component, helper);
    },
    
    onFirst : function(component, event, helper) {        
        component.set("v.currentPageNumber", 1);
        helper.buildData(component, helper);
    },
    
    onLast : function(component, event, helper) {        
        component.set("v.currentPageNumber", component.get("v.totalPages"));
        helper.buildData(component, helper);
    },

    handleCSV : function(component,event,helper)
    {
        var csv = helper.convertListToCSV(component,helper);
        if (csv == null){return;}
        
        // Create a temporal <a> html tag to download the CSV file
        var hiddenElement = document.createElement('a');
        hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
        hiddenElement.target = '_self';
        hiddenElement.download = 'Downloaded File ';
        document.body.appendChild(hiddenElement); //Required for FireFox browser
        hiddenElement.click(); // using click() js function to download csv file
    }
  
})