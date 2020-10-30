public class AML_AlertUtilityClass {
    public class APICustomException extends Exception {}
    public static AML_AlertAPI.AML_AlertResponseWrapper createAlert(AML_AlertAPI.AML_AlertRequestWrapper alert_request)
    {
        
        AML_AlertAPI.AML_AlertResponseWrapper res = new AML_AlertAPI.AML_AlertResponseWrapper();
        Alert__c alert = new Alert__c();
        try{ 
            if(validateAlert(alert_request)){
                
                alert.Alert_Category_CD__c = alert_request.alertCategoryCd;
                alert.Alert_Date__c = alert_request.alertDate; 
                alert.Primary_Entity_Level_Code__c = alert_request.primaryEntityLevelCode;
                alert.Primary_Entity_Name__c = alert_request.primaryEntityName; 
                alert.Alert_Subcategory_CD__c = alert_request.alertSubcategoryCd;
                alert.Rule_Name__c = alert_request.alertRuleName;
                alert.Alert_Type_CD__c = alert_request.alertTypeCd;
                alert.Description__c = alert_request.description;
                alert.Money_Laundering_Risk_Code__c = alert_request.moneyLaunderingRisk;
                alert.Primary_Entity_Number__c = alert_request.primaryEntityNumber;
                alert.Run_Date__c = alert_request.runDate;
                alert.Terror_Financing_Risk_Score__c = alert_request.terrorFinancingRisk;
                alert.Unique_Reference_Number__c = alert_request.uniqueReferenceNumber;
                
                Id customerId = [SELECT Id FROM Account WHERE Oracle_ID__c =: alert_request.primaryEntityNumber LIMIT 1].Id;
                alert.Primary_Entity__c = customerId;
                alert.Status__c = 'Open';
                Database.SaveResult AlertInsertResult = Database.insert(alert, true);
                if(AlertInsertResult.isSuccess())
                {
                    String AlertName =[SELECT Id, Name FROM Alert__c WHERE Id =: alert.Id ].Name;
                    system.debug('AlertName==>'+AlertName);
                    // send AML_AlertResponseWrapper
                    
                    res.alertId = AlertName;
                    res.errorMessage = '';
                    res.statusCode = 'SUCCESS';
                }
            }
        }
        catch (System.QueryException ex) {
            res.alertId = null;
            res.statusCode = 'ERROR' ;
            if(ex.getTypeName()=='System.QueryException'){
                res.errorMessage = 'The customer/Entity is not present';
            }
            else res.errorMessage = ex.getMessage();
        }
         catch(Exception e)
        {
            res.alertId = null;
            res.statusCode = 'ERROR' ;
            res.errorMessage = e.getMessage();
        }
        return res;
    }
    
    //To pass validations
    public static boolean validateAlert(AML_AlertAPI.AML_AlertRequestWrapper alert_request){
        boolean isValidated = false;
        
        if(String.isBlank(alert_request.alertCategoryCd)) 
            throw new APICustomException('Alert Category CD is required');
        else 
            if(alert_request.alertDate == NULL) 
            throw new APICustomException('Alert Date is required');
        else
            if(String.isBlank(alert_request.primaryEntityLevelCode)) 
            throw new APICustomException('Primary Entity Level Code is required');
        else
            if(!(alert_request.primaryEntityLevelCode.equals('PTY') && alert_request.primaryEntityLevelCode.isAllUpperCase()) ) 
            throw new APICustomException('Invalid Primary Level code');
        else
            if(String.isBlank(alert_request.primaryEntityName)) 
            throw new APICustomException('Primary Entity Name is required');
        else
            if(String.isBlank(alert_request.alertSubcategoryCd)) 
            throw new APICustomException('Alert Subcategory CD is required');
       else
            if(String.isBlank(alert_request.alertRuleName))
            throw new APICustomException('Alert Rule Name is required');
        else
            if(String.isBlank(alert_request.description))
            throw new APICustomException('Alert description is required');
        else
            //Money Laundery risk code format check
            if(String.isBlank(alert_request.primaryEntityNumber)) 
            throw new APICustomException('Primary Entity Number is required');
        else
            if(alert_request.runDate == NULL) 
            throw new APICustomException('Run Date is required');
        //Terror Financing Risk Score format check
        else
            if(String.isBlank(alert_request.uniqueReferenceNumber)) 
            throw new APICustomException('Unique Reference Number is required');
        if(alert_request.uniqueReferenceNumber.length()> 255) 
            throw new APICustomException('Unique Reference Number: data value too large');
        else
            isValidated = true;
        
        
        return isValidated;
    }
    
    
}