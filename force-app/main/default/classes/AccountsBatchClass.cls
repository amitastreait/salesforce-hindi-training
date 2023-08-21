public class AccountsBatchClass implements Database.Batchable<sObject> {

    /*
       AccountsBatchClass batchJob = new AccountsBatchClass('abc');
	   Id jobId = Database.executeBatch(batchJob, 1);
     */ 
    private String rating;
    public AccountsBatchClass(String rating, List<Account> accountList, CaseTriggerHandler handler){// Integer, Decimal, List, Set, Custom Class, Anything
        this.rating = rating;
    }
    public AccountsBatchClass(String rating){// Integer, Decimal, List, Set, Custom Class, Anything
        this.rating = rating;
    }
    public AccountsBatchClass(List<Account> accountList){// Integer, Decimal, List, Set, Custom Class, Anything
        this.rating = rating;
    }
    public AccountsBatchClass(CaseTriggerHandler handler){// Integer, Decimal, List, Set, Custom Class, Anything
        this.rating = rating;
    }
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        System.debug('Start Method');
        return Database.getQueryLocator('SELECT Id, Name FROM Account WHERE Rating =:rating LIMIT 1000000');
    }
    
    public void execute(Database.BatchableContext batchContext, List<sObject> sObjectList){
        List<Account> accountList = (List<Account>)sObjectList;
        System.debug('Execute Method '+accountList);
    }
    // 100K Records - 10K records can be processed at once in Single Batch Apex
    // 10 Batch
    // 200K Records
    // 20 Batch
    // 
    public void finish(Database.BatchableContext batchContext){
        System.debug('Finish Method');
        // Certatin Condition batch recursivily call
        // Conditional Statement
        // Total Records != Total Processed Record then call batch apex otherwise exit
        ContactsBatchClass batchJob = new ContactsBatchClass();
        Id jobId = Database.executeBatch(batchJob, 1);
    }
    
}