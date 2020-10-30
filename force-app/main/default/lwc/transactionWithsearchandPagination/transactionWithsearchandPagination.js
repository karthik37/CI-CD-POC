import { LightningElement,track,wire,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import displayTransactionBoRecords from'@salesforce/apex/displayTransactionBoController.displayTransactionBoRecords';

export default class TransactionWithsearchandPagination extends LightningElement {
@api recordId;
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

handleKeywordChange(event) {
    this.pageNumber = 1;
    this.keyword = event.target.value;
    console.log("Search KeyWord: " + this.keyword);
    this.handlepagechange();
}

handleSort(event){
    this.pageNumber = 1;
    this.sortedField = event.detail.fieldName;
    this.sortDirection = event.detail.sortDirection;
    this.sortType = this.columns.find(column => this.sortedField === column.fieldName).type;
    console.log("sorted Field: " + this.sortedField);
    console.log("sort Direction: " + this.sortDirection);
    this.handlepagechange();
}

handleComboBoxChange(event){
    this.pageNumber = 1;
    this.recordsPerpage = event.target.value;
    console.log("Number Of Records To Display: " + this.recordsPerpage);
    this.handlepagechange();
}


handleNextPage(event){
    if(this.pageNumber < this.totalPageCount) {
        this.pageNumber = this.pageNumber + 1; 
    }
    console.log("Current Page: " + this.pageNumber);
        this.handlepagechange();
}

handlePrevPage(event){
    if(this.pageNumber > 1) {
        this.pageNumber = this.pageNumber - 1; 
    } 
    console.log("Current Page: " + this.pageNumber);
        this.handlepagechange();
}

handlepagechange() {
    getTransactionHistory({
        accountId: this.recordId,
        pageNumber: this.pageNumber,
        recordsPerpage: this.recordsPerpage,
        keyword: this.keyword,
        sortedField: this.sortedField,
        sortDirection: this.sortDirection,
        sortType: this.sortType
    })
    .then(result => {
        console.log('Transaction data'+JSON.stringify(result, null,'\t'));
        if(result.isCRCProfile){
            this.crcData =  result.currentRecords;
            console.log('Print this.crcData'+JSON.stringify(thiis.crcData));
        } else{
            this.data = result.currentRecords;
        }
        if((!result.isCRCProfile && this.data.Length === 0) || (result.isCRCProfile && this.crcData.Length === 0) ){
            this.noMatchesFound = true;
            this.norecordsError = true;
        }
        else{
            this.noMatchesFound = false;
            this.norecordsError = false;  
        }
        this.totlRecordCount = result.totlRecordCount;
        this.totalPageCount = result.totalPageCount;

        this.updatePagebuttons();
    })
    .catch(error => {
        this.currentRecords = undefined;
        this.error = error;
        console.log("Error :" + this.error);
    })
}

updatePagebuttons() {
    console.log('pageNumber: ' + this.pageNumber + ' totalPageCount' + this.totalPageCount);
    if(this.pageNumber === 1){
        this.isFirstPage = true;
    } else {
        this.isFirstPage = false;  
    }
    if(this.pageNumber >= totalPageCount){
        this.isLastPage = true;
    } else {
        this.isLastPage = false;  
    }
}

}