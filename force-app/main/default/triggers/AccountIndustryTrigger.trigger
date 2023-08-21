trigger AccountIndustryTrigger on Account (before insert, before update, after insert) {
    if(Trigger.isBefore){
        if( Trigger.isInsert ){
            AccountIndustryTriggerHandler.handleBeforeInsert();
        }
        if( Trigger.isUpdate ){
            AccountIndustryTriggerHandler.handleBeforeUpdate();
        }
    }
    if(Trigger.isAfter){ // after 
        if(Trigger.isInsert){ // insert 
            AccountIndustryTriggerHandler.handleAfterInsert();
        }
    }
}