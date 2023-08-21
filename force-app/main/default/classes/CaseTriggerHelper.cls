public class CaseTriggerHelper {
    public static List<Case> helperMethod(){
        List<Case> caseList = new List<Case>();
        
        ContactsQueueable queueable = new ContactsQueueable(10, null);
        Id jobId = System.enqueueJob(queueable); // Different Transaction
        System.debug('Child Job Id '+jobId);
        
        ContactsQueueable queueable1 = new ContactsQueueable(10, null);
        Id jobId1 = System.enqueueJob(queueable1); // Different Transaction
        System.debug('Child Job Id '+jobId1);
        
        // Calling Another Class
        // CaseObjectCreator
        // 50
        
        return caseList;
    }
}