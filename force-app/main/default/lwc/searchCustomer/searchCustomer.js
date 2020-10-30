import { LightningElement, track } from 'lwc';
//import getAccounts from'@salesforce/apex/AccountSearch.getAccounts';
import serachAccs from '@salesforce/apex/AccountSearch.retriveAccs';
const columns = [
    {
        label: 'Name',
        fieldName: 'AccName',
        type: 'url',
        typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}
    }, {
        label: 'Industry',
        fieldName: 'Industry',
    }, {
        label: 'Phone',
        fieldName: 'Phone',
        type: 'phone',
    }, {
        label: 'Type',
        fieldName: 'Type',
        type: 'text'
    },
];
export default class SearchCustomer extends LightningElement {
   /* accountName='';
    @track accountList =[];
    @wire(getAccounts,{actName: '$accountName'})
    retriveAccounts({error,data}){
        if(data){
            this.accountList = data;
        }
        else if(error){

        }
    }
    handelKeyChange(event){
        this.accountName =event.target.value;
    }*/
    @track searchData;
    @track columns = columns;
    @track errorMsg = '';
    strSearchAccName = '';
    

    handleAccountName(event) {
        this.strSearchAccName = event.detail.value;
    }

    handleSearch() {
        debugger;
        if(!this.strSearchAccName) {
            debugger;
            console.log(strSearchAccName);
            this.errorMsg = 'Please enter account name to search.';
            this.searchData = undefined;
            return;
        }

        serachAccs({strAccName : this.strSearchAccName})
        .then(result => {
            result.forEach((record) => {
                record.AccName = '/' + record.Id;
            });

            this.searchData = result;
            debugger;
            console.log(searchData);
            
        })
        .catch(error => {
            this.searchData = undefined;
            window.console.log('error =====> '+JSON.stringify(error));
            if(error) {
                this.errorMsg = error.body.message;
            }
        }) 
    } 
}