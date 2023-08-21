public class CPUTimeoutDemo {

    // Wrong Approach
    public Transient List<Account> accountList;
    public List<Contact> contactList;
    
    public void processAccounts(){
        accountList = [SELECT Id, Name FROM Account];
        accountList.clear();
    }
    
    public void processContacts(Set<Id> accountIdsSet){
        contactList = [SELECT Id, Name FROM Contact];
        contactList.clear();
    }
    
    public void prepareAccounts(Set<Id> accountIdsSet){
        
        Map<String, Account> accountMapById = new Map<String, Account>();
        
        // Wrong Approach
        List<Account> accountList = [SELECT Id, Industry, Name, Phone FROM Account WHERE Id IN: accountIdsSet];
        for(Account acc:accountList){
            String key = acc.Name+acc.Industry+acc.Phone; // Unique
            accountMapById.put(key, acc);
        }
        
        // Correct Approach
        
        for(Account acc: [SELECT Id, Industry, Name, Phone FROM Account WHERE Id IN: accountIdsSet]){
            String key = acc.Name+acc.Industry+acc.Phone; // Unique
            accountMapById.put(key, acc);
        }
    }
    
    
}