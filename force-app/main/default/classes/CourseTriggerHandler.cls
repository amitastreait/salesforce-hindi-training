public with sharing class CourseTriggerHandler {

    public static void handleBeforeInsert(List<Course__c> newRecords){
        for(Course__c c: newRecords){
            c.StartDate__c = System.today();
            c.Price__c = 999.0;
        }
    }
    
    public static void run(List<Course__c> newRecords){
        List<Course__c> courseList; // null list
        try{
            String query = 'SELECT Id, Name, Price__c, StartDate__c FROM Course__c ';
            courseList = Database.query(query, AccessLevel.USER_MODE); //AccessLevel.USER_MODE
            System.debug(' courseList '+ courseList);
        }catch(System.QueryException ex){
            // Log Error in Logger Object
            System.debug(ex.getStackTraceString());
            System.debug(ex.getInaccessibleFields()); // In Accessible Fields - Text Area Long
        }catch(System.Exception ex){
            
        }
    }
}