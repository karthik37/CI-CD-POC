import { LightningElement, api, wire,track } from 'lwc';

import getAlertedEntity from '@salesforce/apex/AlertedEntityOnCustomerController.getAlertedEntity';

export default class AML_AlertedEntity extends LightningElement {
greeting = 'World';
alertEntities;

@api recordId;
@wire(getAlertedEntity, { customerId: '$recordId' })
AlertedEntity({ error, data }) {
    if (data) {
        console.log('data==>',data);
        this.alertEntities = data;
        console.log('this.alertEntityRec==>',this.alertEntities);
        
    } else if (error) {
        this.alertEntities = undefined;
        throw new Error('Failed to retrieve session');
    }
    }
    
}