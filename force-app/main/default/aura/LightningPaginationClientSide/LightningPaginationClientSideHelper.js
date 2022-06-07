({
    getAccounts : function(component, helper) {
        var action = component.get("c.getContacts");
        if(component.get("v.pageSize") == null)
        {
            component.set("v.pageSize",5);
        }

       
       // action.setStorable();
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log("state",state)
            if (state === "SUCCESS") {
                
                console.log('Response Time: '+((new Date().getTime())-requestInitiatedTime));
                component.set("v.totalPages", Math.ceil(response.getReturnValue().length/component.get("v.pageSize")));
                component.set("v.allContacts", response.getReturnValue());
                console.log("response.getReturnValue()",response.getReturnValue())
                component.set("v.currentPageNumber",1);
                helper.buildData(component, helper);
            }
        });
        var requestInitiatedTime = new Date().getTime();
        $A.enqueueAction(action);
    },
    
    /*
     * this function will build table data
     * based on current page selection
     * */
    buildData : function(component, helper) {
        var data = [];
        if(component.get("v.pageSize") === null)
        {
            component.set("v.pageSize",5);
        }
        var pageNumber = component.get("v.currentPageNumber");
        var pageSize = component.get("v.pageSize");
        var allContacts = component.get("v.allContacts");
        var index = (pageNumber-1)*pageSize;
        
        //creating data-table data
        for(; index<=(pageNumber)*pageSize; index++){
            if(allContacts[index]){
            	data.push(allContacts[index]);
            }
        }
        component.set("v.data", data);
        component.set("v.totalPages", Math.ceil(allContacts.length/component.get("v.pageSize")));
        
        helper.generatePageList(component, pageNumber);
    },
    
    /*
     * this function generate page list
     * */
    generatePageList : function(component, pageNumber){
        pageNumber = parseInt(pageNumber);
        var pageList = [];
        var totalPages = component.get("v.totalPages");
        if(totalPages > 1){
            if(totalPages <= 10){
                var counter = 2;
                for(; counter < (totalPages); counter++){
                    pageList.push(counter);
                } 
            } else{
                if(pageNumber < 5){
                    pageList.push(2, 3, 4, 5, 6);
                } else{
                    if(pageNumber>(totalPages-5)){
                        pageList.push(totalPages-5, totalPages-4, totalPages-3, totalPages-2, totalPages-1);
                    } else{
                        pageList.push(pageNumber-2, pageNumber-1, pageNumber, pageNumber+1, pageNumber+2);
                    }
                }
            }
        }
        component.set("v.pageList", pageList);
    },

    setFilteredContacts : function(component,helper)
    {
        var searchText = component.get("v.searchString");
        
       /*
        if(searchText === '' || searchText === null){
            component.set("v.pageSize",5);
        }*/
        console.log(" Search text ",searchText);
        var action = component.get("c.getContacts");
        action.setParams({'SearchFilter':component.get("v.searchString")});
        action.setCallback(this,function(response){
            
            var state = response.getState();
            if(state === 'SUCCESS')
            {
                console.log("response.getReturnValue.toString",response.getReturnValue().string);
                if( response.getReturnValue().length === 0)
                {
                    console.log("if executed");
                    alert("No Record Found");
                }else{
                console.log('Response.getReturnValue()',response.getReturnValue());
                component.set("v.data",response.getReturnValue());
                component.set("v.pageNumber",1);
                }
            }
        }),
        $A.enqueueAction(action);
       

    },

    convertListToCSV : function(component,helper)
    {
        var allContacts = component.get("v.allContacts");
        var comma = ',';
        var nextLine = '\n';

        var keys  = new Set();
        allContacts.forEach(record => Object.keys(record).forEach(key => keys.add(key)));

        keys = Array.from(keys);
        console.log("keys.keys" ,keys);
        var csvString = '';
        csvString += keys.join(comma);
        csvString += nextLine;
        //console.log('csvString',csvString)

        for(var i = 0; i < allContacts.length; i++)
        {
            
            var counter  = 0;
            
                for(var sTempKey in keys){
                    var skey = keys[sTempKey];
                        if(counter > 0)
                            {
                                csvString += comma;
                            }
                var value = allContacts[i][skey] === undefined ? '' : allContacts[i][skey];
                //console.log('allContacts[i][skey]',allContacts[i][skey]);
                csvString += '"' +value + '"';                
                counter++;
                }
                csvString += nextLine;
            
        }
        
        //console.log('csvStringNew ',csvString);
        return csvString;
    }
     
   
 })