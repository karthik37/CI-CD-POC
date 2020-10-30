import { LightningElement,track,wire,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import fetchAlertedTransactions from'@salesforce/apex/AML_ALertedTransactionsController.fetchAlertedTransactions';
export default class ShowAlertedTransactions extends LightningElement {
@api recordId;
@track columns = [{label:'Seller Oracle Id',fieldName:'sellerId',type:'text',sortable: true},
{label:'Buyer Oracle Id',fieldName:'buyerId',type:'text',sortable: true},
{label:'Transaction Reference Number',fieldName:'transactionReferenceNumber',type:'text',sortable: true},
{label:'Transaction Date',fieldName:'transactionDate',type:'date',sortable: true},
{label:'Transaction Currency Amount',fieldName:'transactionCurrencyAmount',type:'number',sortable: true},
{label:'Transaction USD Amount',fieldName:'transactionUSDAmount',type:'number',sortable: true}
];
@wire(fetchAlertedTransactions,{
    alertId:'$recordId'
}) transactions;
}