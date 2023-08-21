@IsTest
public class AccountsQueueableTest {

    @TestSetup
    private static void prepareData(){
        List<Account> accountRecordList = new List<Account>();
        for(Integer i=0; i < 100; i++){
            Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
            Account acc = new Account(
            	Name = 'TEST ACCOUNT '+randomInt, Industry = 'Education',
                Phone = '778763445',
                Rating = 'Hot'
            );
            accountRecordList.add(acc);
        }
        insert accountRecordList;
    }
    
    @IsTest
    private static void executeTest(){
        // Data Setup
        /*List<Account> accountList = [SELECT Id FROM Account WHERE Name Like 'TEST ACCOUNT %' LIMIT 100];
        Set<Id> accountIdsSet = new Set<Id>();
        for(Account acc: [SELECT Id FROM Account WHERE Name Like 'TEST ACCOUNT %' LIMIT 100]){
            accountIdsSet.add(acc.Id);
        }*/
        
        Map<Id, Account> accountMap = new Map<Id, Account>([
            SELECT Id, Name, Industry, Phone, Rating FROM Account WHERE Name Like 'TEST ACCOUNT %' LIMIT 100
        ]);
        
        Test.startTest();
        AccountsQueueable queueable = new AccountsQueueable(accountMap.keySet());
        Id jobId = System.enqueueJob(queueable);
        System.debug('Job Id - '+ jobId);
        Test.stopTest();
        
        AsyncApexJob apexJob = [SELECT Id, Status FROM AsyncApexJob WHERE Id =: jobId];
        Assert.isNotNull(apexJob);
        Assert.areEqual('Completed', apexJob.Status, 'Queueable Job is not completed!');
        
        Map<Id, Account> accountMapAfterQueueable = new Map<Id, Account>([
            SELECT Id, Name, Industry, Phone, Rating, Description
            	FROM Account
            	WHERE Name Like 'TEST ACCOUNT %' 
            LIMIT 100
        ]);
        Assert.areEqual(100, accountMapAfterQueueable.size(), 'There are more than 100 account records');
        for(Account acc: accountMapAfterQueueable.values()){
            Assert.areEqual(acc.Name + ' '+ acc.Phone, acc.Description, 'Account Descrtipion is not matching');
        }
    }
}