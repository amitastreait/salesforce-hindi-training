public class ContactTriggerDispatcher {
    public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            WHEN AFTER_INSERT{
                ContactTriggerHandler.handleAfterInsert((Map<Id, Contact>)Trigger.newMap); // Map<Id, sObject>
            }
            
        }
    }
}