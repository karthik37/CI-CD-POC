import { LightningElement,track,wire,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import displayTransactionBoRecords from'@salesforce/apex/displayTransactionBoController.displayTransactionBoRecords';
export default class DisplayTransactionBo extends LightningElement {
@api recordId;
@track columns = [
{label:'Seller Oracle Id',fieldName:'Seller_Oracle_Id__c',type:'text',sortable: true},
{label:'Buyer Oracle Id',fieldName:'Buyer_Oracle_Id__c',type:'text',sortable: true},
{label:'Transaction Reference Number',fieldName:'Transaction_Reference_Number__c',type:'text',sortable: true},
{label:'Transaction Date',fieldName:'Transaction_Date__c',type:'date',sortable: true},
{label:'Transaction Currency Amount',fieldName:'Transaction_Currency_Amount__c',type:'number',sortable: true},
{label:'Transaction USD Amount',fieldName:'Transaction_USD_Amount__c',type:'number',sortable: true}
];
@wire(displayTransactionBoRecords,{
accId:'$recordId'
}) transactions;
}