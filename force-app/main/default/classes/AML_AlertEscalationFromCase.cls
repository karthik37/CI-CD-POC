public class AML_AlertEscalationFromCase {
    
@AuraEnabled(cacheable=true)
      public static List<Alert__c> getAlertList(String caserecId) {
          List<Case> caseList = [Select Id, AccountId From Case WHERE Id =:caserecId];
          system.debug(caserecId);
          String StrAccountID = Null ;
          For(Case objCase : caseList){
              StrAccountID = objCase.AccountId;
          }
          

          return [SELECT Id,Alert_Date__c,Name,Alert_Subcategory_CD__c,Alert_Category_CD__c,Primary_Entity__c,Primary_Entity_Name__c,Status__c FROM Alert__c WHERE Primary_Entity__c =: StrAccountID AND Status__c != 'Closed' AND Status__c != 'Closed: Data Error' AND Case__c !=: caserecId];
      }
    
     @AuraEnabled
      public static void updateCase(String caserecId, List<String> alertIds) {
          system.debug('caserecId ==>'+caserecId);
          system.debug('alertIds list ==>'+alertIds);
          
          List<Alert__c> alertListreturn = new List<Alert__c>();
          List<Alert__c> alertListToUpdate = new List<Alert__c>();
          
          alertListreturn = [SELECT Id,Case__c,Alert_Date__c,Name,Alert_Subcategory_CD__c,Alert_Category_CD__c,Primary_Entity__c,Primary_Entity_Name__c,Status__c FROM Alert__c Where Id IN: alertIds];
          system.debug('alertListreturn list ==>'+alertListreturn);
          
          For(Alert__c alrt : alertListreturn){
              alrt.Case__c = caserecId ;
              alertListToUpdate.add(alrt);
          }
          
          if(alertListToUpdate.size() > 0){
            Update   alertListToUpdate;
          }
          system.debug('alertListToUpdate list ==>'+alertListToUpdate);
          return;
    
}
    
}