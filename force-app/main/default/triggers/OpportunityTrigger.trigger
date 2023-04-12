trigger OpportunityTrigger on Opportunity (before insert, after update) {
	OpportunityTriggerDispatcher.dispatch(Trigger.OperationType);
}