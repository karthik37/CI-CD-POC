import { LightningElement,track,wire,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import displayTransactionBoRecords from'@salesforce/apex/TransactionBoController.fetchTransactions';

// Datatable Columns
const columns = [
    {
        label: 'Transaction Reference Number',
        fieldName: 'Transaction_Ref_Num__c',
        type: 'text',
    }, {
        label: 'Transaction Date',
        fieldName: 'Transaction_Date__c',
        type: 'Date'
    }, {
        label: 'Seller',
        fieldName: 'Seller__r.Name',
        type: 'Lookup(Account)'
    }, {
        label: 'Buyer',
        fieldName: 'Buyer__r.Name',
        type: 'Lookup(Account)'
    },{
        label: 'Currency',
        fieldName: 'Transaction_Currency_Amount__c',
        type: 'number'
    }, {
        label: 'USD Amount',
        fieldName: 'Transaction_USD_Amount__c',
        type: 'number'
    }
];

export default class DisplayTransactionBo extends LightningElement {
    @track searchKey = '';
    @api recordId;

    @track columns = columns;
    
    @wire(displayTransactionBoRecords,{ searchKey:'$searchKey'}) 
        transactions;

    connectedCallback(){
        this.searchKey = this.recordId;
    }
}