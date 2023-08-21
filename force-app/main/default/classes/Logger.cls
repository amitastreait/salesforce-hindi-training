public class Logger {

    public static System_Event__c logError(String title){
        System_Event__c event = new System_Event__c();
        event.Complete_Trace_String__c = '';
        event.Title__c = title; // Identifer
        event.Component_Name__c = '';
        event.Component_Type__c = '';
        event.Exception_Type__c = '';
        event.Line_Number__c = '';
        event.Message__c = '';
        event.User__c = null;
        return event;
    }
    
}