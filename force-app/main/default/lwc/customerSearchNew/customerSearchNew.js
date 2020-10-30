import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountSearch.getAccounts';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
export default class CustomerSearchNew extends LightningElement {

    accountName='';
    paymentEntity='';
    businessName='';
    ebayEmployee='';
    recordType='';
    @track accountList =[];

    handleSearch() {
        debugger;
        // if search input value is not blank then call apex method, else display error msg 
       //Only User Name
        if (this.accountName !== '') {
            debugger;
            console.log(this.accountName);
            getAccounts({
                actName: this.accountName
                    
                })
                .then(result => {
                    this.accountList = result;
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
        
        //Only Payment Entity
        if (this.paymentEntity !== '') {
            debugger;
            console.log(this.paymentEntity);
            getAccounts({
                payen: this.paymentEntity
                    
                })
                .then(result => {
                    this.accountList = result;
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
        
        //Only business Name
        if (this.businessName !== '') {
            debugger;
            console.log(this.businessName);
            getAccounts({
                busname: this.businessName
                    
                })
                .then(result => {
                    this.accountList = result;
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

        //Only ebayEmployee 
        if (this.ebayEmployee !== '') {
            debugger;
            console.log(this.ebayEmployee);
            getAccounts({
                ebayemp: this.ebayEmployee
                    
                })
                .then(result => {
                    this.accountList = result;
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

         //Only RecordType 
         if (this.recordType !== '') {
            debugger;
            console.log(this.recordType);
            getAccounts({
                recType: this.recordType
                    
                })
                .then(result => {
                    this.accountList = result;
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

        //both User name and Payment entity
        if (this.accountName !== '' && this.paymentEntity !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.paymentEntity);
            getAccounts({
                actName: this.accountName,
                payen: this.paymentEntity
                    
                })
                .then(result => {
                    this.accountList = result;
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
        
         //both User name and Business Name
         if (this.accountName !== '' && this.businessName !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.businessName);
            getAccounts({
                actName: this.accountName,
                busname: this.businessName
                    
                })
                .then(result => {
                    this.accountList = result;
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

         //both User name and ebay Employee Indicator
         if (this.accountName !== '' && this.ebayEmployee !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.ebayEmployee);
            getAccounts({
                actName: this.accountName,
                ebayemp: this.ebayEmployee
                    
                })
                .then(result => {
                    this.accountList = result;
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

         //both User name and Record Type
         if (this.accountName !== '' && this.recordType !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.recordType);
            getAccounts({
                actName: this.accountName,
                recType: this.recordType
                    
                })
                .then(result => {
                    this.accountList = result;
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

        //both Business name and payment Entity
        if (this.businessName !== '' && this.paymentEntity !== '') {
            debugger;
            console.log(this.businessName);
            console.log(this.paymentEntity);
            getAccounts({
                busname: this.businessName,
                payen: this.paymentEntity
                    
                })
                .then(result => {
                    this.accountList = result;
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

        //both Business name and ebay Employee Indicator
        if (this.businessName !== '' && this.ebayEmployee !== '') {
            debugger;
            console.log(this.businessName);
            console.log(this.ebayEmployee);
            getAccounts({
                busname: this.businessName,
                ebayemp: this.ebayEmployee
                    
                })
                .then(result => {
                    this.accountList = result;
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

        //both Business name and Record Type
        if (this.businessName !== '' && this.recordType !== '') {
            debugger;
            console.log(this.businessName);
            console.log(this.recordType);
            getAccounts({
                busname: this.businessName,
                recType: this.recordType
                    
                })
                .then(result => {
                    this.accountList = result;
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

        //both Payment Entity  and ebay Employee
        if (this.paymentEntity !== '' && this.ebayEmployee !== '') {
            debugger;
            console.log(this.paymentEntity);
            console.log(this.ebayEmployee);
            getAccounts({
                payen: this.paymentEntity,
                ebayemp: this.ebayEmployee
                    
                })
                .then(result => {
                    this.accountList = result;
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

        //both Payment Entity and Record Type
        if (this.paymentEntity !== '' && this.recordType !== '') {
            debugger;
            console.log(this.paymentEntity);
            console.log(this.recordType);
            getAccounts({
                payen: this.paymentEntity,
                recType: this.recordType
                    
                })
                .then(result => {
                    this.accountList = result;
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

        //both Ebay Employee Indicator and Record Type
        if (this.ebayEmployee !== '' && this.recordType !== '') {
            debugger;
            console.log(this.ebayEmployee);
            console.log(this.recordType);
            getAccounts({
                ebayemp: this.ebayEmployee,
                recType: this.recordType
                    
                })
                .then(result => {
                    this.accountList = result;
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

        //three User name , Payment entity and Business Name
        if (this.accountName !== '' && this.paymentEntity !== '' && this.businessName !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.paymentEntity);
            console.log(this.businessName);
            getAccounts({
                actName: this.accountName,
                payen: this.paymentEntity,
                busname: this.businessName    
                })
                .then(result => {
                    this.accountList = result;
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
        
        //three User name , Business Name and Record Type
        if (this.accountName !== '' && this.recordType !== '' && this.businessName !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.recordType);
            console.log(this.businessName);
            getAccounts({
                actName: this.accountName,
                recType: this.recordType,
                busname: this.businessName    
                })
                .then(result => {
                    this.accountList = result;
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
        
        //three User name,  Business Name and ebay Employee indicator
        if (this.accountName !== '' && this.ebayEmployee !== '' && this.businessName !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.ebayEmployee);
            console.log(this.businessName);
            getAccounts({
                actName: this.accountName,
                ebayemp: this.ebayEmployee,
                busname: this.businessName    
                })
                .then(result => {
                    this.accountList = result;
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

        //three User name, Payment Entity  and Record Type
        if (this.accountName !== '' && this.paymentEntity !== '' && this.recordType !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.paymentEntity);
            console.log(this.recordType);
            getAccounts({
                actName: this.accountName,
                payen: this.paymentEntity,
                recType: this.recordType    
                })
                .then(result => {
                    this.accountList = result;
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

        //three User name, Payment Entity  and Ebay Employee Indicator
        if (this.accountName !== '' && this.paymentEntity !== '' && this.ebayEmployee !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.paymentEntity);
            console.log(this.ebayEmployee);
            getAccounts({
                actName: this.accountName,
                payen: this.paymentEntity,
                ebayemp: this.ebayEmployee    
                })
                .then(result => {
                    this.accountList = result;
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

        //three User name,  Record Type and Ebay Employee Indicator
        if (this.accountName !== '' && this.ebayEmployee !== '' && this.recordType !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.ebayEmployee);
            console.log(this.recordType);
            getAccounts({
                actName: this.accountName,
                ebayemp: this.ebayEmployee,
                recType: this.recordType    
                })
                .then(result => {
                    this.accountList = result;
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
        
        //three Business Name, Payment Entity  and Record Type
        if (this.businessName !== '' && this.paymentEntity !== '' && this.recordType !== '') {
            debugger;
            console.log(this.businessName);
            console.log(this.paymentEntity);
            console.log(this.recordType);
            getAccounts({
                busname: this.businessName,
                payen: this.paymentEntity,
                recType: this.recordType    
                })
                .then(result => {
                    this.accountList = result;
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

        //three Business name, Payment Entity  and ebay Employee
        if (this.businessName !== '' && this.paymentEntity !== '' && this.ebayEmployee !== '') {
            debugger;
            console.log(this.businessName);
            console.log(this.paymentEntity);
            console.log(this.ebayEmployee);
            getAccounts({
                busname: this.businessName,
                payen: this.paymentEntity,
                ebayemp: this.ebayEmployee    
                })
                .then(result => {
                    this.accountList = result;
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
        
        //three Business Name, Record Type and Ebay Employee
        if (this.businessName !== '' && this.ebayEmployee !== '' && this.recordType !== '') {
            debugger;
            console.log(this.businessName);
            console.log(this.ebayEmployee);
            console.log(this.recordType);
            getAccounts({
                busname: this.businessName,
                ebayemp: this.ebayEmployee,
                recType: this.recordType    
                })
                .then(result => {
                    this.accountList = result;
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

        //three Payment Entity, Record Type and Ebay Empployee Indicator
        if (this.accountName !== '' && this.paymentEntity !== '' && this.recordType !== '') {
            debugger;
            console.log(this.ebayEmployee);
            console.log(this.paymentEntity);
            console.log(this.recordType);
            getAccounts({
                ebayemp: this.ebayEmployee,
                payen: this.paymentEntity,
                recType: this.recordType    
                })
                .then(result => {
                    this.accountList = result;
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
        
        //All four User name , Payment entity, Business Name and ebayEmployee Indicator
        if (this.accountName !== '' && this.paymentEntity !== '' && this.businessName !== '' && this.ebayEmployee !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.paymentEntity);
            console.log(this.businessName);
            console.log(this.ebayEmployee);
            getAccounts({
                actName: this.accountName,
                payen: this.paymentEntity,
                busname: this.businessName,
                ebayemp: this.ebayEmployee    
                })
                .then(result => {
                    this.accountList = result;
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
        
        //All four User name , Payment entity, Business Name and Record Type
        if (this.accountName !== '' && this.paymentEntity !== '' && this.businessName !== '' && this.recordType !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.paymentEntity);
            console.log(this.businessName);
            console.log(this.recordType);
            getAccounts({
                actName: this.accountName,
                payen: this.paymentEntity,
                busname: this.businessName,
                recType: this.recordType    
                })
                .then(result => {
                    this.accountList = result;
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

        //All four User name , Business Name, Record Type and ebayEmployee Indicator
        if (this.accountName !== '' && this.recordType !== '' && this.businessName !== '' && this.ebayEmployee !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.recordType);
            console.log(this.businessName);
            console.log(this.ebayEmployee);
            getAccounts({
                actName: this.accountName,
                recType: this.recordType,
                busname: this.businessName,
                ebayemp: this.ebayEmployee    
                })
                .then(result => {
                    this.accountList = result;
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

        //All four User name , Payment entity, Record Type and ebayEmployee Indicator
        if (this.accountName !== '' && this.paymentEntity !== '' && this.recordType !== '' && this.ebayEmployee !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.paymentEntity);
            console.log(this.recordType);
            console.log(this.ebayEmployee);
            getAccounts({
                actName: this.accountName,
                payen: this.paymentEntity,
                recType: this.recordType,
                ebayemp: this.ebayEmployee    
                })
                .then(result => {
                    this.accountList = result;
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

        //All four Business name , Payment entity, Record Type and ebayEmployee Indicator
        if (this.businessName !== '' && this.paymentEntity !== '' && this.recordType !== '' && this.ebayEmployee !== '') {
            debugger;
            console.log(this.businessName);
            console.log(this.paymentEntity);
            console.log(this.recordType);
            console.log(this.ebayEmployee);
            getAccounts({
                busname: this.businessName,
                payen: this.paymentEntity,
                recType: this.recordType,
                ebayemp: this.ebayEmployee    
                })
                .then(result => {
                    this.accountList = result;
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

        //All five User name , Payment entity, Business Name, ebayEmployee Indicator and Record Type
        if (this.accountName !== '' && this.paymentEntity !== '' && this.businessName !== '' && this.ebayEmployee !== '' && this.recordType !== '') {
            debugger;
            console.log(this.accountName);
            console.log(this.paymentEntity);
            console.log(this.businessName);
            console.log(this.ebayEmployee);
            console.log(this.recordType);
            getAccounts({
                actName: this.accountName,
                payen: this.paymentEntity,
                busname: this.businessName,
                ebayemp: this.ebayEmployee,
                recType: this.recordType    
                })
                .then(result => {
                    this.accountList = result;
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
        }else if(this.paymentEntity === '' && this.accountName === '' && this.businessName === '' && this.ebayEmployee === '' && this.recordType === '') {
            // fire toast event if input field is blank
            const event = new ShowToastEvent({
                variant: 'error',
                message: 'Search text missing..',
            });
            this.dispatchEvent(event);
        }
}

updateSeachKey(event){
    this.accountName =event.target.value;
}

updateSearchKey(event){
    this.paymentEntity =event.target.value;
}

updateBusinessName(event){
this.businessName =event.target.value;
}

updateEbayEmployee(event){
    this.ebayEmployee =event.target.value;
}

updateRecordType(event){
    this.recordType = event.target.value;
}
}