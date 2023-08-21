public with sharing class DataTableController {
    
@AuraEnabled(cacheable=true)
public static List<Contact> getContactList(){
    List<Contact> lstcon=new List<contact>();
    try {
 
    lstcon=[SELECT id,FirstName,LastName,Phone,AccountId,Account.Name FROM contact LIMIT 10];
    system.debug('lstcon-->'+lstcon);
   
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
    return lstcon;
}
  
}