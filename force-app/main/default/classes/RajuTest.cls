@isTest
global class RajuTest {

    @testSetup static void setup() {
        Account cust = createAccount();
        Account fromDB = [Select IsPersonAccount, Oracle_Id__c from Account where Oracle_Id__c =: cust.Oracle_Id__c];
        System.debug('From Account table in the DB, Oracle_ID__C:' + fromDB.Oracle_Id__c);
    }
    //@isTest
     @isTest public static void funcTest_AlertAPI_PostMethod_Success () {
        
        //System.debug('Oracle ID: ' + fromDB.Oracle_Id__c);
        //System.debug('Is Person Account: ' + fromDB.IsPersonAccount);
        
        String jsonBody = '{' +
            '"alertCategoryCd" : "MAN",' +
            '"alertDate" : "2020-10-05",' +
            '"primaryEntityLevelCode" : "PTY",' + 
            '"primaryEntityName" : "RAJU",' +
            '"alertThreshold" : "Nothing for Now",' +
            '"alertTypeCd" : "Nothing for Now",' + 
            '"alertSubcategoryCd" : "MANUAL",' +
            '"description" : "Alert Description goes here",' +
            '"moneyLaunderingRisk" : 40 ,' + 
            '"primaryEntityNumber" : "Raju123456",' +
            '"runDate" : "2020-10-05",' +
            '"terrorFinancingRisk" : 45 ,' + 
            '"uniqueReferenceNumber" : "Raju123456urn"' + '}';
            
		System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
        amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'PTY';
        amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        amlRequest.primaryEntityNumber = 'Raju123456';
        amlRequest.runDate = Date.parse('05/10/2020');
        amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        
        
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        
        	Alert__c alert = [SELECT Primary_Entity_Name__c, Primary_Entity_Number__c,Alert_Date__c from Alert__c where Primary_Entity_Number__c =:'Raju123456' ];
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        	System.debug('Alert Date: ' + alert.Alert_Date__c);
        	System.assertEquals('Raju123456', alert.Primary_Entity_Number__c, 'Assertion Failed');
        
        Test.stopTest();
        
    }
    
    //@isTest
     @isTest public static void funcTest_EntityNotPresentException () {
        
        //System.debug('Oracle ID: ' + fromDB.Oracle_Id__c);
        //System.debug('Is Person Account: ' + fromDB.IsPersonAccount);
        
        String jsonBody = '{' +
            '"alertCategoryCd" : "MAN",' +
            '"alertDate" : "2020-10-05",' +
            '"primaryEntityLevelCode" : "PTY",' + 
            '"primaryEntityName" : "RAJU",' +
            '"alertThreshold" : "Nothing for Now",' +
            '"alertTypeCd" : "Nothing for Now",' + 
            '"alertSubcategoryCd" : "MANUAL",' +
            '"description" : "Alert Description goes here",' +
            '"moneyLaunderingRisk" : 40 ,' + 
            '"primaryEntityNumber" : "Raju123456",' +
            '"runDate" : "2020-10-05",' +
            '"terrorFinancingRisk" : 45 ,' + 
            '"uniqueReferenceNumber" : "Raju123456urn"' + '}';
            
		System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
        amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'PTY';
        amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        amlRequest.primaryEntityNumber = 'Raju1234561';
        amlRequest.runDate = Date.parse('05/10/2020');
        amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        
        
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        	System.assertEquals('ERROR', amlResponse.statusCode);
        	System.assertEquals('The customer/Entity is not present', amlResponse.errorMessage, 'Verifying the exception when we provide non existing Entity (OracleID)' );
        Test.stopTest();
        
    }
    
    @isTest public static void funcTest_Missing_alertCategoryCd () {
 
		
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        //amlRequest.alertCategoryCd = 'MAN';

        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    
    @isTest public static void funcTest_Missing_alertSubcategoryCd () {
 
		
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
		//amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'PTY';
        amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        amlRequest.primaryEntityNumber = 'Raju1234561';
        amlRequest.runDate = Date.parse('05/10/2020');
        amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    
    @isTest public static void funcTest_Missing_alertDate () {
 
		
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
		amlRequest.alertSubcategoryCd = 'MANUAL';
        //amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'PTY';
        amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        amlRequest.primaryEntityNumber = 'Raju1234561';
        amlRequest.runDate = Date.parse('05/10/2020');
        amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    
    @isTest public static void funcTest_Missing_primaryEntityLevelCode () {
 
		
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
		amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        //amlRequest.primaryEntityLevelCode = 'PTY';
        amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        amlRequest.primaryEntityNumber = 'Raju1234561';
        amlRequest.runDate = Date.parse('05/10/2020');
        amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    @isTest public static void funcTest_Invalid_primaryEntityLevelCode () {
 
		
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
		amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'ABC';
        amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        amlRequest.primaryEntityNumber = 'Raju1234561';
        amlRequest.runDate = Date.parse('05/10/2020');
        amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    @isTest public static void funcTest_Missing_primaryEntityName () {
 
		
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
		amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'PTY';
        //amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        amlRequest.primaryEntityNumber = 'Raju1234561';
        amlRequest.runDate = Date.parse('05/10/2020');
        amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    
    @isTest public static void funcTest_Missing_alertThreshold () {
 
		
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
		amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'PTY';
        amlRequest.primaryEntityName = 'RAJU';
        //amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        amlRequest.primaryEntityNumber = 'Raju1234561';
        amlRequest.runDate = Date.parse('05/10/2020');
        amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    
    @isTest public static void funcTest_Missing_alertTypeCd () {
 
		
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
		amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'PTY';
        amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        //amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        amlRequest.primaryEntityNumber = 'Raju1234561';
        amlRequest.runDate = Date.parse('05/10/2020');
        amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    @isTest public static void funcTest_Missing_description () {
 
		
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
		amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'PTY';
        amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        //amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        amlRequest.primaryEntityNumber = 'Raju1234561';
        amlRequest.runDate = Date.parse('05/10/2020');
        amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    @isTest public static void funcTest_Missing_moneyLaunderingRisk () {
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
		amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'PTY';
        amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        //amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        amlRequest.primaryEntityNumber = 'Raju1234561';
        amlRequest.runDate = Date.parse('05/10/2020');
        amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    @isTest public static void funcTest_Missing_primaryEntityNumber () {
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
		amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'PTY';
        amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        //amlRequest.primaryEntityNumber = 'Raju1234561';
        amlRequest.runDate = Date.parse('05/10/2020');
        amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    @isTest public static void funcTest_Missing_runDate () {
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
		amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'PTY';
        amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        amlRequest.primaryEntityNumber = 'Raju1234561';
        //amlRequest.runDate = Date.parse('05/10/2020');
        amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    @isTest public static void funcTest_Missing_uniqueReferenceNumber () {
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
		amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'PTY';
        amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        amlRequest.primaryEntityNumber = 'Raju1234561';
        amlRequest.runDate = Date.parse('05/10/2020');
        //amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    @isTest public static void funcTest_MoreThanAllowed_uniqueReferenceNumber () {
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
		amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'PTY';
        amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        amlRequest.primaryEntityNumber = 'Raju1234561';
        amlRequest.runDate = Date.parse('05/10/2020');
        //amlRequest.terrorFinancingRisk = 45;
        amlRequest.uniqueReferenceNumber = 'Raju123456urn3243fsdfdsfklkwerwer23432fefsadfwerweresadfsafdsadasdfsdafsadfasdfsdafsdafsadfsadfsadfsadfsdfsdafsadfasdfsdf' + 
            'wferwerfasdtwerwqsdfsdfwqerewfsdarwerfsdafwerwefdsfasrwerwerweqrfdsafasfwerefdasfasdfsafsadfweasdfsadfsdfsdafsadfsdafsadfsdafsdafsdafdsfdsfsafsdreqwr';
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    @isTest public static void funcTest_Missing_terrorFinancingRisk () {
        RestRequest request = new RestRequest();
        request.requestURI = 'services/apexrest/createAlertAPI/';
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.addHeader('Accept', 'application/json');
       // request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;
        AML_AlertAPI.AML_AlertResponseWrapper amlResponse = new AML_AlertAPI.AML_AlertResponseWrapper();
        //System.debug('JSON String: ' + jsonBody);
        AML_AlertAPI.AML_AlertRequestWrapper amlRequest = new AML_AlertAPI.AML_AlertRequestWrapper();
        amlRequest.alertCategoryCd = 'MAN';
		amlRequest.alertSubcategoryCd = 'MANUAL';
        amlRequest.alertDate = Date.parse('05/10/2020');
        amlRequest.primaryEntityLevelCode = 'PTY';
        amlRequest.primaryEntityName = 'RAJU';
        amlRequest.alertThreshold = 'Nothing for Now';
        amlRequest.alertTypeCd = 'Nothing for Now';
        amlRequest.description = 'Alert Description goes here';
        amlRequest.moneyLaunderingRisk = 40;
        // Provided nonexisting Entity number that causes the entity not exists error.
        amlRequest.primaryEntityNumber = 'Raju1234561';
        amlRequest.runDate = Date.parse('05/10/2020');
        amlRequest.terrorFinancingRisk = 45;
        //amlRequest.uniqueReferenceNumber = 'Raju123456urn';
        Test.startTest();
            amlResponse = AML_AlertAPI.insertAlert(amlRequest);
        	System.debug('Alert ID: ' + amlResponse.alertId + ' Status Code: ' + amlResponse.statusCode + ' Response Message: ' + amlResponse.errorMessage);
        Test.stopTest();
        
    }
    public static Account createAccount() {
        Account cust = new Account(Oracle_Id__c = 'Raju123456', Name = 'Raju Lakkamraju');
        insert cust;
        return cust;
    }
}