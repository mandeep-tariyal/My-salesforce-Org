trigger Send_To_PropSub on Account(before update) {

    for (Account SHA: trigger.new) {
        if (SHA.Name != null) {


            //Create email list
            List < Messaging.SingleEmailMessage > emails = new List < Messaging.SingleEmailMessage > ();

            //Create attachment list
            List < Messaging.EmailFileAttachment > attachmentList = new List < Messaging.EmailFileAttachment > ();

            //Create message

            Messaging.SingleEmailMessage singlemail = new Messaging.SingleEmailMessage();

            //set target object for merge fields
            singleMail.setTargetObjectId(SHA.OwnerId);

            //set to save as activity or not
            singleMail.setSaveAsActivity(false);


            //add address's that you are sending the email to
            String[] ToAddress = new string[] {
                'mandeep.tariyal@grazitti.com'
            };

            //set addresses
            singlemail.setToAddresses(toAddress);


            //add mail
            emails.add(singleMail);

            {



                // fetch attachments for Object
                Attachment att = [SELECT id, Name, body, ContentType FROM Attachment WHERE ParentId =: SHA.id];
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();

                {

                    // Create the email attachment
                    efa.setFileName(att.Name);
                    efa.setBody(att.body);
                    efa.setContentType(att.ContentType);
                    efa.setInline(false);

                    attachmentList.add(efa);
                }

                // Attach files to email instance
                singlemail.setFileAttachments(attachmentList);
                //send the message
                System.debug(Messaging.sendEmail(emails));
            }
        }
    }
}