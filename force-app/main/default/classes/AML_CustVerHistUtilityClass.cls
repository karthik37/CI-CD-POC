public class AML_CustVerHistUtilityClass {
    
    public static void createCustVerHistRec(Map<Id,Account> updatedCustMap){
       List<Customer_Revision__c> custHistList = new List<Customer_Revision__c>();
        for(Account customerRec: updatedCustMap.values()){
            system.debug('change detect3'+customerRec.RecordType.developerName);
            custHistList.add(new Customer_Revision__c(Customer__c=customerRec.Id,
                                                     Street__c=customerRec.BillingStreet ,
                                                     City__c=customerRec.BillingCity ,
                                                     State__c=customerRec.BillingState,
                                                     Country__c= customerRec.BillingCountry ,
                                                     Postal_Code__c=customerRec.BillingPostalCode,
                                                     First_Name__c=customerRec.FirstName,
                                                     Last_Name__c=customerRec.LastName,
                                                     RecordType__c=customerRec.RecordType.developerName,
                                                     User_name__c=customerRec.User_Name__c,
                                                     Business_Name__c=customerRec.Business_Name__c,
                                                     Payment_Entities__c=customerRec.Payment_Entities__c,
                                                     eBay_Employee_Indicator__c=customerRec.eBay_Employee_Indicator__c,
                                                     Occupation_Description__c=customerRec.Occupation_Description__c,
                                                     Nationality__c=customerRec.Nationality__c,
                                                     PEP_Status__c=customerRec.PEP_Status__c,
                                                     Registered_Site_ID__c = customerRec.Registered_Site_ID__c,
                                                     Primary_Contact_First_Name__c = customerRec.Primary_Contact_First_Name__c,
                                                     Primary_Contact_Last_Name__c = customerRec.Primary_Contact_Last_Name__c
                                                    
                                                    ));
            
        }
        Insert custHistList;
    }
   

}