public class ContactsBatchClassSchedulable implements System.Schedulable, Database.AllowsCallouts {

    // ContactsBatchClassSchedulable schedulable = new ContactsBatchClassSchedulable();
    // schedulable.execute();
    public void execute(System.SchedulableContext sc){
        // SOQL
		ContactsBatchClass batch = new ContactsBatchClass();
        Id jobId = Database.executeBatch(batch, 200);
        // DML
        // Call the normal Class
        // 
        AccountsBatchClass batchJob = new AccountsBatchClass('Hot');
        if(Test.isRunningTest() == false){
            Id jobId1 = Database.executeBatch(batchJob, 2000);
        }
    }
}