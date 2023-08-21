@IsTest(seeAllData=false)
public class AccountTriggerTest {
    
    @TestSetup
    private static void setupData(){
        List<Account> accountList = new List<Account>();
        
        // Minimun 200 Records
        for(Integer i=0; i<200; i++){
            Account accountRecord = new Account();
            accountRecord.Name = 'Test Account '+i;
            accountRecord.Phone = '9087654321';
            accountList.add(accountRecord);   
        }
        // accountList.size() == 200
        Account accountRecord1 = new Account();
        accountRecord1.Name = 'Test Account';
        accountRecord1.Phone = '9087654321';
        accountRecord1.ShippingStreet = '123 Main Street';
        accountList.add(accountRecord1);
        
        Account accountRecord2 = new Account();
        accountRecord2.Name = 'Test Account';
        //accountRecord2.Phone = '9087654321';
        accountRecord2.ShippingStreet = '123 Main Street';
        accountRecord2.ShippingCity = 'Florida';
        accountList.add(accountRecord2);
        
        insert accountList;
    }
    
    @IsTest
    private static void beforeInsertTest(){
        
        Account accountRecord3 = new Account();
        accountRecord3.Name = 'Test Account';
        accountRecord3.ShippingStreet = '123 Main Street';
        accountRecord3.ShippingCity = 'Florida';
        // Outcome - Duplicate Account - Veried
        Test.startTest();
            try{
                insert accountRecord3;
            }catch(System.DmlException ex){
                System.debug('Exception Found!');
            }
        Test.stopTest();
        List<Account> accountList = [SELECT Id FROM Account WHERE Phone = null AND Industry = null LIMIT 500];
        // 2 - Account
        // 2 - Task
        Integer length = accountList.size();
        List<Task> taskList = [SELECT Id FROM Task LIMIT 500];
        Assert.areEqual(length, taskList.size(), 'Tasks are not equal to no of Account having Phone = null AND Industry = null');
    }
    
    @IsTest
    private static void beforeUpdateTest(){
        List<Account> accountList = [SELECT Id, Name, Rating, Industry, Phone, Description 
                                     FROM 
                                     	Account 
                                     WHERE
                                     	Name = 'Test Account'
                                     LIMIT 
                                     	500
                                   ];
        Test.startTest();
            update accountList;
        Test.stopTest();
        
        // Outcome: Payment record is being created
        List<Payment__c> paymentList = [SELECT Id From Payment__c LIMIT 100];
        Assert.isNotNull(paymentList, 'Payment record is not being created');
        Assert.areEqual(1, paymentList.size(), 'Either 0 Payment Record or more than 1 Payment record are being created!');
        Assert.isTrue(1 == paymentList.size(), 'Either 0 Payment Record or more than 1 Payment record are being created!');
    }
    @IsTest
    private static void beforeDeleteTest(){
        List<Account> accountList = [SELECT Id, Name, Rating, Industry, Phone, Description FROM Account LIMIT 500];
        Test.startTest();
        delete accountList;
        Test.stopTest();
    }
    
    @IsTest
    private static void afterUnDeleteTest(){
        List<Account> accountList = [SELECT Id, Name, Rating, Industry, Phone, Description FROM Account LIMIT 500];
        delete accountList;
        Test.startTest();
        undelete accountList;
        Test.stopTest();
    }
    
    @IsTest
    private static void handleTest(){
        List<Account> accountList = [SELECT Id, Name, Rating, Industry, Phone, Description FROM Account LIMIT 500];
        Test.startTest(); // Test Started
            AccountTriggerHandler.handleTest();
        Test.stopTest();
    }
}