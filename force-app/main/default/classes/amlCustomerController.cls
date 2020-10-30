public class amlCustomerController {

    @AuraEnabled(cacheable=true)
    public static String getCustomer(string searchKey, string searchKey1, string searchKey2, string searchKey3, string searchKey4) {
       
        //if(searchKey != null || searchKey != ''){
        String Str = 'https://ebaydev--dev.lightning.force.com/lightning/r/Report/00O01000000VHgEEAW/view?queryScope=userFolders&fv0=';
        String Str2 = '&fv1=';
        String Str3 = '&fv2=';
        String Str4 = '&fv3=';
        String Str5 = '&fv4=';
        String Str1 = Str + searchKey + Str2 + searchKey1 + Str3 + searchKey2 + Str4 + searchKey3 + Str5 + searchKey4 ;
        //String Final = '';
        System.debug(Str1);
            
        return Str1;
        //}
       // return Str1;
    }
    
}