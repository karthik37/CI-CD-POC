import { LightningElement ,track} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import getAlertList from '@salesforce/apex/AML_AlertSearchController.getAlertList';

const columns = [
//{label: 'Alert ID', fieldName: 'Name', type: 'Number'},
{label: 'Alert ID', fieldName: 'Name', type: 'url', 
typeAttributes: {label: { fieldName: 'Name' },value:{fieldName: 'Name'}, target: '_blank'}},
{label: 'Alert Date', fieldName: 'Alert_Date', type: 'date-local',typeAttributes: {month: "2-digit",day: "2-digit"}},
{label: 'Primary Entity Number', fieldName: 'Primary_Entity_Number', type: 'text'},
{label: 'Primary Entity', fieldName: 'PrimaryEntityName', type: 'url',typeAttributes: {label: { fieldName: 'Name' },value:{fieldName: 'Name'}, target: '_blank'}},
{label: 'Status', fieldName: 'Status', type: 'Text'},
{label: 'Money Laundering Risk Score', fieldName: 'MoneyLaunderingRiskScore', type: 'Number'}
];

export default class AML_AlertSearchLWC extends LightningElement {
@track alertList;
columns = columns;
searchValue = '';

// update searchValue var when input field value change
searchKeyword(event) {
    this.searchValue = event.target.value;
}


// call apex method on button click 
handleSearchKeyword() {
    
    if (this.searchValue !== '') {
        getAlertList({
                searchKey: this.searchValue
            })
            .then(result => {
                // set @track alert variable with return alert list from server  
                //this.alertList = result;
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
                        rowData.Alert_Date = row.Alert_Date__c;
                        rowData.Primary_Entity_Number = row.Primary_Entity_Number__c;
                        rowData.Status = row.Status__c;
                        rowData.MoneyLaunderingRiskScore = row.Money_Laundering_Risk_Code__c;
 
                        // Account related data
                        if (row.Primary_Entity__c) {
                            rowData.PrimaryEntityName = row.Primary_Entity__r.Name;
                            
                        }
                        currentData.push(rowData);
                    });
        
                    this.alertList = currentData;
                }
            })
            .catch(error => {
                
                const event = new ShowToastEvent({
                    title: 'Error',
                    variant: 'error',
                    message: error.body.message,
                });
                this.dispatchEvent(event);
                // reset alert var with null   
                this.alertList = null;
            });
    } else {
        // fire toast event if input field is blank
        const event = new ShowToastEvent({
            variant: 'error',
            message: 'Search text missing..',
        });
        this.dispatchEvent(event);
    }
}
}