import { LightningElement,track,wire,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import displayTransactionBoRecords from'@salesforce/apex/TransactionBoController.fetchTransactions';

export default class DisplayTransactionBo extends LightningElement {
    @track searchKey = '';
    @api recordId;

    @track columns = [{label:'Seller',fieldName:'Seller_Id__c',type:'text',sortable: true},
    {label:'Transaction Ref Number',fieldName:'Transaction_Ref_Num__c',type:'text',sortable: true},
    {label:'Transaction Date',fieldName:'Transaction_Date__c',type:'date',sortable: true},
    {label:'Transaction Currency Amount',fieldName:'Transaction_Currency_Amount__c',type:'number',sortable: true}
    ];
    
    @wire(displayTransactionBoRecords,{ searchKey:'$searchKey'}) 
        transactions;

    connectedCallback(){
        this.searchKey = this.recordId;
    }
}