public class CaseTriggerHandler {
    
    public static Boolean runOnce = false; // FAIL X - More than 200 Records
    public static void handleAfterInsert(List<Case> newCaseRecords){ // trigger.New
        //Call - Async Apex - Put on Apex Flex Queue
        List<Case> caseRecordToInsertList = new List<Case>();
        for(Case c: newCaseRecords){
            Case caseRecord = new Case(
            	Subject = c.Subject,
                Status = c.Status,
                ContactId = c.ContactId,
                Description = c.Description,
                Priority = c.Priority,
                ParentId = c.Id,
                Origin = c.Origin
            ); 
            caseRecordToInsertList.add(caseRecord); // Generator Not Working - 8
        }
        //runOnce = True;
        List<Database.SaveResult> saveResult = Database.insert(caseRecordToInsertList, false); // 10
        List<System_Event__c> eventList = new List<System_Event__c>();
        // Unhandled Error
        for(Integer i=0; i<saveResult.size(); i++ ){
            Database.SaveResult sr = saveResult.get(i);
            if(!sr.isSuccess()){
                Case failedCaseRecord = caseRecordToInsertList.get(i);
                String message = '';
                for(Database.Error err : sr.getErrors()) {
                    message = message + err.getStatusCode() + ' : ' + err.getMessage()+' ';
                }
                //System_Event__c event = Logger.logError();
                //eventList.add(event);
            }
        }
        /*
        for(Database.SaveResult sr: saveResult){
            if(!sr.isSuccess()){
                String message = '';
                for(Database.Error err : sr.getErrors()) {
                    message = message + err.getStatusCode() + ' : ' + err.getMessage()+' ';
                }
                System_Event__c event = new System_Event__c();
                event.Complete_Trace_String__c = message;
                event.Title__c = 'Error While Creating the Child Case Record - Line No: 18'; // Identifer
                event.Component_Name__c = 'CaseTriggerHandler';
                event.Component_Type__c = 'Apex Class';
                event.Exception_Type__c = '';
                event.Line_Number__c = '';
                event.Message__c = message;
                event.User__c = UserInfo.getUserId();
                eventList.add(event);
            }
        }*/
        
        try{
         	insert eventList;
        }catch(System.DmlException dmlException){ // No
            System.debug('DmlException Block Executed!');
            System.debug('Line Number '+ dmlException.getLineNumber() );
            System.debug('Message '+dmlException.getMessage());
            System.debug('Complete Trace String '+dmlException.getStackTraceString()); // Must
            System_Event__c event = new System_Event__c();
            event.Complete_Trace_String__c = dmlException.getStackTraceString();
            event.Component_Name__c = 'CaseTriggerHandler';
            event.Component_Type__c = 'Apex Class';
            event.Exception_Type__c = dmlException.getTypeName();
            event.Line_Number__c = String.valueOf(dmlException.getLineNumber());
            event.Message__c = dmlException.getMessage();
            event.User__c = UserInfo.getUserId();
            event.Title__c = 'Error While Creating the System Event Record'; // Identifer
            insert event;
        }catch(System.MathException mathException){ // YES
            System.debug('MathException Block Executed!');
            System.debug('Line Number '+ mathException.getLineNumber() );
            System.debug('Message '+mathException.getMessage());
            System.debug('Complete Trace String '+mathException.getStackTraceString()); // Must
            System_Event__c event = new System_Event__c();
            event.Complete_Trace_String__c = mathException.getStackTraceString();
            event.Component_Name__c = 'CaseTriggerHandler';
            event.Component_Type__c = 'Apex Class';
            event.Exception_Type__c = mathException.getTypeName();
            event.Line_Number__c = String.valueOf(mathException.getLineNumber());
            event.Message__c = mathException.getMessage();
            event.User__c = UserInfo.getUserId();
            event.Title__c = 'Error While Creating the System Event Record'; // Identifer
            insert event;
        }catch(System.Exception ex){ // Everything
            System.debug('Exception Block Executed!');
            System.debug('Line Number '+ ex.getLineNumber() );
            System.debug('Message '+ex.getMessage());
            System.debug('Complete Trace String '+ex.getStackTraceString()); // Must
            System_Event__c event = new System_Event__c();
            event.Complete_Trace_String__c = ex.getStackTraceString();
            event.Component_Name__c = 'CaseTriggerHandler';
            event.Component_Type__c = 'Apex Class';
            event.Exception_Type__c = ex.getTypeName();
            event.Line_Number__c = String.valueOf(ex.getLineNumber());
            event.Message__c = ex.getMessage();
            event.User__c = UserInfo.getUserId();
            event.Title__c = 'Error While Creating the System Event Record'; // Identifer
            insert event;
        }finally{
            System.debug('Finally Block Executed!');
        }
        
        ContactsQueueable queueable = new ContactsQueueable(10, null);
        Id jobId = System.enqueueJob(queueable); // Different Transaction
        System.debug('Child Job Id '+jobId);
        
        ContactsQueueable queueable1 = new ContactsQueueable(10, null);
        Id jobId1 = System.enqueueJob(queueable1); // Different Transaction
        System.debug('Child Job Id '+jobId1);
        
        // Calling another class
        CaseTriggerHelper.helperMethod();
    }
}
/*
 * Iteration #1 - 200 Record
 * runOnce True
 * Iteration #2 - Next 200 Record
 * Iteration #3 - Next 200 Record
 * Iteration #4 - Next 200 Record
 * Iteration #5 - Next 200 Record
 */