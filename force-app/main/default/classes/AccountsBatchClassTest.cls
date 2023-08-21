@IsTest
public class AccountsBatchClassTest {

    @TestSetup
    private static void prepareData(){
        List<Account> accountList = new List<Account>();
        for(Integer i=0; i < 2000; i++){
            Integer randomInt = Integer.valueOf(math.rint(math.random()*23430000));
            Account acc = new Account(
                Name = 'TEST ACCOUNT '+randomInt+' '+i, Industry = 'Education',
                Phone = '778763445',
                Rating = 'Hot'
            );
            accountList.add(acc);
        }
        insert accountList;
    }
    
    @IsTest
    private static void accountBatchTest(){
        Test.startTest();
        // Call the batch Apex
        AccountsBatchClass batchJob = new AccountsBatchClass('Hot');
        Id jobId = Database.executeBatch(batchJob, 2000);
        Test.stopTest();
        AsyncApexJob apexJob = [SELECT Id, Status FROM AsyncApexJob WHERE Id =: jobId];
        Assert.isNotNull(apexJob);
        Assert.areEqual('Completed', apexJob.Status, 'Batch Job is not completed!');
    }
    
    @IsTest
    private static void accountBatchTest1(){
        List<Account> accountList = [SELECT Id, Name, Phone FROM Account LIMIT 2000];
        Test.startTest();
        AccountsBatchClass batchJob = new AccountsBatchClass('Hot', accountList, new CaseTriggerHandler());
        Id jobId = Database.executeBatch(batchJob, 2000);
        Test.stopTest();
        AsyncApexJob apexJob = [SELECT Id, Status FROM AsyncApexJob WHERE Id =: jobId];
        Assert.isNotNull(apexJob);
        Assert.areEqual('Completed', apexJob.Status, 'Batch Job is not completed!');
    }
    
    @IsTest
    private static void accountBatchTest2(){
        List<Account> accountList = [SELECT Id, Name, Phone FROM Account LIMIT 2000];
        Test.startTest();
        AccountsBatchClass batchJob = new AccountsBatchClass(accountList);
        Id jobId = Database.executeBatch(batchJob, 2000);
        Test.stopTest();
        AsyncApexJob apexJob = [SELECT Id, Status FROM AsyncApexJob WHERE Id =: jobId];
        Assert.isNotNull(apexJob);
        Assert.areEqual('Completed', apexJob.Status, 'Batch Job is not completed!');
    }
    
    @IsTest
    private static void accountBatchTest3(){
        List<Account> accountList = [SELECT Id, Name, Phone FROM Account LIMIT 2000];
        Test.startTest();
        AccountsBatchClass batchJob = new AccountsBatchClass(new CaseTriggerHandler());
        Id jobId = Database.executeBatch(batchJob, 2000);
        Test.stopTest();
        AsyncApexJob apexJob = [SELECT Id, Status FROM AsyncApexJob WHERE Id =: jobId];
        Assert.isNotNull(apexJob);
        Assert.areEqual('Completed', apexJob.Status, 'Batch Job is not completed!');
    }
}