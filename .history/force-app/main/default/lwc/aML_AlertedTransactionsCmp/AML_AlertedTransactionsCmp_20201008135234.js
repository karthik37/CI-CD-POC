import { LightningElement,track,wire,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import fetchAlertedTransactions from'@salesforce/apex/AML_ALertedTransactionsController.fetchAlertedTransactions';
export default class ShowAlertedTransactions extends LightningElement {
@api recordId;
@track columns = [
                    {label:'Seller Oracle Id',fieldName:'Seller_Oracle_id__c',type:'text',sortable: true},
                    {label:'Buyer Oracle Id',fieldName:'Buyer_Oracle_Id__c',type:'text',sortable: true},
                    {label:'Transaction Reference Number',fieldName:'Transaction_Reference_Number__c',type:'text',sortable: true},
                    {label:'Transaction Date',fieldName:'Transaction_Date__c',type:'date',sortable: true},
                    {label:'Transaction Currency Amount',fieldName:'Transaction_Currency_Amount__c',type:'number',sortable: true},
                    {label:'Transaction USD Amount',fieldName:'Transaction_USD_Amount__c',type:'number',sortable: true}
                ];
totalTxnCurrencyAmount;
totalTxnUSDAmount;
transactions;

    @wire(fetchAlertedTransactions,{alertId:'$recordId'}) 
    wiredTransactions({error,data}){
        if(data){
            this.transactions = data;
            console.log(JSON.stringify(this.transactions));
            //let transactionsList = [];
            console.log("Before calculation" +totalTxnCurrencyAmount);
            console.log(this.totalTxnUSDAmount);
            //loop through the list of contacts and assign an icon based on the rating
            this.transactions.forEach(record => {
                this.totalTxnCurrencyAmount = this.totalTxnCurrencyAmount + parseInt(record.Transaction_Currency_Amount__c);
                this.totalTxnUSDAmount = this.totalTxnUSDAmount + parseInt(record.Transaction_USD_Amount__c);
            });
            //this.data = contactsList; 
            console.log(this.totalTxnCurrencyAmount);
            console.log(this.totalTxnUSDAmount);
        }
    }


}