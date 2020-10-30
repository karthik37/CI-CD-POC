public class AMLGetCustomerPicklistValues {
 @AuraEnabled(Cacheable=true)
    public static List<String> getPicklists() {

     List<String> strList = new List<String>();
      String strY = 'Y';
      String strN = 'N';
      String str = ''; 
       
      strList.add(strY);
      strList.add(strN);
      strList.add(str); 
        
      system.debug('payment entity'+strList);  
        
      return strList;
        /*List<Schema.RecordTypeInfo> RT = getRecordTypeInfos();
system.debug('RT==>'+RT);
list<string> recordtypeList = new List<string>();
for(Schema.RecordTypeInfo recordtypeName: RT){
    if(recordtypeName.getName() != 'Master')
    recordtypeList.add(recordtypeName.getName());
}
system.debug('recordtypeList==>'+recordtypeList);
      
        return recordtypeList;
    }*/
}
}