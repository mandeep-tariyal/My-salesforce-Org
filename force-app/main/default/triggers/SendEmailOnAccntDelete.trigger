trigger SendEmailOnAccntDelete on Opportunity (after delete) {

    list<Messaging.Email> EmailList = new List<Messaging.Email>();
    for(opportunity ac: trigger.old)
    {
        Messaging.SingleEmailMessage deletedAcc = new Messaging.SingleEmailMessage();
        deletedAcc.setToAddresses(new String[] { 'mandeep.tariyal@grazitti.com'} );
        deletedAcc.setSubject('Opp deleted ');
        string body = 'Your opportunity ( '+ac.name+' )deleted succesfully';
        deletedAcc.sethtmlBody(body);
        emailList.add(deletedAcc);
        
    }
    Messaging.sendEmail(emailList);
}