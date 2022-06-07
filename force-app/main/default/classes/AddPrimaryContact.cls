public without sharing class AddPrimaryContact implements Queueable {
    
    private contact contact;
    private string state;
    public addPrimaryContact(contact inputContact, string inputString)
    {
        this.contact = inputContact;
        this.state = inputString;
    }
    
    public void execute(QueueableContext abc)
    {
    
    //Retrieve 200 records

    List<Account> accounts = [select id from account where billingState  = :state limit 200  ];
        
    list<contact> contacts =  new list<contact>();
    
    //Itterating over records
    for(account ac: accounts)
    {
        //clone the contact of specified account and insert into the list of contacts
    	contact contactClone = contact.clone();
        contactClone.AccountId = ac.id;
        contacts.add(contactClone);
    }
    
    insert contacts;
    }
    
}