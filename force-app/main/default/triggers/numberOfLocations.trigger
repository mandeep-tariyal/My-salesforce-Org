trigger numberOfLocations on Account (after insert) {

list<contact> setContact = new list<contact>();
map<id,decimal> mapAcc = new map<id,decimal>();
for(Account acc:trigger.new)
{
mapAcc.put(acc.id,acc.NumberofLocations__c);
}
if(mapAcc.size()>0 && mapAcc!=null)
{
    for(Id accId:mapAcc.keyset())
    {
    for(integer i=0;i<mapAcc.get(accId);i++){
    contact newContact=new contact(AccountId=accId,LastName='MyContact'+i);
    setContact.add(newContact);
        }
    }
}

insert setContact;
//System.debug('Contact = ' + listContact);

}