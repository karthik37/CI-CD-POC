import { LightningElement, track,api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import getAlertList from '@salesforce/apex/AML_AlertSearchController.getAlertList';
import Error_to_specify_at_least_one_search_field from '@salesforce/label/c.Error_to_specify_at_least_one_search_field';
import Minimum_to_be_less_than_Maximum from '@salesforce/label/c.Minimum_to_be_less_than_Maximum';
import No_Future_Dates_in_Search from '@salesforce/label/c.No_Future_Dates_in_Search';

const columns = [
{label: 'Alert ID', fieldName: 'AlertId', type: 'url', typeAttributes: {label: { fieldName: 'Name' }, target: '_self'},sortable: "true"},
{label: 'Customer Oracle Id', fieldName: 'Primary_Entity_Number', type: 'url',typeAttributes: {label: { fieldName: 'PrimaryEntityNumber' }, target: '_self'},sortable: "true"},
{label: 'Primary Entity Name', fieldName: 'Primary_Entity_Name', type: 'Text',sortable: "true"},
{label: 'Payment Entity', fieldName: 'Payment_Entity', type: 'Text',sortable: "true"},
{label: 'Created Date', fieldName: 'Created_Date', type: 'date',sortable: "true"},
{label: 'Run Date', fieldName: 'Run_Date', type: 'date',sortable: "true"},
{label: 'Rule Name', fieldName: 'Rule_Name', type: 'Text',sortable: "true"},
{label: 'Status', fieldName: 'Status', type: 'Text',sortable: "true"},
{label: 'Owner', fieldName: 'Owner', type: 'Text',sortable: "true"},
//REMEDIATION ALERT
{label: 'Money Laundering Risk Score', fieldName: 'MoneyLaunderingRiskScore', type: 'Number',sortable: "true"}
];

export default class AmlAlertSearch extends LightningElement {
@track alertList;
@api isValidated = false;

columns = columns;
alertId;
oracleId;
runDateMin;
runDateMax;
createDateMin;
createDateMax;
moneyLdRiskScoreMin;
moneyLdRiskScoreMax;
status;

@track today = new Date();

connectedCallback() {
    let dd;let mm;let yyyy;

    dd = String(this.today.getDate()).padStart(2, '0');
    mm = String(this.today.getMonth() + 1).padStart(2, '0');
    yyyy = this.today.getFullYear();
    this.today = yyyy + '-' + mm + '-' + dd;
    }


statusOptions = [
//{value: '--None--', label: '--None--'},
{value: 'Open', label: 'Open'},
{value: 'In Progress', label: 'In Progress'},
{value: 'Pending SAR90', label: 'Pending SAR90'},
{value: 'Closed: Data Error', label: 'Closed: Data Error'},
{value: 'Closed', label: 'Closed'}
];

sortedBy;
defaultSortDirection = 'asc';
sortDirection = 'asc';

label = {
    Error_to_specify_at_least_one_search_field,
    Minimum_to_be_less_than_Maximum,
    No_Future_Dates_in_Search
};
// update alertId var when input field value change
alertIdChange(event) {
    this.alertId = event.target.value;
}

// update runDateMin var when input field value change
runDateMinChange(event) {
    this.runDateMin = event.target.value;

}

// update runDateMax var when input field value change
runDateMaxChange(event) {
    this.runDateMax = event.target.value;
}

// update moneyLdRiskScoreMin var when input field value change
moneyLdRiskScoreMinChange(event) {
    console.log('this.moneyLdRiskScoreMin1',this.moneyLdRiskScoreMin);
    this.moneyLdRiskScoreMin = event.target.value;
    console.log('this.moneyLdRiskScoreMin2',this.moneyLdRiskScoreMin);
}

// update moneyLdRiskScoreMax var when input field value change
moneyLdRiskScoreMaxChange(event) {
    this.moneyLdRiskScoreMax = event.target.value;
}

// update oracleId var when input field value change
oracleIdChange(event) {
    this.oracleId = event.target.value;
}

// update createDateMin var when input field value change
createDateMinChange(event) {
    this.createDateMin = event.target.value;
}

// update createDateMax var when input field value change
createDateMaxChange(event) {
    this.createDateMax = event.target.value;
}

// update status var when input field value change
statusChange(event) {
    this.status = event.target.value;
}
//sorting methods
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

onHandleSort( event ) {

    const { fieldName: sortedBy, sortDirection } = event.detail;
    const cloneData = [...this.alertList];

    cloneData.sort( this.sortBy( sortedBy, sortDirection === 'asc' ? 1 : -1 ) );
    this.alertList = cloneData;
    this.sortDirection = sortDirection;
    this.sortedBy = sortedBy;

}
handleResetSearch(){
    this.alertList = null;
    this.alertId = null;
    this.oracleId = null;
    this.runDateMin = null;
    this.runDateMax =  null;
    this.createDateMin = null;
    this.createDateMax = null;
    this.moneyLdRiskScoreMin = null;
    this.moneyLdRiskScoreMax = null;
    this.status = null;
}


// call apex method on button click 
handleSearchKeyword() {
    console.log('this.moneyLdRiskScoreMin',Number(this.moneyLdRiskScoreMin));
    console.log('this.moneyLdRiskScoreMax',this.moneyLdRiskScoreMax);

    this.validateInputFields();
    if(this.isValidated){
        
    getAlertList({ 
        alertId : this.alertId,
        oracleId : this.oracleId,
        runDateMin : this.runDateMin,
        runDateMax : this.runDateMax,
        createDateMin : this.createDateMin,
        createDateMax : this.createDateMax,
        moneyLdRiskScoreMin : Number(this.moneyLdRiskScoreMin),
        moneyLdRiskScoreMax : Number(this.moneyLdRiskScoreMax),
        status : this.status
        
        
    }).then(result => {
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
                    rowData.Primary_Entity_Name = row.Primary_Entity__r.Name;
                    rowData.Payment_Entity = row.Primary_Entity__r.Payment_Entities__c;
                    rowData.Created_Date  = row.CreatedDate ;
                    rowData.Run_Date = row.Run_Date__c;
                    rowData.Rule_Name = row.Rule_Name__c;
                    rowData.Status = row.Status__c;
                    rowData.Owner = row.Owner.Name;
                    //remediation alert
                    rowData.MoneyLaunderingRiskScore = row.Money_Laundering_Risk_Code__c;
                    

                    // to be displayed as url 
                    if (row.Primary_Entity__c) {
                        rowData.AlertId = '/' + row.Id;
                        rowData.Primary_Entity_Number = '/' + row.Primary_Entity__c;
                        rowData.PrimaryEntityNumber = row.Primary_Entity_Number__c;
                        
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
} 
}
validateInputFields(){
    this.isValidated= false;
    //field is blank
    
    /*if (!(this.alertId || this.oracleId ||this.runDateMin || this.runDateMax|| this.createDateMin|| this.createDateMax|| this.moneyLdRiskScoreMin|| this.moneyLdRiskScoreMax || this.status)) {
        const event = new ShowToastEvent({variant: 'error',message: 'Please specify at least one search field'});
        this.dispatchEvent(event);
    }*/
    if (!(this.alertId || this.oracleId ||this.runDateMin || this.runDateMax|| this.createDateMin|| this.createDateMax|| this.moneyLdRiskScoreMin|| this.moneyLdRiskScoreMax || this.status)) {
        const event = new ShowToastEvent({variant: 'error',message: this.label.Error_to_specify_at_least_one_search_field});
        this.dispatchEvent(event);
    }
    else 
        if((this.runDateMin && this.runDateMin> this.today) || (this.runDateMax &&  this.runDateMax > this.today)){
            const event = new ShowToastEvent({variant: 'error',message: 'Run Date: '+ this.label.No_Future_Dates_in_Search});
            this.dispatchEvent(event);
        }
        else
            if(this.runDateMin && this.runDateMax && (this.runDateMin> this.runDateMax)){
                const event = new ShowToastEvent({variant: 'error',message: 'Run Date: '+ this.label.From_to_be_less_than_to});
                this.dispatchEvent(event);
            }
            else
                if((this.createDateMin && this.createDateMin> this.today) || (this.createDateMax && this.createDateMax> this.today)){
                    const event = new ShowToastEvent({variant: 'error',message: 'Created Date: '+ this.label.No_Future_Dates_in_Search});
                    this.dispatchEvent(event);
                }
                else
                    if(this.createDateMin && this.createDateMax && (this.createDateMin> this.createDateMax)){
                        const event = new ShowToastEvent({variant: 'error',message: 'Created Date: '+ this.label.From_to_be_less_than_to});
                        this.dispatchEvent(event);
                    }
                    else
                        if(this.moneyLdRiskScoreMin && this.moneyLdRiskScoreMax && (Number(this.moneyLdRiskScoreMin)> Number(this.moneyLdRiskScoreMax))){
                            const event = new ShowToastEvent({variant: 'error',message: 'Money Laundering Risk: '+ this.label.Minimum_to_be_less_than_Maximum});
                            this.dispatchEvent(event);
                        }
                        else 
                            this.isValidated= true;
        

}
}