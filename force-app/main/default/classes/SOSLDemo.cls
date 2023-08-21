public class SOSLDemo {

    public static void find(String keyword){
        List<List<sObject>> records = [FIND :keyword IN ALL FIELDS 
                                       RETURNING
                                       Account(Id, Name, Rating, Industry),
                                       Contact(Id, Name, Email),
                                       Opportunity(Id, Name, Amount),
                                       Lead(Id, Name, Email, Company, Phone),
                                       Case(Id, CaseNumber, Subject, Status, Priority),
                                       User(Id, Email, Name, UserName, Title, Department)
                                      ];
        System.debug(records.size());
        List<Account> accountRecords = records.get(0);
        System.debug(accountRecords);
        List<Contact> contactRecords = records.get(1);
        System.debug(contactRecords);
    }
}