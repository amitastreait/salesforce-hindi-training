public with sharing class LookupController {
    
    @AuraEnabled
    public static List<Account> accountList(String searchKeyword, String objectApiName, String fieldToSearch){
        String likeParam = '%'+searchKeyword+'%';
        // SELECT Id, Subject FROM Case WHERE Subject LIKE: likeParam
        String queryString = 'SELECT Id, '+fieldToSearch+' FROM '+objectApiName+' WHERE '+fieldToSearch+' Like :likeParam LIMIT 10';
        return Database.query(queryString);
    }

}