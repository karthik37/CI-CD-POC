/**
*Description: This class creates 1 Alerted Entity per Customer.
    		  Upserts Alerted Entity(1 per customer) on customer 
			  with Total Active Alerts, Total Alerts,Oldest Active Alert Age and Owner as Complaince Team
*Created By: Vineeta Verma
* 
*/

public class AML_AlertEntityUtilityClass 
{
    //Method to be invoked After Insert and Update of an Alert
    public static void refreshAlertCount(String customerOracleId)
    {
        
        system.debug('customerOracleId==>'+customerOracleId);
        //Upsert Alerted Entity on change in Alert Fields
        Account customer = [select id from Account where oracle_id__c = :customerOracleId LIMIT 1 ];
            system.debug('customer==>'+customer);
        Alerted_Entity__c  alertedEntity  = new Alerted_Entity__c();
        alertedEntity.customer__c= customer.Id;
        alertedEntity.oracle_id__c  = customerOracleId;
        Integer TotalAlerts = 0;
        Integer TotalActiveAlerts = 0;
        Decimal OldestAlertAge= 0;
        //To count Total Alerts, Total Active Alerts and Oldest Active(Status: Open,In progress) Alert
        for(Alert__c alertRec: [SELECT Id,Alert_Age__c,Is_Active__c FROM Alert__c WHERE Primary_Entity_Number__c =: customerOracleId]){
            ++TotalAlerts;
            if(alertRec.Is_Active__c) ++TotalActiveAlerts;
            if(OldestAlertAge < alertRec.Alert_Age__c && alertRec.Is_Active__c== true) OldestAlertAge= alertRec.Alert_Age__c;
            
        }
        alertedEntity .Total_Alerts__c =TotalAlerts;
        alertedEntity .Total_Active_Alerts__c = TotalActiveAlerts;
        alertedEntity.Alert_Age__c = OldestAlertAge;
        
        Upsert alertedEntity  oracle_id__c ;
        
        
    
    
    }
    
}