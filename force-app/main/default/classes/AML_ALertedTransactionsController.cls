Public class AML_ALertedTransactionsController {

     @AuraEnabled public Static Decimal totalTxnCurrencyAmnt {get;set;}
     @AuraEnabled public Static Decimal totalTxnUSDAmnt {get;set;}
      @AuraEnabled(cacheable=true)
      public static list<AML_TransactionV5__b> fetchAlertedTransactions(String alertId) {
      Alert__c alertRec = [Select Id,Name,Primary_Entity__c,Primary_Entity__r.Oracle_Id__c FROM Alert__c WHERE id=:alertId];
      String sellerID = alertRec.Primary_Entity__r.Oracle_Id__c;
      system.debug('AlertRec****'+alertRec+'@@@@@@'+sellerID);
      
          List<AML_Alerted_Transaction__b> alertTxnList= [Select Id,Alert_Id__c,Transaction_Reference_Number__c FROM AML_Alerted_Transaction__b WHERE Alert_Id__c =:alertRec.Name.replaceFirst( '^0+', '')];
          system.debug('####AlertdTxns####'+alertTxnList);
          list<String> txnIds = new list<String>();
          for(AML_Alerted_Transaction__b alttxn : alertTxnList){
              txnIds.add(alttxn.Transaction_Reference_Number__c);
          }
         totalTxnCurrencyAmnt = 0.0;
         totalTxnUSDAmnt = 0.0;
         list<AML_TransactionV5__b> alertedTransactionList = new list<AML_TransactionV5__b>();
          for(AML_TransactionV5__b amlTrxn : [SELECT   Buyer_Oracle_Id__c,Seller_Oracle_id__c,Transaction_Currency_Amount__c,Transaction_Date__c,Transaction_Reference_Number__c,
          Transaction_USD_Amount__c FROM AML_TransactionV5__b Where Seller_Oracle_id__c =: sellerID AND Transaction_Reference_Number__c IN: txnIds ]){
              alertedTransactionList.add(amlTrxn);
              totalTxnCurrencyAmnt = totalTxnCurrencyAmnt + amlTrxn.Transaction_Currency_Amount__c;
              totalTxnUSDAmnt = totalTxnUSDAmnt + amlTrxn.Transaction_USD_Amount__c;
          }

          return alertedTransactionList;
      }
    
    public class AMLTransactions{
       @AuraEnabled public String buyerId {get;set;}
       @AuraEnabled public String sellerId {get;set;}
       @AuraEnabled public String transactionReferenceNumber {get;set;}
       @AuraEnabled public Decimal transactionCurrencyAmount {get;set;}
       @AuraEnabled public Decimal transactionUSDAmount {get;set;}
       @AuraEnabled public datetime transactionDate {get;set;}
       
       public AMLTransactions(){
       }
    }
    
}