public with sharing  class AccountSearch {

   @AuraEnabled(Cacheable = true)
    public static list<Account> getAccounts(String actName, String payen, String busname, String ebayemp, String recType) {
        system.debug('payment entity'+payen);
        List<String> pymentEntityList = new List<String>();
        String paymentEntities = '';
        if(String.isNotEmpty(payen)){
         pymentEntityList = payen.split(';');
         paymentEntities = pymentEntityList[0] ;   
        } 
        String strAccName = '%' + actName + '%';
        String strBusinessName = '%' + busname + '%';
        String strEbayEmployee = '%' + ebayemp + '%';
        String strRecordType = '%' + recType + '%';
        list<Account> lstAccs = New list<Account>();
        
        //Username
        if(String.isNotEmpty(actName) && String.isEmpty(payen) && String.isEmpty(busname) && String.isEmpty(ebayemp) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //PaymentEntity
        if(String.isNotEmpty(payen) && String.isEmpty(actName) && String.isEmpty(busname) && String.isEmpty(ebayemp) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE Payment_Entities__c INCLUDES (:paymentEntities)];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
         //BusinessName
        if(String.isNotEmpty(busname) && String.isEmpty(payen) && String.isEmpty(actName) && String.isEmpty(ebayemp) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE Business_Name__c LIKE :strBusinessName];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //ebayEmployee
        if(String.isNotEmpty(ebayemp) && String.isEmpty(payen) && String.isEmpty(actName) && String.isEmpty(busname) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE eBay_Employee_Indicator__c LIKE :strEbayEmployee];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //recordType
        if(String.isNotEmpty(recType) && String.isEmpty(payen) && String.isEmpty(actName) && String.isEmpty(busname) && String.isEmpty(ebayemp)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE RecordType.Name LIKE :strRecordType];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Both accountt name and Payment Entity
        if(String.isNotEmpty(payen) && String.isNotEmpty(actName) && String.isEmpty(busname) && String.isEmpty(ebayemp) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName AND Payment_Entities__c INCLUDES (:paymentEntities)];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Both accountt name and Business
        if(String.isNotEmpty(busname) && String.isNotEmpty(actName) && String.isEmpty(payen) && String.isEmpty(ebayemp) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName AND Business_Name__c LIKE :strBusinessName];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Both accountt name and Record Type
        if(String.isEmpty(busname) && String.isNotEmpty(actName) && String.isEmpty(payen) && String.isEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName AND RecordType.Name LIKE :strRecordType];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
         //Both accountt name and Ebay Employee Indicator
        if(String.isEmpty(payen) && String.isNotEmpty(actName) && String.isEmpty(busname) && String.isNotEmpty(ebayemp) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName AND eBay_Employee_Indicator__c LIKE :strEbayEmployee];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Both Business name and Payment Entity
        if(String.isNotEmpty(payen) && String.isEmpty(actName) && String.isNotEmpty(busname) && String.isEmpty(ebayemp) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE Business_Name__c LIKE :strBusinessName AND Payment_Entities__c INCLUDES (:paymentEntities)];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Both Business name and Record Type
        if(String.isEmpty(payen) && String.isEmpty(actName) && String.isNotEmpty(busname) && String.isEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE Business_Name__c LIKE :strBusinessName AND RecordType.Name LIKE :strRecordType];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Both Business name and Ebay Employee Indicator
        if(String.isEmpty(payen) && String.isEmpty(actName) && String.isNotEmpty(busname) && String.isNotEmpty(ebayemp) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE Business_Name__c LIKE :strBusinessName AND eBay_Employee_Indicator__c LIKE :strEbayEmployee];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Both Payment Entity and Record Type
        if(String.isNotEmpty(payen) && String.isEmpty(actName) && String.isEmpty(busname) && String.isEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE RecordType.Name LIKE :strRecordType AND Payment_Entities__c INCLUDES (:paymentEntities)];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Both Payment Entity and Ebay Employee Indicator
        if(String.isNotEmpty(payen) && String.isEmpty(actName) && String.isEmpty(busname) && String.isNotEmpty(ebayemp) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE eBay_Employee_Indicator__c LIKE :strEbayEmployee AND Payment_Entities__c INCLUDES (:paymentEntities)];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Both  Record Type  and Ebay Employee Indicator
        if(String.isEmpty(payen) && String.isEmpty(actName) && String.isEmpty(busname) && String.isNotEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE RecordType.Name LIKE :strRecordType AND eBay_Employee_Indicator__c LIKE :strEbayEmployee];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }
            
        }
        //Three account name, Payment Entity and Business Name
        if(String.isNotEmpty(payen) && String.isNotEmpty(actName) && String.isNotEmpty(busname) && String.isEmpty(ebayemp) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName AND Business_Name__c LIKE :strBusinessName AND Payment_Entities__c INCLUDES (:paymentEntities)];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Three account name, Business Name and Record Type
        if(String.isEmpty(payen) && String.isNotEmpty(actName) && String.isNotEmpty(busname) && String.isEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName AND Business_Name__c LIKE :strBusinessName AND RecordType.Name LIKE :strRecordType];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Three account name, Business Name and Ebay Employee indicator
        if(String.isEmpty(payen) && String.isNotEmpty(actName) && String.isNotEmpty(busname) && String.isNotEmpty(ebayemp) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName AND Business_Name__c LIKE :strBusinessName AND eBay_Employee_Indicator__c LIKE :strEbayEmployee];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Three account name, Payment Entity and Record Type
        if(String.isNotEmpty(payen) && String.isNotEmpty(actName) && String.isEmpty(busname) && String.isEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName AND Payment_Entities__c INCLUDES (:paymentEntities) AND RecordType.Name LIKE :strRecordType];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Three account name, Payment Entity and Ebay Employee Indicator
        if(String.isNotEmpty(payen) && String.isNotEmpty(actName) && String.isEmpty(busname) && String.isNotEmpty(ebayemp) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName AND Payment_Entities__c INCLUDES (:paymentEntities) AND eBay_Employee_Indicator__c LIKE :strEbayEmployee];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Three account name, Record Type and Ebay Employee Indicator
        if(String.isEmpty(payen) && String.isNotEmpty(actName) && String.isEmpty(busname) && String.isNotEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName AND RecordType.Name LIKE :strRecordType AND eBay_Employee_Indicator__c LIKE :strEbayEmployee];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Three Record Type , Payment Entity and Business Name
        if(String.isNotEmpty(payen) && String.isEmpty(actName) && String.isNotEmpty(busname) && String.isEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE RecordType.Name LIKE :strRecordType AND Business_Name__c LIKE :strBusinessName AND Payment_Entities__c INCLUDES (:paymentEntities)];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
         //Three Ebay Employee indicator , Payment Entity and Business Name
        if(String.isNotEmpty(payen) && String.isEmpty(actName) && String.isNotEmpty(busname) && String.isNotEmpty(ebayemp) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE eBay_Employee_Indicator__c LIKE :strEbayEmployee AND Business_Name__c LIKE :strBusinessName AND Payment_Entities__c INCLUDES (:paymentEntities)];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }

         //Three Ebay Employee indicator , Record Type and Business Name
        if(String.isEmpty(payen) && String.isEmpty(actName) && String.isNotEmpty(busname) && String.isNotEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE eBay_Employee_Indicator__c LIKE :strEbayEmployee AND Business_Name__c LIKE :strBusinessName AND RecordType.Name LIKE :strRecordType];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //Three Ebay Employee indicator , Payment Entity and Record Type
        if(String.isNotEmpty(payen) && String.isEmpty(actName) && String.isEmpty(busname) && String.isNotEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE eBay_Employee_Indicator__c LIKE :strEbayEmployee AND RecordType.Name LIKE :strRecordType AND Payment_Entities__c INCLUDES (:paymentEntities)];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //All four account name, Payment Entity, Business Name and ebayEmployee
        if(String.isNotEmpty(payen) && String.isNotEmpty(actName) && String.isNotEmpty(busname) && String.isNotEmpty(ebayemp) && String.isEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName AND Business_Name__c LIKE :strBusinessName AND Payment_Entities__c INCLUDES (:paymentEntities) AND eBay_Employee_Indicator__c LIKE :strEbayEmployee];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //All four account name, Payment Entity, Business Name and Record Type
        if(String.isNotEmpty(payen) && String.isNotEmpty(actName) && String.isNotEmpty(busname) && String.isEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName AND Business_Name__c LIKE :strBusinessName AND Payment_Entities__c INCLUDES (:paymentEntities) AND RecordType.Name LIKE :strRecordType];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //All four account name, Ebay Employee Indicator, Business Name and Record Type
        if(String.isEmpty(payen) && String.isNotEmpty(actName) && String.isNotEmpty(busname) && String.isNotEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName AND Business_Name__c LIKE :strBusinessName AND eBay_Employee_Indicator__c LIKE :strEbayEmployee AND RecordType.Name LIKE :strRecordType];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
         //All four account name, Payment Entity, Ebay Employee Indicator and Record Type
        if(String.isNotEmpty(payen) && String.isNotEmpty(actName) && String.isEmpty(busname) && String.isNotEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName AND eBay_Employee_Indicator__c LIKE :strEbayEmployee AND Payment_Entities__c INCLUDES (:paymentEntities) AND RecordType.Name LIKE :strRecordType];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //All four Business name, Payment Entity, Ebay Employee Indicator and Record Type
        if(String.isNotEmpty(payen) && String.isEmpty(actName) && String.isNotEmpty(busname) && String.isNotEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE Business_Name__c LIKE :strBusinessName AND eBay_Employee_Indicator__c LIKE :strEbayEmployee AND Payment_Entities__c INCLUDES (:paymentEntities) AND RecordType.Name LIKE :strRecordType];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        
        //All five Account Name(User Name), Business name, Payment Entity, Ebay Employee Indicator and Record Type
        if(String.isNotEmpty(payen) && String.isNotEmpty(actName) && String.isNotEmpty(busname) && String.isNotEmpty(ebayemp) && String.isNotEmpty(recType)){
        lstAccs = [SELECT  Id, Name, User_Name__c, Business_Name__c,   Payment_Entities__c,RecordTypeId,RecordType.Name From Account WHERE User_Name__c LIKE :strAccName  AND Business_Name__c LIKE :strBusinessName AND eBay_Employee_Indicator__c LIKE :strEbayEmployee AND Payment_Entities__c INCLUDES (:paymentEntities) AND RecordType.Name LIKE :strRecordType];
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }  
        }
        return lstAccs;
    }
    
}