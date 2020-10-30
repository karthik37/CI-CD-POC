import { LightningElement,track,wire,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getAlertList from'@salesforce/apex/AML_AlertEscalationFromCase.getAlertList';
import updateCase from'@salesforce/apex/AML_AlertEscalationFromCase.updateCase';
import { refreshApex } from '@salesforce/apex';
import { NavigationMixin } from 'lightning/navigation';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'

export default class AmlAlertEscalationFromCase extends LightningElement {
@api recordId;
@track selectedAlert='';

@track columns = [
{label:'Alert Number',fieldName:'Name',type:'number',sortable: true},
{label:'Alert Category',fieldName:'Alert_Category_CD__c',type:'text',sortable: true},
{label:'Alert Sub Category',fieldName:'Alert_Subcategory_CD__c',type:'text',sortable: true},
{label:'Status',fieldName:'Status__c',type:'text',sortable: true},
{label:'Alert Date',fieldName:'Alert_Date__c',type:'date',sortable: true}
];
@wire(getAlertList,{
caserecId:'$recordId'
}) alerts;

handleRowSelection = event => {
    var selectedRows=event.detail.selectedRows;

     if(selectedRows)
    {
        var el = this.template.querySelector('lightning-datatable');
        selectedRows=el.selectedRows;
        console.log('selectedRows2:' + selectedRows);
        this.selectedAlert = selectedRows;
        event.preventDefault();
        //return ;
    }
    
}

handleCaseEscalation(){

    console.log('Entering Case escalation Method:');
    console.log('this.selectedAlert:' + this.selectedAlert);
    console.log('recordId:' + this.recordId);
    if(this.selectedAlert !== ''){
    updateCase({
        caserecId : this.recordId,
        alertIds : this.selectedAlert
    })
        .then(() => {
            refreshApex(this.alerts)
            eval("$A.get('e.force:refreshView').fire();")
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Case Updated Sucessfully',
                    message: 'Selected Alerts has been Escalated into the Case-->',
                    variant: 'success'
                }),
            );
        })

    .catch((error) => {
        this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Selected Alerts Were not escalated',
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
        message: 'Please Select few Alerts to Escalate to Case',
    });
    this.dispatchEvent(event);
}

}

}