import {LightningElement,track,wire,api} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getTransactionList from '@salesforce/apex/TransactionBoController.fetchTransactions';
const columns = [{
        label: 'Seller oracle Id',
        fieldName: 'Seller_Oracle_id__c',
        type: 'text'
    },
    {
        label: 'Transaction Reference Number',
        fieldName: 'Transaction_Reference_Number__c',
        type: 'text'
    },
    {
        label: 'Buyer Oracle Id',
        fieldName: 'Buyer_Oracle_Id__c',
        type: 'text'
    },
    {
        label: 'Transaction Date',
        fieldName: 'Transaction_Date__c',
        type: 'date'
    },
    {
        label: 'Transaction USD Amount',
        fieldName: 'Transaction_USD_Amount__c',
        type: 'number'
    },
    {
        label: 'Transaction Currency Amount',
        fieldName: 'Transaction_Currency_Amount__c',
        type: 'number'
    }
];
 
export default class transactionSearchCmp extends LightningElement {
 /* @api recordId;
@track columns = [{label:'Seller Oracle Id',fieldName:'Seller_Oracle_id__c',type:'text',sortable: true},
{label:'Buyer Oracle Id',fieldName:'Buyer_Oracle_Id__c',type:'text',sortable: true},
{label:'Transaction Reference Number',fieldName:'Transaction_Reference_Number__c',type:'text',sortable: true},
{label:'Transaction Date',fieldName:'Transaction_Date__c',type:'date',sortable: true},
{label:'Transaction Currency Amount',fieldName:'Transaction_Currency_Amount__c',type:'number',sortable: true},
{label:'Transaction USD Amount',fieldName:'Transaction_USD_Amount__c',type:'number',sortable: true}
];

    @wire(getTransactionList,{
        accId:'$recordId'
        })transactions;*/
    data = [];
    @track page = 1;
    perpage = 5;
    @track pages = [];
    set_size = 5;
    columns = columns
    renderedCallback() {
        this.renderButtons();
    }
    renderButtons = () => {
        this.template.querySelectorAll('button').forEach((but) => {
            but.style.backgroundColor = this.page === parseInt(but.dataset.id, 10) ? 'dodgerblue' : 'white';
            but.style.color = this.page === parseInt(but.dataset.id, 10) ? 'white' : 'black';
        });
    }
    get pagesList() {
        let mid = Math.floor(this.set_size / 2) + 1;
        if (this.page > mid) {
            return this.pages.slice(this.page - mid, this.page + mid - 1);
        }
        return this.pages.slice(0, this.set_size);
    }
    async connectedCallback() {
        this.data = await getTransactionList();
        this.setPages(this.data);
    }
    pageData = () => {
        let page = this.page;
        let perpage = this.perpage;
        let startIndex = (page * perpage) - perpage;
        let endIndex = (page * perpage);
        return this.data.slice(startIndex, endIndex);
    }
    setPages = (data) => {
        let numberOfPages = Math.ceil(data.length / this.perpage);
        for (let index = 1; index <= numberOfPages; index++) {
            this.pages.push(index);
        }
    }
    get hasPrev() {
        return this.page > 1;
    }
    get hasNext() {
        return this.page < this.pages.length
    }
    onNext = () => {
        ++this.page;
    }
    onPrev = () => {
        --this.page;
    }
    onPageClick = (e) => {
        this.page = parseInt(e.target.dataset.id, 10);
    }
    get currentPageData() {
        return this.pageData();
    }
}