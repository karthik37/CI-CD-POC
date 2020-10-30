public class SF_AlertUtilityClass {
    public class APICustomException extends Exception {}
    public static SF_AlertAPI.SF_AlertResponseWrapper createAlert(SF_AlertAPI.SF_AlertRequestWrapper req)
    {
        
        SF_AlertAPI.SF_AlertResponseWrapper res = new SF_AlertAPI.SF_AlertResponseWrapper();
        Alert__c alert = new Alert__c();
        Id customerId;
        try{ 
            //validations on mandatory fields
            if(validateAlert(req)){
                
                alert.Alert_Category_CD__c = req.alertCategoryCd;
                alert.Alert_Date__c = req.alertDate; 
                alert.Primary_Entity_Level_Code__c = req.primaryEntityLevelCode;
                alert.Primary_Entity_Name__c = req.primaryEntityName; 
                alert.Alert_Subcategory_CD__c = req.alertSubcategoryCd;
                alert.Rule_Name__c = req.alertRuleName;
                alert.Alert_Type_CD__c = req.alertTypeCd;
                alert.Description__c = req.description;
                alert.Money_Laundering_Risk_Code__c = req.moneyLaunderingRisk;
                alert.Primary_Entity_Number__c = req.primaryEntityNumber;
                alert.Run_Date__c = req.runDate;
                alert.Terror_Financing_Risk_Score__c = req.terrorFinancingRisk;
                alert.Unique_Reference_Number__c = req.uniqueReferenceNumber;
                alert.Primary_Entity__c = [SELECT Id FROM Account WHERE Oracle_ID__c =: req.primaryEntityNumber LIMIT 1].Id;
                alert.Status__c = 'Open';
                Database.SaveResult AlertInsertResult = Database.insert(alert, true);
                if(AlertInsertResult.isSuccess())
                {
                    String AlertName =[SELECT Id, Name FROM Alert__c WHERE Id =: alert.Id ].Name;
                    // send AlertResponseWrapper
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
        catch (DmlException ex) {
            res.alertId = null;
            res.statusCode = 'ERROR' ;
            
            if(ex.getDmlType(0).name() == 'DUPLICATE_VALUE'){
                res.errorMessage = 'Dupicate Alert with the same Unique Reference Number' ; //change, use system msg
            }
            else if(ex.getDmlType(0).name() == 'FIELD_CUSTOM_VALIDATION_EXCEPTION'){
                res.errorMessage = ex.getDmlMessage(0) ;
            }
            else if(ex.getDmlType(0).name() == 'STRING_TOO_LONG'){// change:check length 
                res.errorMessage = ex.getDmlMessage(0) ;
            }
            else{
                system.debug('ex.getDmlType(0).name()==>'+ex.getDmlType(0).name());
                res.errorMessage = ex.getMessage();
            }
        }
        catch(Exception e)
        {
            res.alertId = null;
            res.statusCode = 'ERROR' ;
            res.errorMessage = e.getMessage() ;
        }
        
        return res;
    }
    public static boolean validateAlert(SF_AlertAPI.SF_AlertRequestWrapper req){
        boolean isValidated = false;
        
        if(String.isBlank(req.alertCategoryCd)) 
            throw new APICustomException('Alert Category CD is required');
        else 
            if(req.alertDate == NULL) 
            throw new APICustomException('Alert Date is required');
        else
            if(String.isBlank(req.primaryEntityLevelCode)) 
            throw new APICustomException('Primary Entity Level Code is required');
        else
            if(!(req.primaryEntityLevelCode.equals('PTY') && req.primaryEntityLevelCode.isAllUpperCase()) ) 
            throw new APICustomException('Invalid Primary Level code');
        else
            if(String.isBlank(req.primaryEntityName)) 
            throw new APICustomException('Primary Entity Name is required');
        else
            if(String.isBlank(req.alertSubcategoryCd)) 
            throw new APICustomException('Alert Subcategory CD is required');
        else
            if(String.isBlank(req.alertRuleName))
            throw new APICustomException('Alert Rule Name is required');
        else
            if(String.isBlank(req.description))
            throw new APICustomException('Alert description is required');
        else
            //Money Laundery risk code format check
            if(String.isBlank(req.primaryEntityNumber)) 
            throw new APICustomException('Primary Entity Number is required');
        else
            if(req.runDate == NULL) 
            throw new APICustomException('Run Date is required');
        //Terror Financing Risk Score format check
        else
            if(String.isBlank(req.uniqueReferenceNumber)) 
            throw new APICustomException('Unique Reference Number is required');
        else
            isValidated = true;
        
        
        return isValidated;
    }
    
}