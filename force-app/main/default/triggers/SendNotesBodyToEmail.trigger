trigger SendNotesBodyToEmail on ContentVersion (before insert) {
      List < Messaging.SingleEmailMessage > emails = new List < Messaging.SingleEmailMessage > ();

            //Create attachment list
            List < Messaging.EmailFileAttachment > attachmentList = new List < Messaging.EmailFileAttachment > ();
             System.debug('TIMES EXEVUted');
            //Create message

            Messaging.SingleEmailMessage singlemail = new Messaging.SingleEmailMessage();
    for (ContentVersion SHA: trigger.new) {
       
        System.debug(trigger.new);
        String body = EncodingUtil.base64Encode(sha.VersionData);
        System.debug('body.escapeHTML4()>>'+body.escapeHTML4());
        String blobtoString = sha.VersionData.toString();
         System.debug('blobtoString>>'+blobtoString);
      
        
        if(sha.FileType == 'SNOTE')
        {
            
            //add address's that you are sending the email to
            String[] ToAddress = new string[] {
                'lokesh.sharma@grazitti.com'
            };
            
            //set addresses
            //singlemail.setToAddresses(toAddress);
            singlemail.setTargetObjectId( UserInfo.getUserId() );
            singlemail.setSubject('Notes added to the record ');
            singlemail.setHTMLBody('Hi Content is' +sha.VersionData.toString());
            singlemail.setSaveAsActivity( false );
            
            //add mail
            emails.add(singleMail);
             
        }
        System.debug(Messaging.sendEmail(emails));

    }

}