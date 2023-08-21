trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    ContactTriggerDispatcher.dispatch(Trigger.OperationType);
}