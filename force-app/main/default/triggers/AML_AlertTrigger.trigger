/**
*Description: This trigger is designed to handle only one alert at a time.
This is used to upsert Alerted Entity(1 per customer) on customer 
with Total Active Alerts, Total Alerts,Oldest Active Alert Age and Owner as Complaince Team
*Created By: Vineeta Verma
* 
*/

trigger AML_AlertTrigger on Alert__c (before insert,after insert,before update,after update) 
{
    //to assign new Alert Owner
    if(trigger.isInsert && trigger.isBefore){
        Alerted_Entity__c[] alertEntityRec = [SELECT Id, Oracle_Id__c, OwnerId FROM Alerted_Entity__c WHERE Oracle_Id__c =: Trigger.new[0].Primary_Entity_Number__c LIMIT 1];
        //If Alerted Entity is present, then assign Owner same as Alerted Entity
        if (alertEntityRec.size() > 0)
            Trigger.new[0].OwnerId = alertEntityRec[0].OwnerId ;
        //If not, then mark status as 'Open' and assign Owner as 'Compliance Operations Team'
        else {
            Trigger.new[0].Status__c = 'Open';
            QueueSObject QueueID = [Select Queue.Id, Queue.Name, Queue.Type from QueueSObject WHERE Queue.Type ='Queue' AND Queue.Name = 'Compliance Operations Team' Limit 1];
            if (QueueID.id   != null){
                Trigger.new[0].OwnerId = QueueID.Queue.Id;
            }
            
        }
    }
    
    Alert__c newAlert = Trigger.new[0];
    Account[] customerRec = [select id from Account where oracle_id__c = :newAlert.Primary_Entity_Number__c LIMIT 1 ];
    if (customerRec.size() > 0)
        AML_AlertEntityUtilityClass.refreshAlertCount(newAlert.Primary_Entity_Number__c);
    else
        newAlert.adderror('The customer/Entity is not present');
        
}