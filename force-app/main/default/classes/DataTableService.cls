public with sharing class DataTableService {

    @AuraEnabled
    public static List<Account> accountList(){
        return [SELECT Id, Name, Rating, Phone, AnnualRevenue, CreatedDate, OwnerId, Active__c, Owner.Name, Website FROM Account WHERE AnnualRevenue != null LIMIT 10];
    }
}