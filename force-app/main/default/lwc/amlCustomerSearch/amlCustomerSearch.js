import { LightningElement,track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/amlCustomerSearchController.getAccounts';
import Error_to_specify_at_least_one_search_field from '@salesforce/label/c.Error_to_specify_at_least_one_search_field';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

const columns = [
    {
        label: 'Customer name',
        fieldName: 'CustomerId',
        type: 'url',
        sortable: "true",
        typeAttributes: { 
            label: {
                fieldName: 'Name'
            },target: '_self'
        },
    },{
        label: 'Customer Oracle ID',
        fieldName: 'Oracle_Id',
        type: 'text',
        sortable: "true"
    },{
        label: 'Customer Type',
        fieldName: "recordTypeName", 
        type: "text",
        sortable: "true"
    }, {
        label: 'User Name',
        fieldName: 'User_Name',
        type: 'text',
        sortable: "true"
    }, {
        label: 'Business Name',
        fieldName: 'Business_Name',
        type: 'text',
        sortable: "true"
    }, {
        label: 'eBay Employee Indicator',
        fieldName: 'eBay_Employee_Indicator',
        type: 'text',
        sortable: "true"
    },{
        label: 'Payment Entities',
        fieldName: 'Payment_Entities',
        type: 'text',
        sortable: "true"
    },
];

export default class AmlCustomerSearch extends LightningElement {

    userNameValue;
    oracleIdValue;
    paymentEntityValue;
    businessNameValue;
    ebayEmployeeValue;
    recordTypeVale;
    columns = columns;
    @track accountList;
    @track _selected;
    sortedBy;
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    //loadMoreStatus;

    //labels
    label = {
        Error_to_specify_at_least_one_search_field,
    };

    get options() {
        return [
            { label: 'ECI', value: 'ECI' },
            { label: 'SARL', value: 'SARL' },
            { label: 'AUS', value: 'AUS' },
            { label: 'CAN', value: 'CAN' },
            { label: 'SGP', value: 'SGP' },
            { label: 'GBR', value: 'GBR' },
        ];
    }
    get paymentEntityValue() {
        return this._selected.length ? this._selected : 'none';
        //paymentEntityValue = this._selected;
    }

    get picklistOptions() {
        return [
                { label: 'None', value: '' },
                { label: 'N', value: 'N' },
                { label: 'Y', value: 'Y' },
             ];
    }

    get picklistOptionsRecordType() {
        return [
                { label: 'None', value: '' },
                { label: 'Business', value: 'Business' },
                { label: 'Private', value: 'Private' },
             ];
    }

    updateSeachKey(event){
        this.userNameValue =event.target.value;
    }
    
    updateOracleId(event){
        this.oracleIdValue =event.target.value;
    }
    updateSearchKey(event){
        this.paymentEntityValue =event.target.value;
    }
    
    updateBusinessName(event){
    this.businessNameValue =event.target.value;
    }
    
    updateEbayEmployee(event){
        this.ebayEmployeeValue =event.target.value;
    }
    
    updateRecordType(event){
        this.recordTypeVale = event.target.value;
    }
    
    handleSortdata(event) {
        // field name
        this.sortBy = event.detail.fieldName;

        // sort direction
        this.sortDirection = event.detail.sortDirection;

        // calling sortdata function to sort the data based on direction and selected field
        this.sortData(event.detail.fieldName, event.detail.sortDirection);
    }

    onHandleSort( event ) {

        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.accountList];

        cloneData.sort( this.sortBy( sortedBy, sortDirection === 'asc' ? 1 : -1 ) );
        this.accountList = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;

    }

    sortBy( field, reverse, primer ) {

        const key = primer
            ? function( x ) {
                  return primer(x[field]);
              }
            : function( x ) {
                  return x[field];
              };

        return function( a, b ) {
            a = key(a);
            b = key(b);
            return reverse * ( ( a > b ) - ( b > a ) );
        };

    }

   /* loadMoreData(event) {
        //Display a spinner to signal that data is being loaded
        event.target.isLoading = true;
        //Display "Loading" when more data is being loaded
        this.loadMoreStatus = 'Loading';
        fetchData(100)
            .then((accountList) => {
                if (accountList.length >= this.totalNumberOfRows) {
                    event.target.enableInfiniteLoading = false;
                    this.loadMoreStatus = 'No more data to load';
                } else {
                    const currentData = this.data;
                    //Appends new data to the end of the table
                    const newData = currentData.concat(data);
                    this.data = newData;
                    this.loadMoreStatus = '';
                }
                event.target.isLoading = false;
            });
    }*/

    handleSearch() {
        debugger;
        // if search input value is not blank then call apex method, else display error msg 
       
        if (this.userNameValue  || this.businessNameValue  || this.oracleIdValue  || this.ebayEmployeeValue  || this.recordTypeVale  || this.paymentEntityValue ) {
            getAccounts({
                userName: this.userNameValue,
                businessName: this.businessNameValue,
                eBayEmployee: this.ebayEmployeeValue,
                recordType: this.recordTypeVale,
                paymentEntity: this.paymentEntityValue,
                oracleId : this.oracleIdValue,    
                }).then(result => {

                   if(result) {
 
                    let currentData = [];
                
                    result.forEach((row) => {
                
                        /* 
                        * Creating the an empty object
                        * To reslove "TypeError: 'set' on proxy: trap returned falsish for property"
                        */
                
                        let rowData = {};
                        rowData.Id = row.Id;
                        rowData.Name = row.Name;
                        rowData.User_Name = row.User_Name__c;
                        rowData.Business_Name = row.Business_Name__c;
                        rowData.Oracle_Id = row.Oracle_Id__c;
                        rowData.eBay_Employee_Indicator = row.eBay_Employee_Indicator__c;
                        rowData.Payment_Entities = row.Payment_Entities__c;
                        rowData.recordTypeName = row.RecordType.Name;

                        if(row.Id){
                        rowData.CustomerId = '/' + row.Id;
                        }
                        currentData.push(rowData);
                    });
                
                    this.accountList = currentData;
                }
                
                })
                .catch(error => {
                    // display server exception in toast msg 
                    const event = new ShowToastEvent({
                        title: 'Error',
                        variant: 'error',
                        message: error.body.message,
                    });
                    this.dispatchEvent(event);   
                    this.accountList = null;
                });
        } 

        else {
            // fire toast event if input field is blank
            const event = new ShowToastEvent({
                variant: 'error',
                message: this.label.Error_to_specify_at_least_one_search_field,
            });
            this.dispatchEvent(event);
            /*const event = new ShowToastEvent({variant: 'error',message: this.label.Error_to_specify_at_least_one_search_field});
            this.dispatchEvent(event);*/
        }
    } 

    handleClear(){

      console.log('Entering Clear Method ');
      /*const inputTextFields = this.template.querySelectorAll('lightning-input')
      const inputPickListFields = this.template.querySelectorAll('lightning-combobox')
      const inputMultiSelectFields = this.template.querySelectorAll('lightning-dual-listbox')
    
    if (inputTextFields) {
        inputTextFields.forEach(each => {
            each.value = '';
        });
    }
    if (inputPickListFields) {
        inputPickListFields.forEach(each => {
            each.value = '';
        });
    }
    if (inputMultiSelectFields) {
        inputMultiSelectFields.forEach(each => {
            each.value = '';
        });
    }*/
    /*this.template.querySelectorAll('lightning-input').forEach(each => {
        each.value = '';
    });
    this.template.querySelectorAll('lightning-combobox').forEach(each => {
        each.value = null;
    });
    this.template.querySelectorAll('lightning-dual-listbox').forEach(each => {
        each.value = null;
    });
    
    this.accountList = null;*/
    /*if(this.userNameValue){
        this.userNameValue = null;
    }
    if(this.businessNameValue){
        this.businessNameValue = null;
    }
    if(this.oracleIdValue){
        this.oracleIdValue = null;
    }
    if(this.ebayEmployeeValue){
        this.ebayEmployeeValue = null;
    }
    if(this.recordTypeVale){
        this.recordTypeVale = null;
    }
    if(this.paymentEntityValue){
        this.paymentEntityValue = null;
    }*/
        this.userNameValue = null;
        this.businessNameValue = null;
        this.oracleIdValue = null;
        this.ebayEmployeeValue = null;
        this.recordTypeVale = null;
        this.paymentEntityValue = null;
        this.accountList = null;
    }
}