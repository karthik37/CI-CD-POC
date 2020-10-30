public with sharing  class amlCustomerSearchController {
    
    @AuraEnabled(Cacheable = true)
    public static list<Account> getAccounts(String userName, String businessName, String eBayEmployee, String recordType, List<String> paymentEntity, String oracleId) {	
        
        List<Account> lstAccs = New List<Account>();       
        List<string> conditionsList = new List<string>();  // arry of string
        
        String strAccName = '';
        String strBusinessName = '';
        String strEbayEmployee = '';
        String strRecordType = '';
        String strOracleId = '';
        
        String paymentEntities = '';
        List<String> pymentEntityList = new List<String>();
        System.debug('paymentEntity Value :'+paymentEntity); 

        
        if(userName  != null){
            strAccName = '%' + userName + '%';
            conditionsList .add( ' User_Name__c LIKE :strAccName' );
        }
        
        if (businessName != null){
            strBusinessName = '%' + businessName + '%';
            conditionsList .add(  ' Business_Name__c LIKE :strBusinessName' );
        }
        
        if(eBayEmployee != null && eBayEmployee != ''){
            strEbayEmployee = '%' + eBayEmployee + '%';
            conditionsList .add( ' eBay_Employee_Indicator__c LIKE :strEbayEmployee' ); 
        }
        
        if (recordType != null && recordType != ''){
            strRecordType = '%' + recordType + '%';
            conditionsList .add( ' RecordType.Name LIKE :strRecordType' );
        }
        if(paymentEntity.size() > 0){ 
            paymentEntities = String.join(paymentEntity,';');
            if(paymentEntities != null){
            system.debug('paymentEntities'+paymentEntities);
            conditionsList .add( ' Payment_Entities__c INCLUDES (:paymentEntities)' );
        }
        } 
        //this if block is to include and search by all of the payment entities .
        /*if(paymentEntities != null){
            system.debug('paymentEntities'+paymentEntities);
            conditionsList .add( ' Payment_Entities__c INCLUDES (:paymentEntities)' );
        }*/
        //this if block is to include and search by any one of payment entities.
        /*if(paymentEntityStr !=''){
            conditionsList .add( ' Payment_Entities__c INCLUDES ('+paymentEntityStr+')' );
        }

        if(paymentEntityStr !=''){
            conditionsList .add( ' Payment_Entities__c INCLUDES (:paymentEntityStr);
        }*/
        
        if (oracleId != null){
            strOracleId = '%' + oracleId + '%';
            conditionsList .add( ' Oracle_Id__c LIKE :strOracleId' );
        }
                
        
        /* List<String> pymentEntityList = new List<String>();
String paymentEntities = '';
if(String.isNotEmpty(paymentEntity)){
pymentEntityList = paymentEntity.split(',');
paymentEntities = pymentEntityList[0] ;   
}*/
        //this if block is to include and search by all of the payment entities.
               
        //this if block is to include and search by any one of payment entities.
        /*system.debug('paymentEntity==>'+paymentEntity.size());
        String paymentEntityStr= '';
        for (Integer i = 0; i< paymentEntity.size(); i++)
        {
            paymentEntityStr +='\''+ paymentEntity[i]+ '\'' ;
            if(i != paymentEntity.size()-1 )
                paymentEntityStr +=',';
        }
        system.debug('paymentEntityStr==>'+paymentEntityStr);
        System.debug('paymentEntity Value  new:'+paymentEntities);*/
        
        String querystring ='SELECT  Id, Name, User_Name__c, Business_Name__c, eBay_Employee_Indicator__c,  Payment_Entities__c, Oracle_Id__c, RecordTypeId, RecordType.Name From Account';
        
        /*Integer totalconditions = conditionsList.size() ;  
        String strwhere = '' ;
        Integer i;*/
        
        /*for ( i = 0; i< totalconditions; i++)
        {
            strWhere += conditionslist[i];
            if( i < totalconditions -1 ){
                strwhere += ' AND ' ;
            }
        }*/
         String operatorString = '';
        
        for(integer i=0;i<conditionsList.size();i++){
            operatorString += conditionsList[i];
            if( i < (conditionsList.size() -1)){
                operatorString = operatorString+ ' AND ';
                
            }
        }
        
        if(conditionsList.size() > 0){
            querystring+= ' where ' + operatorString ;
            querystring+= ' ORDER BY Name ASC';
            system.debug('querystring==>'+querystring);
            lstAccs = Database.query(querystring);
        }
        else{
            throw new AuraHandledException(Label.Error_to_specify_at_least_one_search_field);  
        }
        
        //system.debug('querystring==>'+querystring);
        //List<Account> lstAccs = Database.query(querystring);
        
        if(lstAccs.isEmpty()) {
            throw new AuraHandledException(Label.No_Record_Found);
        }  
        
        return lstAccs;  
        
    }
    
}