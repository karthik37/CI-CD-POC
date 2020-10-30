import {LightningElement, api, track, wire} from 'lwc';
import {getPicklistValues, getObjectInfo} from 'lightning/uiObjectInfoApi';

export default class AMLReusablePicklistValueComponent extends LightningElement {@api objapiname;
    @api fieldapiname;
    @track options = [];
    // pick list label
    @track picklistlabel;
    @track error;

    recordTypeId;
    objfieldapiname;

    @wire(getObjectInfo, {objectApiName: '$objapiname'})
    objectInfo(result) {
        if(result.data) {
            // Field Data
            let fieldData = result.data.fields[this.fieldapiname];
            if(fieldData) {
                this.picklistlabel = fieldData.label;
            
                this.objfieldapiname = {};
                this.objfieldapiname.fieldapiname = fieldData.apiName;
                this.objfieldapiname.objectApiName = result.data.apiName;
    
                this.recordTypeId = result.data.defaultRecordTypeId;
            }
            else {
                this.error = 'Please enter valid field api name';
            }
        }
        else if(result.error) {
            this.error = JSON.stringify(result.error);
        }
    }
    
    @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldapiname: '$objfieldapiname'})
    picklistValues({error, data}) {
        if (data) {

            let picklistOptions = [{ label: '--None--', value: '--None--'}];

            // Picklist values
            data.values.forEach(key => {
                picklistOptions.push({
                    label: key.label, 
                    value: key.value
                })
            });

            this.options = picklistOptions;

        } else if (error) {
            this.error = JSON.stringify(error);
        }
    }


    handleValueChange(event) {
        this.selectedValue = event.target.value;
    }
}