import { LightningElement,track,wire,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getCaseList from'@salesforce/apex/AML_AlertCaseDisplayController.getCaseList';
import updateAlerts from'@salesforce/apex/AML_AlertCaseDisplayController.updateAlerts';
import { refreshApex } from '@salesforce/apex';
import { NavigationMixin } from 'lightning/navigation';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'

export default class AmlAlertCaseDisplay extends LightningElement {

//@track cases; 
//@track caseList;    
@api recordId;
selectedCase='';
@track error; // to show error message from apex controller.
@track success;

sortedBy;
defaultSortDirection = 'asc';
sortDirection = 'asc';

@track columns = [
{label:'Case Number',fieldName:'CaseNumber',type:'text',sortable: true},
{label:'Status',fieldName:'Status',type:'text',sortable: true},
{label:'Priority',fieldName:'Priority',type:'text',sortable: true},
{label:'Subject',fieldName:'Subject',type:'text',sortable: true},
{label:'Created Date',fieldName:'CreatedDate',type:'date',sortable: true}
];
@wire(getCaseList,{
    alertId:'$recordId'
}) cases;

handleRowSelection = event => {
    var selectedRows=event.detail.selectedRows;

    if(selectedRows.length>1)
    {
        var el = this.template.querySelector('lightning-datatable');
        selectedRows=el.selectedRows=el.selectedRows.slice(1);
        console.log('selectedRows1:' + selectedRows);
        //this.selectedCase = selectedRows;
        event.preventDefault();
        //return ;
    }
    else if(selectedRows)
    {
        var el = this.template.querySelector('lightning-datatable');
        selectedRows=el.selectedRows;
        console.log('selectedRows2:' + selectedRows);
        this.selectedCase = selectedRows;
        event.preventDefault();
        //return ;
    }
    /*else if(selectedRows.length<1)
    {
        var el = this.template.querySelector('lightning-datatable');
        selectedRows=el.selectedRows;
        console.log('selectedRows3:' + selectedRows);
        this.selectedCase = '';
        event.preventDefault();
    }*/
}

showNotification() {
    const event = new ShowToastEvent({
        title: 'Error',
        message: 'Only one row can be selected',
        variant: 'warning',
        mode: 'pester'
    });
    this.dispatchEvent(event);
}

onHandleSort( event ) {

    const { fieldName: sortedBy, sortDirection } = event.detail;
    const cloneData = [...this.cases];

    cloneData.sort( this.sortBy( sortedBy, sortDirection === 'asc' ? 1 : -1 ) );
    this.cases = cloneData;
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

handleEscalation(e) {
    console.log('Entering escalation Method:');
    console.log('this.selectedCase:' + this.selectedCase);
    console.log('recordId:' + this.recordId);
    if(this.selectedCase !== ''){
    updateAlerts({
        alertId : this.recordId,
        caseRecId : this.selectedCase
    })
    /*.then(() => {
        //refreshApex(this.cases)
        eval("$A.get('e.force:refreshView').fire();")
        //window.location.reload()*/
        .then(() => {
            eval("$A.get('e.force:refreshView').fire();")
            this.dispatchEvent(
                new ShowToastEvent({
                    title: ' Alert Updated Sucessfully',
                    message: 'Selected Case has been Escalated into the ALert-->',
                    variant: 'success'
                }),
            );
        })
   // })
    .catch((error) => {
        this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Selected case Was not escalated',
                        message: error.message,
                        variant: 'error'
                    }),
                );
    });
}

else {
    // fire toast event if input field is blank
    const event = new ShowToastEvent({
        variant: 'error',
        message: 'Please Select Some case to Escalate to Alert',
    });
    this.dispatchEvent(event);
}
this.navigateNext();
}

navigateNext() {
    console.log('Entering navigation Method:');
    this[NavigationMixin.Navigate]({
        /*type: 'standard__navItemPage',
        attributes: {
            apiName: "Alert_Record_Pg",
        },*/
        type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: 'Alert__c', // objectApiName is optional
                actionName: 'view'
            }
    });
}

}