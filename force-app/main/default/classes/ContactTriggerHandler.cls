public class ContactTriggerHandler {

    public static void handleAfterInsert(Map<Id, Contact> newContactMap){
        Set<String> contactNameSet = new Set<String>();
        for(Contact con : newContactMap.values()){
            if(con.AccountId == null){
                String contactName = con.FirstName != null ? con.FirstName + con.LastName : con.LastName;
                contactNameSet.add(contactName);
            }
        }
        System.debug(' contactNameSet '+contactNameSet);
        List<Contact> contactList = [SELECT Id, Name FROM Contact LIMIT 10];
        Map<Id, List<Contact>> accountContactMap = new Map<Id, List<Contact> >();
        for(Contact con: contactList){
            String accountId = con.AccountId;
            System.debug(' accountId '+accountId);
            if(accountContactMap.containsKey(accountId)){ // Account is already there in the Map
                //0012w00001Pz63UAAR
                System.debug('inside if');
                List<Contact> tempContactList = accountContactMap.get(accountId);
                tempContactList.add(con);
                accountContactMap.put(accountId, tempContactList);
            }else{ // Account is not there in the Map
                System.debug('inside else');
                List<Contact> tempContactList = new List<Contact>();
                tempContactList.add(con);
                accountContactMap.put(accountId, tempContactList);   
            }
        }
        
        /*
         * Iteration #1
         * accountId = 0012w00001Pz63UAAR
         * tempContactList = blank list [Bundle]
         * tempContactList.add(tempContactList); 1 Record
         * { '0012w00001Pz63UAAR' => tempContactList }
         * Iteration #2
         * accountId = 0012w00001Pz63UAAR
         * tempContactList = 1 record
         * tempContactList.add( tempContactList ); 2 Record
         * { '0012w00001Pz63UAAR' => tempContactList } - 2 Record
         * Iteration #3
         * accountId = 0012w00001Pz63OAAR
         * tempContactList = blank list [Bundle]
         * tempContactList.add(tempContactList); 1 Record
         * { '0012w00001Pz63OAAR' => tempContactList } - record
         */ 
        
        /*
         * Iteration #1
         * accountId = 0012342
         * tempContactList = blank list [Bundle]
         * tempContactList.add(tempContactList); 1 Record
         * { '0012342' => tempContactList }
         * Iteration #2
         * accountId = 0012342
         * tempContactList = blank list [Bundle]
         * tempContactList.add( tempContactList ); 1 Record
         * { '0012342' => tempContactList } - 1 Record
         */ 
        
        Map<String, Account> accountNameMap = new Map<String, Account>();
        for(Account acc : [SELECT Id, Name FROM Account WHERE Name IN: contactNameSet]){
            accountNameMap.put(acc.Name, acc);
        }
        List<Account> accountListToInsert = new List<Account>();
        Map<Id, Contact> contactRecordToUpdate = new Map<Id, Contact>();
        for(Contact con : newContactMap.values()){
            String contactName = con.FirstName != null ? con.FirstName + con.LastName : con.LastName;
            Account accRecord = accountNameMap.get(contactName);
            if(accRecord != null){
                Contact conRecord = new Contact(Id = con.Id, AccountId = accRecord.Id);
                contactRecordToUpdate.put(con.Id, conRecord);
            }else{
                Account acc = new Account(Name = contactName);
                accountListToInsert.add(acc);
            }
        }
        insert accountListToInsert;
        for(Account acc : accountListToInsert){
            accountNameMap.put(acc.Name, acc);
        }
        for(Contact con : newContactMap.values()){
            String contactName = con.FirstName != null ? con.FirstName + con.LastName : con.LastName;
            Account accRecord = accountNameMap.get(contactName);
            if(accRecord != null){
                Contact conRecord = new Contact(Id = con.Id, AccountId = accRecord.Id);
                contactRecordToUpdate.put(con.Id, conRecord);
            }
        }
        System.debug(' contactRecordToUpdate '+ contactRecordToUpdate.values());
        update contactRecordToUpdate.values();
    }
}