@IsTest
public class ContactTriggerTest {

    private static FINAl Integer RECORD_COUNT = 200;
    
    @TestSetup
    private static void setupData(){
        // insert account
        Account accountRecord = TestUtility.prepareAccount('Rollup Summary Account', 'Cold');
        accountRecord.BillingStreet = '123 Street';
        insert accountRecord;
        
        List<Contact> contactList = TestUtility.prepareContact(RECORD_COUNT, 'Singh', accountRecord.Id, 'abc@gmail.com');
        
        insert contactList;
    }
    
    @IsTest
    private static void insertTest(){
        List<Account> accountList = [SELECT Id, Name, Number_of_Contacts__c, (SELECT Id FROM Contacts LIMIT 500) FROM Account 
                                     WHERE Name ='Rollup Summary Account'
                                     LIMIT 10
                                    ];
        Assert.isNotNull(accountList, 'There are not account record');
        for(Account acc : accountList){
            List<Contact> contactList = acc.Contacts;
            if(contactList != null && contactList.size() > 0){
             	Assert.areEqual(contactList.size(), acc.Number_of_Contacts__c, 'The total Contact count does not match!');   
            }
        }
        
        if(accountList!= null && accountList.size() > 0){
            Account accRecord = accountList.get(0);
            Assert.areEqual(RECORD_COUNT, accRecord.Number_of_Contacts__c, 'The total Contact count does not match!');
        }
    }
    
    @IsTest
    private static void updateTest(){
        
        Account accountRecord = TestUtility.prepareAccount('Summary Account', 'Cold');
        accountRecord.BillingStreet = '123 Street';
        insert accountRecord;
        
        List<Contact> contactList = [SELECT Id, Name FROM Contact WHERE Email = 'abc@gmail.com' LIMIT 10 ];
        for(Contact con: contactList){
            con.AccountId = accountRecord.Id;
        }
        // Rollup Summary Account - Count = 200
        // Summary Account = 0
        Test.startTest();
        update contactList;
        Test.stopTest();
        
        // Rollup Summary Account - Count = 200 - 10 = 190
        // Summary Account = 0 + 10 = 10
        
        List<Account> accountList = [SELECT Id, Name, Number_of_Contacts__c, (SELECT Id FROM Contacts LIMIT 500) FROM Account 
                                     WHERE Name ='Rollup Summary Account' OR Name = 'Summary Account'
                                     LIMIT 10
                                    ];
        Assert.isNotNull(accountList, 'There are not account record');
        for(Account acc : accountList){
            List<Contact> conList = acc.Contacts;
            if(conList != null && conList.size() > 0){
             	Assert.areEqual(conList.size(), acc.Number_of_Contacts__c, 'The total Contact count does not match!');   
            }
            if(acc.Name == 'Summary Account'){
                Assert.areEqual(10, acc.Number_of_Contacts__c, 'Summary Account: The total Contact count does not match!');
            }
            if(acc.Name == 'Rollup Summary Account'){
                Assert.areEqual(190, acc.Number_of_Contacts__c, 'Rollup Summary Account: The total Contact count does not match!');
            }
        }
    }
    
    @IsTest
    private static void updateFullRecordTest(){
        
        Account accountRecord = TestUtility.prepareAccount('Summary Account', 'Cold');
        accountRecord.BillingStreet = '123 Street';
        insert accountRecord;
        
        List<Contact> contactList = [SELECT Id, Name FROM Contact WHERE Email = 'abc@gmail.com' ];
        for(Contact con: contactList){
            con.AccountId = accountRecord.Id;
        }
        // Rollup Summary Account - Count = 200
        // Summary Account = 0
        Test.startTest();
        update contactList;
        Test.stopTest();
        
        // Rollup Summary Account - Count = 200 - 200 = 0
        // Summary Account = 0 + 200 = 200
        
        List<Account> accountList = [SELECT Id, Name, Number_of_Contacts__c, (SELECT Id FROM Contacts LIMIT 500) FROM Account 
                                     WHERE Name ='Rollup Summary Account' OR Name = 'Summary Account'
                                     LIMIT 10
                                    ];
        Assert.isNotNull(accountList, 'There are not account record');
        for(Account acc : accountList){
            if(acc.Name == 'Summary Account'){
                Assert.areEqual(RECORD_COUNT, acc.Number_of_Contacts__c, 'Summary Account: The total Contact count does not match!');
            }
            if(acc.Name == 'Rollup Summary Account'){
                Assert.areEqual(0, acc.Number_of_Contacts__c, 'Rollup Summary Account: The total Contact count does not match!');
            }
        }
    }
    
    @IsTest
    private static void deletedTest(){
        List<Contact> contactList = [SELECT Id, Name FROM Contact WHERE Email = 'abc@gmail.com'];
        Test.startTest();
        delete contactList;
        Test.stopTest();
        List<Account> accountList = [SELECT Id, Name, Number_of_Contacts__c, (SELECT Id FROM Contacts LIMIT 500) FROM Account 
                                     WHERE Name ='Rollup Summary Account'
                                     LIMIT 10
                                    ];
        Assert.isNotNull(accountList, 'There are not account record');
        for(Account acc : accountList){
            if(acc.Name == 'Rollup Summary Account'){
                Assert.areEqual(0, acc.Number_of_Contacts__c, 'The total Contact count does not match!');
            }
        }
    }
    
    @IsTest
    private static void unDeletedTest(){
        
        List<Contact> contactList = [SELECT Id, Name FROM Contact WHERE Email = 'abc@gmail.com'];
        delete contactList;
        
        List<Account> accountList = [SELECT Id, Name, Number_of_Contacts__c, (SELECT Id FROM Contacts LIMIT 500) FROM Account 
                                     WHERE Name ='Rollup Summary Account'
                                     LIMIT 10
                                    ];
        Assert.isNotNull(accountList, 'There are not account record');
        for(Account acc : accountList){
            if(acc.Name == 'Rollup Summary Account'){
                Assert.areEqual(0, acc.Number_of_Contacts__c, 'The total Contact count does not match!');
            }
        }
        
        Test.startTest();
        undelete contactList;
        Test.stopTest();
        
        List<Account> accountList1 = [SELECT Id, Name, Number_of_Contacts__c, (SELECT Id FROM Contacts LIMIT 500) FROM Account 
                                     WHERE Name ='Rollup Summary Account'
                                     LIMIT 10
                                    ];
        Assert.isNotNull(accountList1, 'There are not account record');
        for(Account acc : accountList1){
            if(acc.Name == 'Rollup Summary Account'){
                Assert.areEqual(RECORD_COUNT, acc.Number_of_Contacts__c, 'The total Contact count does not match!');
            }
        }
        
    }
    
}