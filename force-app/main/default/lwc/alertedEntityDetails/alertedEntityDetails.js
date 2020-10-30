import { LightningElement, api, wire,track } from 'lwc';
import Total_Alerts_Field from '@salesforce/schema/Alerted_Entity__c.Total_Alerts__c';
import Total_Active_Alerts_Field from '@salesforce/schema/Alerted_Entity__c.Total_Active_Alerts__c';
import Priority_Field from '@salesforce/schema/Alerted_Entity__c.Priority__c';
import Alert_Age_Field from '@salesforce/schema/Alerted_Entity__c.Alert_Age__c';

import getAlertedEntity from '@salesforce/apex/AlertedEntityOnCustomerController.getAlertedEntity';

export default class WireGetRecordProperty extends LightningElement {
    @track AlertEntityRec = { Total_Alerts : 0, Total_Active_Alerts : 0, Priority: '', Alert_Age: 0 };
    @api recordId;
    @wire(getAlertedEntity, { customerId: '$recordId' })
    Alerted_Entity({ error, data }) {
        if(data){
            this.AlertEntityRec.Total_Alerts = data.Total_Alerts__c;
            this.AlertEntityRec.Total_Active_Alerts = data.Total_Alerts__c;
            this.AlertEntityRec.Priority = data.Priority__c;
            this.AlertEntityRec.Alert_Age = data.Alert_Age__c;
        }
            console.log('data==>',data);
            console.log('Total_Alerts==>',this.AlertEntityRec.Total_Alerts);
        
    }
    
    /*get name() {
        console.log('this.Alerted_Entity__c==>',this.Alerted_Entity__c);
        return this.Alerted_Entity__c.data.Total_Alerts__c;
    }*/


        
    
}