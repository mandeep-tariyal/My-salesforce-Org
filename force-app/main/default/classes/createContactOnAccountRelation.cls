public class createContactOnAccountRelation{
  @InvocableMethod
  public static void getAccount(List<account> acc) {
    system.debug(acc);   
       list<contact> conlist= new list<contact>();
   
    for(account a:acc)
        {
          for(integer i=0;i<a.NumberofLocations__c;i++)
              {
                 contact c=new contact();
                 c.lastname=a.name+i;
                 c.accountid=a.id;
                 
                 //insert c;
                 conlist.add(c);
                 
                 }
            }
     insert conlist;
  }
  
}