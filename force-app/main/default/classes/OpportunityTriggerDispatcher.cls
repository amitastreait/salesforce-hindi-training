public class OpportunityTriggerDispatcher {
    public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            WHEN BEFORE_INSERT{
                OpportunityTriggerHandler.handleBeforeInsert(Trigger.New);
            }
        }
    }
}