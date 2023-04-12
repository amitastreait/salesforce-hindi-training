public class AccountTriggerDispatcher {
	// Trigger.OperationType
	// AFTER_INSERT, BEFORE_INSERT, AFTER_UPDATE, BEFORE_UPDATE, AFTER_DELETE, BEFORE_DELETE
	// System.TriggerOperation ~= Trigger.OperationType
	// AFTER_INSERT, BEFORE_INSERT, AFTER_UPDATE, BEFORE_UPDATE, AFTER_DELETE, BEFORE_DELETE
    public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            WHEN BEFORE_INSERT{
                AccountTriggerHandler.handleBeforeInsert(Trigger.New);
            }
            WHEN AFTER_INSERT{
                AccountTriggerHandler.handleAfterInsert(Trigger.New);
            }
            WHEN BEFORE_UPDATE{
                AccountTriggerHandler.handleBeforeUpdate(Trigger.New);
            }
            WHEN AFTER_UPDATE{
                AccountTriggerHandler.handleAfterUpdate();
            }
            WHEN BEFORE_DELETE{
                
            }
            WHEN AFTER_DELETE{
                
            }
            WHEN AFTER_UNDELETE{
                
            }
            WHEN ELSE{
                
            }
        }
    }
}