trigger AML_AlertEntityTrigger on Alerted_Entity__c (before insert) {
    if(trigger.isInsert && trigger.isBefore){
        Alerted_Entity__c newAlertEntity = Trigger.new[0];
        QueueSObject QueueID = [Select Queue.Id, Queue.Name, Queue.Type from QueueSObject WHERE Queue.Type ='Queue' AND Queue.Name = 'Compliance Operations Team' Limit 1];
        if (QueueID.id   != null){
            newAlertEntity.OwnerId = QueueID.Queue.Id;
        }
    }
    
    
}