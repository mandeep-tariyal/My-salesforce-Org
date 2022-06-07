public class getContactsAura {
    @AuraEnabled
    public static list<contact> getContacts(String SearchFilter)
    {
       
        string soql = 'select firstName,lastName,phone from contact ' ;
        if(SearchFilter != null && SearchFilter !=  '' ){
            
            soql+= 'where firstName LIKE  : searchText    OR lastName   LIKE  : searchText ';
            list<contact> contactList = getContactsFromDB(soql,SearchFilter);
            return contactList ;
          
        }else{
             list<contact> contactList = database.query(soql);
				return contactList;
        }
    
    }
    
    public static list<contact> getcontactsFromDB(string soql,string SearchFilter)
    {
        string searchText = '%' + SearchFilter + '%';
        list<contact> databaseList  =  database.query(soql);
        List<Contact> contactList = new List<Contact>();
        
            for(contact con:databaseList)
            {
				if(con.firstName != null && con.lastName != null)
                contactList.add(con);
            }
        return contactList;
    }
}