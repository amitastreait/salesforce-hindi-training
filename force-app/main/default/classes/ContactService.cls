public with sharing class ContactService {
    
    @AuraEnabled(cacheable=true) // Read-Only
    public static void helloWorld(){
        // Can not Make DML
        Account accRecord = new Account(Name = 'HGHJGSD');
        insert accRecord;
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(String recordId, String firstName){
        // 10 contact
        List<Contact> contactList = [ SELECT Id, Name, Email, Phone, AccountId, Account.Name FROM Contact WHERE AccountId =: recordId LIMIT 10 ];
        return contactList;
    }

    @AuraEnabled
    public static void mapDemo(String params){
        Map<String, Object> wrapper = (Map<String, Object>)System.JSON.deserializeUntyped(params); // Object
        System.debug(wrapper);
        System.System.debug( JSON.serializePretty(wrapper) );
    }

    public class ContactWrapper {
        @AuraEnabled
        public String FirstName { get; set; }
        @AuraEnabled
        public String LastName { get; set; }
        @AuraEnabled
        public String Email { get; set; }
        @AuraEnabled
        public String Title { get; set; }
        @AuraEnabled
        public Integer Age { get; set; }
        @AuraEnabled
        public Decimal Salary { get; set; }
        @AuraEnabled
        public String AccountId { get; set; }
        @AuraEnabled
        public String Address { get; set; }
        @AuraEnabled
        public String Phone { get; set; }
        @AuraEnabled
        public String Fax { get; set; }
    }

    /*
    public class ContactWrapper {
        @AuraEnabled
        public String FirstName         { get; set; }
        @AuraEnabled
        public String LastName          { get; set; }
        @AuraEnabled
        public String Email             { get; set; }
        @AuraEnabled
        public String Title             { get; set; }
        @AuraEnabled
        public Integer Age              { get; set; }
        @AuraEnabled
        public Decimal Salary           { get; set; }
        @AuraEnabled
        public String AccountId         { get; set; }
        @AuraEnabled
        public String Address           { get; set; }
        @AuraEnabled
        public String Phone             { get; set; }
        @AuraEnabled
        public String Fax               { get; set; }
    }
    */
}