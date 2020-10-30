Public class TransactionBoController {
      @AuraEnabled(cacheable=true)
      public static List<AML_TransactionV5__b> fetchTransactions() {
          
          /*List<AccounT> accList = [Select Id,Oracle_Id__c FROM Account WHERE Id =:accId];
          String oracleId = Null ;
          For(Account a : accList){
              oracleId = a.Oracle_Id__c;
          }
          //oracleId = accList[0].Oracle_Id__c ; 
          List<Account> accListUpdate = [Select Id FROM Account WHERE Oracle_Id__c =:oracleId];
          /*List<string> accListId = New List<String>();
          for(Account acc : accListUpdate){
              accListId.add(acc.Id);
          }*/
      
         return [SELECT 	Seller_Oracle_id__c,Transaction_Reference_Number__c,Transaction_Date__c,Transaction_USD_Amount__c,Transaction_Currency_Amount__c,Buyer_Oracle_Id__c
           FROM AML_TransactionV5__b];// Where Seller_Id__c =: oracleId
      }
    
    
}