public with sharing class AML_AlertSearchController {
    @AuraEnabled(cacheable=true)
    public static List<Alert__c> getAlertList(String alertId, String oracleId, Date runDateMin, Date runDateMax, Date createDateMin, Date createDateMax, Integer moneyLdRiskScoreMin, Integer moneyLdRiskScoreMax, String status) {
        // create Alert__c list to store search result 
        List<Alert__c> AlertList = new List<Alert__c>();
        List<string> conditionsList = new List<String>();
        String ampAlertIdstr= '';
        String ampOracleIdstr= '';
        String AlertQueryString = '';
        if (alertId != null ){
            ampAlertIdstr = ' \''+alertId+ '%\'';
            conditionsList.add(  ' Name LIKE '+ ampAlertIdstr);
        }
        if (oracleId != null){ 
            ampOracleIdstr = '\''+oracleId+ '\'';
            conditionsList.add(  ' Primary_Entity_Number__c = '+ ampOracleIdstr);
        }
        if(moneyLdRiskScoreMin != null)
            conditionsList.add( ' Money_Laundering_Risk_Code__c >= '+moneyLdRiskScoreMin);
        if(moneyLdRiskScoreMax != null && moneyLdRiskScoreMax != 0)
            conditionsList.add( ' Money_Laundering_Risk_Code__c <= '+moneyLdRiskScoreMax);
        if(runDateMin != null){
            DateTime runDateMinWithTime = Datetime.newInstance(runDateMin.year(),runDateMin.month(), runDateMin.day());
            conditionsList.add( ' Run_Date__c >= '+runDateMinWithTime.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\''));
        }
        
        if(runDateMax != null){
            DateTime runDateMaxWithTime = Datetime.newInstance(runDateMax.year(),runDateMax.month(), runDateMax.day());
            //If only MAX is provided, then it’ll return all the records on or before MAX date
            runDateMaxWithTime = runDateMaxWithTime.addDays(1);
            conditionsList.add( ' Run_Date__c <= '+runDateMaxWithTime.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\''));            
        }
        
        if(createDateMin != null){
            DateTime createDateMinWithTime = Datetime.newInstance(createDateMin.year(),createDateMin.month(), createDateMin.day());
            conditionsList.add( ' CreatedDate  >= '+createDateMinWithTime.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\''));
        }
        
        if(createDateMax != null){
            DateTime createDateMaxWithTime = Datetime.newInstance(createDateMax.year(),createDateMax.month(), createDateMax.day());
            //If only MAX is provided, then it’ll return all the records on or before MAX date
            createDateMaxWithTime = createDateMaxWithTime.addDays(1);
            conditionsList.add( ' CreatedDate  <= '+createDateMaxWithTime.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\''));
        }
        if (status != null){
            if(status == '--None--')
                status = '';
            else
                conditionsList.add(  ' Status__c = \''+ status+'\'');
            
        }
        
        String operatorString = '';
        
        for(integer i=0;i<conditionsList.size();i++){
            operatorString += conditionsList[i];
            if( i < (conditionsList.size() -1)){
                operatorString = operatorString+ ' AND ';
                
            }
        }
        AlertQueryString  = 'SELECT Id, Primary_Entity_Number__c,Primary_Entity__c,Primary_Entity__r.Name, ';
        AlertQueryString += 'Primary_Entity__r.Payment_Entities__c, Name,Status__c, Run_Date__c, Alert_Date__c, ';
        AlertQueryString += 'CreatedDate, Money_Laundering_Risk_Code__c, Rule_Name__c, OwnerId, Owner.Name FROM Alert__c ';
        if(conditionsList.size()>0){
            AlertQueryString += ' WHERE ' + operatorString;
            AlertQueryString+= ' ORDER BY Name ASC';
            system.debug('AlertQueryString==>'+AlertQueryString);
            AlertList = Database.query(AlertQueryString);
        }
        
        if(AlertList.size() == 0){
            throw new AuraHandledException('No Record Found'); 
        }
        
        return AlertList;
    }
}