global class AccountsQueueable implements System.Queueable {
    
    public Set<Id> accountIdsSet;
    public AccountsQueueable(Set<Id> accountIdsSet){
        this.accountIdsSet = accountIdsSet;
    }
    
    // ID jobID = System.enqueueJob( new AccountQueueable() ); 
    global void execute(System.QueueableContext ctx){
        AccountsQueueableHandler.prepareAccount(this.accountIdsSet);
    }
    /* Future Limitations */
    // 1. Can not be tracked or monitored
    // 2. Can not pass NoN-Premitive Data Types
    // 3. Future is not allowed from Future
}