trigger AutomateApprove on Opportunity(After insert, After update)

{

    for (Integer i = 0; i < Trigger.new.size(); i++)
  {
    try
     {
        if( Trigger.isInsert || (Trigger.new[i].Next_Step__c == 'Submit' && Trigger.old[i].Next_Step__c != 'Submit'))
          {
               submitForApproval(Trigger.new[i]);
          }
        else if(Trigger.isInsert || Trigger.isUpdate || (Trigger.new[i].Next_Step__c == 'Approve' && Trigger.old[i].Next_Step__c != 'Approve'))
          {
              approveRecord(Trigger.new[i]);
           }
         else if(Trigger.isInsert || (Trigger.new[i].Next_Step__c == 'Reject' && Trigger.old[i].Next_Step__c != 'Reject'))
                
            {
              rejectRecord(Trigger.new[i]);
           }
            
        }catch(Exception e)
            
        {
          Trigger.new[i].addError(e.getMessage());
       }
      }

    /**
* This method will submit the opportunity automatically

**/
    
    public void submitForApproval(Opportunity opp)
        
    {
        
        // Create an approval request for the Opportunity
        
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval automatically using Trigger');
        
        req1.setObjectId(opp.id);
        
        req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});

        
        
        // Submit the approval request for the Opportunity
        
        Approval.ProcessResult result = Approval.process(req1);
        
    }
    
    
    /**

* Get ProcessInstanceWorkItemId (Represents a user’s pending approval request.) using SOQL
    
**/
    
    public Id getWorkItemId(Id targetObjectId)
        
    {
      Id retVal = null;
      for(ProcessInstanceWorkitem workItem  : [Select p.Id from ProcessInstanceWorkitem p
                                                 
                                                 where p.ProcessInstance.TargetObjectId =: targetObjectId])
      {
          retVal  =  workItem.Id;
      }
          return retVal;
      }
 
    /**

* This method will Approve the opportunity

**/
    
    public void approveRecord(Opportunity opp)
        
    {
        
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        
        req.setComments('Approving request using Trigger');
        
        req.setAction('Approve');
        
        
        
        Id workItemId = getWorkItemId(opp.id);
        
        
        
        if(workItemId == null)
            
        {
            
            opp.addError('Error Occured in Trigger');
            
        }
        
        else
            
        {
             // Use the ID from the newly created item to specify the item to be worked
            req.setWorkitemId(workItemId);
            
            // Submit the request for approval
            
            Approval.ProcessResult result =  Approval.process(req);
            //hoe to update picklist field
            System.debug('Approved' +result);
        }
        
    }
    
    
    /**

* This method will Reject the opportunity

**/
    
    public void rejectRecord(Opportunity opp)
        
    {
        
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        req.setComments('Rejected request using Trigger');
        
        req.setAction('Reject');
        
        Id workItemId = getWorkItemId(opp.id);  
        
        
        
        if(workItemId == null)
            
        {
          opp.addError('Error Occured in Trigger');
        }
       else
      {
          req.setWorkitemId(workItemId);
            
            // Submit the request for approval
            
            Approval.ProcessResult result =  Approval.process(req);
            
        }
        
    }
    
}