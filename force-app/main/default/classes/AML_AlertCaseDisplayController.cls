public class AML_AlertCaseDisplayController {

    @AuraEnabled(cacheable=true)
      public static List<Case> getCaseList(String alertId) {
          List<Alert__c> alertList = [Select Id, Primary_Entity_Number__c,Primary_Entity__c,Primary_Entity__r.Name From Alert__c WHERE Id =:alertId];
          system.debug(alertId);
          String primaryEntity = Null ;
          For(Alert__c alert : alertList){
              primaryEntity = alert.Primary_Entity__c;
          }
          
          //return [SELECT Id,AccountId,Account.Name,Owner.Name,OwnerId,CaseNumber,Case_Summary__c,Status,Subject,Priority,CreatedDate FROM Case WHERE AccountId =: primaryEntity AND (Status = 'Open' OR Status = 'Case Review') AND id in (Select Case__c from Alert__c where Id !=:alertId)];
          return [SELECT Id,AccountId,Account.Name,Owner.Name,OwnerId,CaseNumber,Case_Summary__c,Status,Subject,Priority,CreatedDate FROM Case WHERE AccountId =: primaryEntity AND (Status = 'Open' OR Status = 'Case Review')];// Where Seller_Id__c =: oracleId
      }
    
    @AuraEnabled
      public static void updateAlerts(String alertId, List<String> caseRecId) {
          system.debug('alertId ==>'+alertId);
          system.debug('caseId ==>'+caseRecId);
          String cId = caseRecId[0];
          List<Alert__c> alertList = [Select Id,Case__c,Status__c,Closed_Reason__c,Primary_Entity_Number__c,Primary_Entity__c,Primary_Entity__r.Name From Alert__c WHERE Id =:alertId];
          List<Alert__c> alertListreturn = new List<Alert__c>();
          system.debug('Alert List ==>'+alertList);
          Alert__c alert = alertList[0];
          alert.Case__c = cId;
         /* alert.Status__c = 'Closed';
          alert.Closed_Reason__c = 'Escalated to Case';*/
          system.debug('Alert ==>'+alert);
          if(alert != null){
              Update alert;
              system.debug('Updated Alert ==>'+alert);
          }
          return;
    
}
    
}