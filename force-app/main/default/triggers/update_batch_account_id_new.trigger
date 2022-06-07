trigger update_batch_account_id_new on Batch__c (before insert) {

List<String>  list1 = new List<String>();

for (Batch__c s1:Trigger.New)
{
  list1.add(s1.Company_Name__c);
}

List<Account>  list2= [SELECT id, Name from Account where Name In :list1 ];
   

Map<String,id> m=new Map<String, id>();

for(Account list3:list2)
{

m.put(list3.Name,list3.id);
}

for(Batch__c  s2:Trigger.New)
{

    if(m.containskey(s2.Company_Name__c))
    {
    s2.Account__c   = m.get(s2.Company_Name__c);
    
   
    
    }
}





}