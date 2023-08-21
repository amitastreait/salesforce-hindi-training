trigger CourseTrigger on Course__c (before insert, after insert) {
    if(Trigger.isBefore){
        CourseTriggerHandler.handleBeforeInsert(Trigger.New);
    }else if(Trigger.isAfter){
        CourseTriggerHandler.run(Trigger.New);
    }
}