public class AlertedEntityOnCustomerController {
    @AuraEnabled(cacheable=true)
    public static List<Alerted_Entity__c> getAlertedEntity(Id customerId){
        system.debug('customerId==>'+customerId);
        return [SELECT Id, Customer__c, Total_Alerts__c, Alert_Age__c,Total_Active_Alerts__c, Priority__c, Oracle_Id__c 
                FROM Alerted_Entity__c WHERE Customer__c = :customerId limit 1 ];
    }

}