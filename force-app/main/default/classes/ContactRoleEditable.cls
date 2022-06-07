public without sharing class ContactRoleEditable {
    @AuraEnabled
    public static void updatePrimaryRoleId(String contactId, Boolean isPrimary, String role, String ocrId, String oppId) {
        opportunityContactRole currentOCR = [select id, contactId, isPrimary, Role, opportunityId from OpportunityContactRole where id =: ocrId WITH SECURITY_ENFORCED];
        if (currentOCR.opportunityId == oppId && (currentOCR.contactId != contactId || currentOCR.isPrimary != isPrimary || currentOCR.role != role)) {
            System.debug('currentOCR.opportunityId ' + currentOCR.opportunityId + ' oppId' + oppId);
            currentOCR.contactId = contactId;
            currentOCR.isPrimary = isPrimary;
            currentOCR.role = role;
            update currentOCR;

            Opportunity opp = [select id, name, Primary_contactID__c from opportunity where id =: currentOCR.opportunityId];
            if (opp.Primary_contactID__c == null && isPrimary == TRUE) {
                system.debug('isPrimary' + contactId);
                opp.Primary_contactID__c = contactId;
                update opp;
            }
        } else if (currentOCR.opportunityId != oppId) {
            List < opportunityContactRole > oppcr = [select id, OpportunityId, contactId, isPrimary, role from opportunityContactRole where opportunityid =: OppId];
            system.debug('OppCr>' + oppcr);
            Boolean OcrUpdate = true;
            for (Integer i = 0; i < oppcr.size(); i++) {
                if (oppcr[i].ContactId == contactId) {
                    oppcr[i].isPrimary = isPrimary;
                    oppcr[i].role = role;
                    system.debug('Oppcr[i]' + oppcr[i]);
                    update oppcr[i];
                    OcrUpdate = false;
                    break;
                }

            }
            if (OcrUpdate) {

                System.debug('New opp');
                OpportunityContactRole newOcr = new OpportunityContactRole();
                newOcr.opportunityId = oppId;
                newOcr.contactId = contactId;
                newOcr.isPrimary = isPrimary;
                newOcr.role = role;
                insert newOcr;

            }


        }



    }
}