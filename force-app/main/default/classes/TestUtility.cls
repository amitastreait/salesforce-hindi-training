@IsTest
public class TestUtility {
	
    public static Account prepareAccount(String name, String rating){
        Account accRecord = new Account(
            Name = name,
            Industry = 'Edutation',
            Rating = rating,
            Phone = '98824434',
            SLA__c = 'Gold'
        );
        return accRecord;
    }
    
    public static List<Account> prepareAccount(Integer noOfRecords, String name){
        List<Account> accountList = new List<Account>();
        for(Integer i=0; i< noOfRecords; i++){
            Account accRecord = new Account(
            	Name = name+' '+i,
                Industry = 'Edutation',
                Rating = 'Hot',
                Phone = '98824434',
                SLA__c = 'Gold'
            );
            accountList.add(accRecord);
        }
        return accountList;
    }
    
    public static List<Contact> prepareContact(Integer noOfRecords, String lastName, String accountId, String email){
        List<Contact> contactList = new List<Contact>();
        for(Integer i=0; i< noOfRecords; i++){
            Contact conRecord = new Contact(
            	LastName = lastName+' '+i,
                Phone = '98824434',
                AccountId = accountId,
                Email = email
            );
            contactList.add(conRecord);
        }
        return contactList;
    }
}