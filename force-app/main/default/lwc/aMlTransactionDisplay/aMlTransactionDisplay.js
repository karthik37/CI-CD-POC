import { LightningElement,track,wire,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getOpps from '@salesforce/apex/TransactionBoController.fetchTransactions';;
//import displayTransactionBoRecords from'@salesforce/apex/displayTransactionBoController.displayTransactionBoRecords';

const columns = [{
    label: 'Seller oracle Id',
    fieldName: 'Seller_Oracle_id__c',
    type: 'text'
},
{
    label: 'Transaction Reference Number',
    fieldName: 'Transaction_Reference_Number__c',
    type: 'text'
},
{
    label: 'Buyer Oracle Id',
    fieldName: 'Buyer_Oracle_Id__c',
    type: 'text'
},
{
    label: 'Transaction Date',
    fieldName: 'Transaction_Date__c',
    type: 'date'
},
{
    label: 'Transaction USD Amount',
    fieldName: 'Transaction_USD_Amount__c',
    type: 'number'
},
{
    label: 'Transaction Currency Amount',
    fieldName: 'Transaction_Currency_Amount__c',
    type: 'number'
}
];

export default class AMlTransactionDisplay extends LightningElement {
     @track error;
    @track columns = columns;
    @track opps; //All opportunities available for data table    
    @track showTable = false; //Used to render table after we get the data from apex controller    
    @track recordsToDisplay = []; //Records to be displayed on the page
    @track rowNumberOffset; //Row number

   /* @api recordId;
@track columns = [{label:'Seller Oracle Id',fieldName:'Seller_Oracle_id__c',type:'text',sortable: true},
{label:'Buyer Oracle Id',fieldName:'Buyer_Oracle_Id__c',type:'text',sortable: true},
{label:'Transaction Reference Number',fieldName:'Transaction_Reference_Number__c',type:'text',sortable: true},
{label:'Transaction Date',fieldName:'Transaction_Date__c',type:'date',sortable: true},
{label:'Transaction Currency Amount',fieldName:'Transaction_Currency_Amount__c',type:'number',sortable: true},
{label:'Transaction USD Amount',fieldName:'Transaction_USD_Amount__c',type:'number',sortable: true}
];
@wire(displayTransactionBoRecords,{
    accId:'$recordId'
    }) transactions;
    //wopps({error,data}){
        if(data){
            
            this.opps = transactions;
            this.showTable = true;
        }       
    //} */

    @wire(getOpps)
    wopps({error,data}){
        if(data){
            let recs = [];
            for(let i=0; i<data.length; i++){
                let opp = {};
                opp.rowNumber = ''+(i+1);
                opp.oppLink = '/'+data[i].Id;
                opp = Object.assign(opp, data[i]);
                recs.push(opp);
            }
            this.opps = recs;
            this.showTable = true;
        }else{
            this.error = error;
        }       
    }
    //Capture the event fired from the paginator component
    handlePaginatorChange(event){
        this.recordsToDisplay = event.detail;
        this.rowNumberOffset = this.recordsToDisplay[0].rowNumber-1;
    }
}