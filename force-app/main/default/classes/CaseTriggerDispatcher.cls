public class CaseTriggerDispatcher {
    public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            WHEN AFTER_INSERT{
                if(CaseTriggerHandler.runOnce == false){
                    CaseTriggerHandler.handleAfterInsert(Trigger.New);   
                }
            }
            WHEN ELSE{
                // new old
                // new.Type <> old.Type
            }
        }
    }
}