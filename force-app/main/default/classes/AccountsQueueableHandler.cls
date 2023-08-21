public class AccountsQueueableHandler {

    public static Account prepareAccount(Set<Id> accountIdsSet){ // 5000 Records
        
        Account accountRecord = new Account();
        
        System.debug('Queueable Executed!');
        List<Account> accountRecordList = [SELECT Id, Name, Description, Phone
                                           FROM Account
                                           WHERE Id IN:accountIdsSet
                                           AND Rating = 'Hot'
                                          ];
        System.debug(' accountList '+accountRecordList);
        for(Account acc : accountRecordList){
            acc.Description = acc.Name + ' '+ acc.Phone;
        }
        
        update accountRecordList;
       	
        
       	ContactsQueueable queueable = new ContactsQueueable(10, accountRecordList);
        if(Test.isRunningTest() == false){
            Id jobId = System.enqueueJob(queueable);
        }
        
        FutureMethodDemo.method2();
        FutureMethodDemo.method3();
        
        // A --> B --> C --> D --> C
        return accountRecord;
    }
}