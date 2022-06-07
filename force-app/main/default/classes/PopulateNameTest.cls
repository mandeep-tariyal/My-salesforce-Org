@isTest
public with sharing class PopulateNameTest {
  @isTest
    Public static void OnBeforeInsertTest()
    {
        //Creating an account to link with a custome id to link with opportunity
        Account acc = new account(name ='testClass');
        insert acc;
        
        list<Opportunity> oppToTest = new list<opportunity>();
        for( integer i = 0; i < 5; i++)
        {
             oppToTest.add(new opportunity (AccountID = acc.id,Name ='Test'+i, CloseDate = System.today(),StageName = 'Need Analysis',type = 'Existing Customer - Upgrade'));
        }
       
        insert oppToTest;
        
        list<Opportunity> oppToTestNew = new list<opportunity>();
        oppToTestNew.add(new opportunity (AccountID = acc.id,Name ='Test',CloseDate = System.today(),StageName = 'Need Analysis',type = 'Existing Customer - Upgrade'));
        insert oppToTestNew;
        
        
        
        //oppTotest.Type= 'Existing Customer - Upgrade';
        
        
        Test.startTest();
        PopulateNameHandler.onBeforeInsert(oppToTest);
        Test.stopTest();
        
        list<opportunity> updatedOpps = [select id from opportunity where type = 'Existing Customer - Upgrade' ];
        System.debug('Opportunities' +updatedOpps);
        
        
        
    }
    @isTest
    Public static void onBeforeUpdateTest()
    {
        Account acc = new account(name ='testClass');
        insert acc;
        
        list<Opportunity> oppToTest = new list<opportunity>();
        for(integer i = 0; i < 5; i++ )
        {
             oppToTest.add(new opportunity (AccountID = acc.id,Name ='Test', RecordTypeId =Schema.SObjectType.opportunity.getRecordTypeInfosByName()
                  .get('Sales').getRecordTypeId(),CloseDate = System.today(),StageName = 'Need Analysis',type = 'Existing Customer - Upgrade'));
        }
        System.debug('Record type sales : 0125g000001vHbo ----- returned record Id'+Schema.SObjectType.opportunity.getRecordTypeInfosByName()
                  .get('Sales').getRecordTypeId());
        
         System.debug( 'Record Type----->' +Schema.getGlobalDescribe().get('opportunity').getDescribe().getRecordTypeInfosById().
                      get(Schema.SObjectType.opportunity.getRecordTypeInfosByName()
                  .get('Sales').getRecordTypeId()).getName() );
       
        list<Opportunity> oppToTestNew = new list<opportunity>();
        oppToTestNew.add(new opportunity (AccountID = acc.id,Name ='Test',RecordTypeId =Schema.SObjectType.opportunity.getRecordTypeInfosByName()
                  .get('Sales').getRecordTypeId(), CloseDate = System.today(),StageName = 'Need Analysis',type = 'Existing Customer - Upgrade'));
        
           
       
        List<database.SaveResult> resultForInsert = database.Insert(oppToTest,False);
        System.debug('Result For Insert' +resultForInsert);
        list<opportunity> opp = [select id,name,type,rrr__c from opportunity where name = :'Existing Customer - Upgrade'];
        System.debug('Opportunities inserted' +opp);
        insert oppToTestNew;
        list<opportunity> opp1 = [select id,name,type,rrr__c from opportunity where name = :'Existing Customer - Upgrade'];
        System.debug('Opportunities inserted' +opp1);
        
        Map<id,Opportunity> OppToUpdateOldMap = new Map<id,Opportunity>();
       for(Opportunity currOpp : [Select id,accountID,rrr__c,recordtypeId,type from opportunity where accountId  = :acc.Id])
       {
           OppToUpdateOldMap.put(currOpp.id, currOpp);
       }
        
        Map<id,Opportunity> OppToUpdateNewMap = new Map<id,Opportunity>();
       for(Opportunity currOpp : [Select id,accountId,rrr__c,recordTypeId,type from opportunity where accountId  = :acc.Id])
       {
           currOpp.Type ='Existing Customer - Replacement';
           OppToUpdateNewMap.put(currOpp.id, currOpp);
           update currOpp;
       }
        //List<database.SaveResult> resultForUpdate = database.Update(OppToUpdateNewMap,False);
       
        /*Opportunity currOppNew = [Select id,accountId,rrr__c,recordTypeId,type from opportunity where name  = :'Existing Customer - Replacement'];
        {
			currOppNew.Type ='Existing Customer - Downgrade';            
        }
        update currOppNew;*/
        
        
        
         Test.startTest();
         PopulateNameHandler.onBeforeUpdate(oppToUpdateNewMap,oppToUpdateOldMap);
        Test.stopTest();
        
        
    }

}