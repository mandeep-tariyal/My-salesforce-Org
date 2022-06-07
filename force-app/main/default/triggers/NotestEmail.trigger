trigger NotestEmail on ContentDocumentLink (After Insert) {
     //Create email list
     
            List < Messaging.SingleEmailMessage > emails = new List < Messaging.SingleEmailMessage > ();

            //Create attachment list
            List < Messaging.EmailFileAttachment > attachmentList = new List < Messaging.EmailFileAttachment > ();
			
            //Create message

            Messaging.SingleEmailMessage singlemail = new Messaging.SingleEmailMessage();
    for (ContentDocumentLink SHA: trigger.new) {
        System.debug(trigger.new);
        
            
			User user = [Select id,name from user where id = :sha.LinkedEntityId];
           // fetch attachments for Object
                //contentDocument att = [select id,title,filetype from contentDocument where id = :sha.contentDocumentId ];
                contentVersion content = [SELECT VersionData,ContentDocumentId,contentUrl,ContentBodyId FROM ContentVersion WHERE ContentDocumentId = :sha.contentDocumentId AND IsLatest = true];
            	//System.debug('ATtt' +att);
               
            //set addresses
            singlemail.setTargetObjectId( UserInfo.getUserId());
        	system.debug('content.VersionData.toString()'+content.VersionData.toString());
            singlemail.setSaveAsActivity( false );
            singlemail.setSubject('Attachment Added to The recod ' +sha.LinkedEntityId);
        	singlemail.setPlainTextBody('Hi '+User.name +content.VersionData.toString()+' CLICK this URL'+ 
                                        '('+content.ContentUrl +')' +'To Get Note'+content.ContentBodyId);
        
            
            //add mail
            emails.add(singleMail);

               
                            
        
        System.debug(Messaging.sendEmail(emails));

    }
}