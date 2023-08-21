public class ContactTriggerHelper {

    public static void countContact(Map<Id, Contact> newRecordsMap){
        // key - RecordId
        // value - Record
        // keySet() - Set<Key> - Set<Id>
        // values() - List<Value> - List<Account>
        
        /* Step1 - Get Account Ids */
        Set<Id> accountIdsSet = new Set<Id>();
        for(Contact con: newRecordsMap.values() ){
            if(con.AccountId <> null){ // check if contact is related to account
                accountIdsSet.add(con.AccountId);
            }
        }
        
        /* Solution #1 - Inner Query 
        List<Account> accountList = new List<Account>();
        accountList = [SELECT Id, (SELECT Id FROM CONTACTS) FROM Account WHERE Id IN: accountIdsSet]; //50K
        for(Account acc : accountList){
            List<CONTACT> contList = acc.CONTACTS; // List of Contact
            if(contList != null){
                Integer size = contList.size();
                acc.Number_of_Contacts__c = size;
            }
        }
        update accountList;
        */
        
        /* Solution #1 will fail in case of Bulk Recods */
        
        /* Solution #2 - Aggregate Query (Recomended) - SUM, COUNT, MIN, MAX, AVG */
        /* Aggregate Query - LIMIT 2000 */
        List<AggregateResult> aggregateList = [SELECT count(Id), AccountId
                                               FROM Contact
                                               WHERE AccountId IN:accountIdsSet 
                                               Group By AccountId];
        //(AggregateResult:{expr0=3, AccountId=0012w00001Pz63SAAR})
        //(AggregateResult:{totalContact=3, AccountId=0012w00001Pz63SAAR})
        System.debug(aggregateList);
        List<Account> accountListToUpdate = new List<Account>();
        for(AggregateResult ag : aggregateList){
            String accountId = (String)ag.get('AccountId'); // Object
            Integer totalContact = (Integer)ag.get('expr0'); // Object
            Account accountRecord = new Account();
            accountRecord.Id = accountId;
            accountRecord.Number_of_Contacts__c = totalContact;
            accountListToUpdate.add(accountRecord);
            
            accountIdsSet.remove(accountId);
        }
        
        if(accountIdsSet.size() > 0){
            for(Id accountId : accountIdsSet){ // xyz
                Account accountRecord = new Account();
                accountRecord.Id = accountId;
                accountRecord.Number_of_Contacts__c = 0;
                accountListToUpdate.add(accountRecord);
            }
        }
        update accountListToUpdate;
    }
}