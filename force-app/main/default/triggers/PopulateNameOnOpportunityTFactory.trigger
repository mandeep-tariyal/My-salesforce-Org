trigger PopulateNameOnOpportunityTFactory on Opportunity (before insert,before update) {
    
    PopulateNameOnOpportunityDispatcher.Run( new populateNameHandler() );

}