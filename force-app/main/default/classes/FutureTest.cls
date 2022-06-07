public class FutureTest 
{
  @future
  public static void countContacts(Set<id> setId) 
  {
      System.debug('Class Called');
      List<Account> lstAccount = [select id,Number_of_Contacts__c , (select id from contacts ) from account where id in :setId ];
	  List<Contact> lstCont = new List<Contact>() ;
      for( Account acc : lstAccount )
      {
         
          
          acc.Number_of_Contacts__c = lstCont.size();
          System.debug(lstCont.size());
      }
       System.debug('Contacts'+lstCont);
      
          
  }
}