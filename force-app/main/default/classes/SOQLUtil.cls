public with sharing class SOQLUtil { // by default system mode

    public static void soslTest(){
        String keyword = 'AMit Singh';
        List<List<SObject>> searchResults = [ 
            			FIND :keyword
                        IN Name FIELDS
                        RETURNING
                        Account(Name), 
                        Contact(LastName, Account.Name)
                    WITH USER_MODE
          ];
        String query = 'SELECT ID, Name, Industry FROM Account LIMIT 10'; // 10 - 2 
        List<Account> accountList = Database.query(query); // All Records
        
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;
    }
    public static void userMode(){
        try{
            List<Course__c> courseList = [SELECT Id, Name, Price__c, StartDate__c
                                          FROM
                                          	Course__c
                                          WHERE
                                          	StartDate__c <> null 
											AND Price__c <> null
                                          WITH USER_MODE
                                         ];
            System.debug(courseList);
        }catch(System.SecurityException ex){
            System.debug(ex.getInaccessibleFields());
        }catch(System.QueryException ex){
            System.debug(ex.getInaccessibleFields());
        }catch(System.Exception ex){
            System.debug(ex.getTypeName());
        }
    }
    
    public static void securityEnforced(){
        try{
            List<Course__c> courseList = [SELECT Id, Name
                                          FROM Course__c
                                          WHERE StartDate__c <> null AND Price__c <> null
                                          WITH SECURITY_ENFORCED
                                         ];
            System.debug('courseList '+courseList);
        }catch(System.SecurityException ex){
            System.debug('SecurityException '+ ex.getInaccessibleFields());
        }catch(System.QueryException ex){
            System.debug('QueryException '+ ex.getInaccessibleFields());
            System.debug(ex.getMessage());
        }catch(System.Exception ex){
            System.debug(ex.getTypeName());
        }
    }
    
    public inherited sharing class InnerClass {
        public void methodA(){
            // SOQL
        }
        public void methodB(){
            
        }
    }
}