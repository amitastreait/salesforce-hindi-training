trigger OpportunityTrigger on Opportunity (before insert, after update, before update) {
	OpportunityTriggerDispatcher.dispatch(Trigger.OperationType);
}