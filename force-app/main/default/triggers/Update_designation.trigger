trigger Update_designation on Lead (before insert) {

    
     for(Lead ld:Trigger.New)
    {
      
        if(ld.Occupation__c == 'Builder')
        {
            ld.firstName= 'Bd'+'.'+ +ld.FirstName  ;
        }
         else if(ld.Occupation__c=='Doctor')
        {
            ld.firstName= 'Dr' +'.' + ld.FirstName ;
        }
    }
    
}