public with sharing class ExceptionUtils {
    
    @AuraEnabled
    public static void throwException(){
        try {
            Account acc = new Account(Id = '0012w00001Pz63UAAR');
            insert acc;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}