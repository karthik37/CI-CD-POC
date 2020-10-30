trigger AML_CustomerTrigger on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        Map<Id,Account> updatedCustList = new Map<Id,Account>();
        system.debug('account id==>'+Trigger.newMap.keySet());
        for( Id custId : Trigger.newMap.keySet() )
        {
            system.debug('custId==>'+custId);
            system.debug('old record type==>'+Trigger.oldMap.get( custId ).RecordType.developerName);
            system.debug('new record type==>'+Trigger.newMap.get( custId ).RecordType.developerName);
            if( 
                (Trigger.oldMap.get( custId ).BillingStreet != Trigger.newMap.get( custId ).BillingStreet)||
                (Trigger.oldMap.get( custId ).BillingCity != Trigger.newMap.get( custId ).BillingCity)||
                (Trigger.oldMap.get( custId ).BillingState != Trigger.newMap.get( custId ).BillingState)||
                (Trigger.oldMap.get( custId ).BillingCountry != Trigger.newMap.get( custId ).BillingCountry)||
                (Trigger.oldMap.get( custId ).BillingPostalCode != Trigger.newMap.get( custId ).BillingPostalCode)||
                (Trigger.oldMap.get( custId ).FirstName != Trigger.newMap.get( custId ).FirstName)||
                (Trigger.oldMap.get( custId ).LastName != Trigger.newMap.get( custId ).LastName)||
                (Trigger.oldMap.get( custId ).RecordType.developerName != Trigger.newMap.get( custId ).RecordType.developerName)||
                (Trigger.oldMap.get( custId ).User_Name__c != Trigger.newMap.get( custId ).User_Name__c)||
                (Trigger.oldMap.get( custId ).Business_Name__c != Trigger.newMap.get( custId ).Business_Name__c)||
                (Trigger.oldMap.get( custId ).Payment_Entities__c != Trigger.newMap.get( custId ).Payment_Entities__c)||
                (Trigger.oldMap.get( custId ).eBay_Employee_Indicator__c != Trigger.newMap.get( custId ).eBay_Employee_Indicator__c)||
                (Trigger.oldMap.get( custId ).Occupation_Description__c != Trigger.newMap.get( custId ).Occupation_Description__c)||
                (Trigger.oldMap.get( custId ).Nationality__c != Trigger.newMap.get( custId ).Nationality__c)||
                (Trigger.oldMap.get( custId ).PEP_Status__c != Trigger.newMap.get( custId ).PEP_Status__c)||
                (Trigger.oldMap.get( custId ).Primary_Contact_First_Name__c != Trigger.newMap.get( custId ).Primary_Contact_First_Name__c)||
                (Trigger.oldMap.get( custId ).Primary_Contact_Last_Name__c != Trigger.newMap.get( custId ).Primary_Contact_Last_Name__c)||
                (Trigger.oldMap.get( custId ).Registered_Site_ID__c != Trigger.newMap.get( custId ).Registered_Site_ID__c)
                
            )
            {
                system.debug('change detect2'+Trigger.oldMap.get( custId ).RecordType.developerName);
                system.debug('change detect2'+Trigger.newMap.get( custId ).RecordType.developerName);
                
                updatedCustList.put(Trigger.oldMap.get(custId).Id,Trigger.oldMap.get(custId));
            }
        }
        AML_CustVerHistUtilityClass.createCustVerHistRec(updatedCustList);
    }
}