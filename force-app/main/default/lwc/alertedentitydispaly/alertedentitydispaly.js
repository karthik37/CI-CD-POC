import { LightningElement,track,wire,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getAlertedEntity from'@salesforce/apex/AlertedEntityOnCustomerController.getAlertedEntity';
export default class Alertedentitydispaly extends LightningElement {
    @api recordId;   
@track columns = [
{label:'Total Alerts',fieldName:'Total_Alerts__c',type:'Number',sortable: true}
];
@wire(getAlertedEntity,{
    customerId:'$recordId'
}) accounts;
}