trigger AccountTrigger on Account (before insert, before update, after insert, after update, after delete, before delete, after undelete) {
    AccountTriggerDispatcher.dispatch(Trigger.OperationType);
}