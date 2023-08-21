@IsTest
public class ContactsBatchClassSchedulableTest {

    @TestSetup
    private static void prepareData(){
        List<Account> accountList = new List<Account>();
        for(Integer i=0; i < 200; i++){
            Integer randomInt = Integer.valueOf(math.rint(math.random()*23430000));
            Account acc = new Account(
                Name = 'TEST ACCOUNT '+randomInt+' '+i, Industry = 'Education',
                Phone = '778763445',
                Rating = 'Hot'
            );
            accountList.add(acc);
        }
        insert accountList;
        // Id will get populated
        List<Contact> contactList = new List<Contact>();
        for(Integer i=0; i < 200; i++){
            Integer randomInt = Integer.valueOf(math.rint(math.random()*23430000));
            Account acc = accountList.get(i);
            Contact con = new Contact(
            	LastName = 'CONTACT '+randomInt+' '+i,
                FirstName = 'Test ',
                Email = 'abc@gmail.com',
                AccountId = acc.Id
            );
            contactList.add(con);
        }
        insert contactList;
    }
    
    @IsTest
    private static void contactScheuleTest(){
        Test.startTest();
        // Call the batch Apex
        ContactsBatchClassSchedulable schedulable = new ContactsBatchClassSchedulable();
        schedulable.execute(NULL);
        Test.stopTest();
        List<Contact> contactList = [SELECT FirstName, LastName FROM Contact LIMIT 200];
        Assert.areEqual(200, contactList.size());
        for(Contact con: contactList){
            Assert.areEqual('Batch', con.FirstName);
        }
        Integer i = 0;
        Assert.areEqual(0, i);
    }
}