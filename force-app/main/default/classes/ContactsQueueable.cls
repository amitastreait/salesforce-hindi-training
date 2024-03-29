public class ContactsQueueable implements System.Queueable, Database.allowsCallouts, System.Schedulable {
    public Integer numberOfContacts;
    public List<Account> accountList;
    
    public void execute(System.SchedulableContext sc){}
    
    public ContactsQueueable(Integer numberOfContacts, List<Account> accountList){
        this.numberOfContacts = numberOfContacts;
        this.accountList = accountList;
    }
    public void execute(System.QueueableContext ctx){
        System.debug('Contacts Queueable Executed!');
        Integer no = this.numberOfContacts;
		// Call Queueable Apex
		// Id jobId = System.enqueueJob(queueable); // Different Transaction
		FutureMethodDemo.method2();
        FutureMethodDemo.method3();
    }
}