trigger updateNosOfContacts on Contact (after insert,after update,after delete) {
set<id>newCon=new set<id>();
List<Account> l1=new List<Account>();

if(trigger.isInsert){
for(Contact cc: trigger.new)
    {    
        newCon.add(cc.AccountId);
    }
}

if(trigger.isDelete)
    for(contact cc: trigger.old){
        newCon.add(cc.AccountId);
    }
Map<id,List<contact>>myMap=new map<id,List<contact>>();




for(contact cc : [Select accountId,Name from contact where AccountId in : newCon])
{   
    if(myMap.containsKey(cc.AccountId))
    {
    
       List<contact>newList=myMap.get(cc.AccountId);
       newList.add(cc);
       myMap.put(cc.AccountId,newList);
    }
    else
    {
    myMap.put(cc.AccountId,new List<contact>{cc});
    }
}

//Update Account field
for(id idNew :newCon)
{

   Account acc=new Account();
   acc.id=idNew;
  if(!myMap.isEmpty()){
  acc.Number_of_contacts__c=(myMap.get(idNew)).size();
   
   }else
   {
      acc.Number_of_contacts__c=0;  
   }
   l1.add(acc);
   
 

}
if(l1.size()>0)
{

update l1;
}

}