@IsTest
public class FutureMethodDemoTest {

    @IsTest
    private static void method2Test(){
        Test.startTest();
        FutureMethodDemo.method2();
        Test.stopTest();
    }
    
    @IsTest
    private static void method3Test(){
        Test.startTest();
        FutureMethodDemo.method3();
        Test.stopTest();
    }
    @IsTest
    private static void runTest(){
        Test.startTest();
        FutureMethodDemo.run('Test', 'Class');
        Test.stopTest();
        // Assert
        List<Account> accountList = [SELECT Id, Name, Rating 
                                     FROM Account
                                     WHERE Name Like 'Salesforce.org %'
                                     AND Rating = 'Hot'
                                    ];
        Assert.isNotNull(accountList);
        Assert.areEqual(1, accountList.size(), 'There are more than one account!');
        List<User> userList = [SELECT Id, Name, Email 
                               FROM User 
                               WHERE Profile.Name = 'Minimum Access - Salesforce'
                               AND FirstName = 'Test' 
                               AND LastName = 'Class'
                              ];
        System.debug('userList '+ JSON.serializePretty( userList ) );
        Assert.isNotNull(userList);
        Assert.areEqual(1, userList.size(), 'There are more than one User Records created!');
    }
    
    @IsTest
    private static void createUserTest(){
        // Data Setup
        Test.startTest();
        FutureMethodDemo.createUser('Jason', 'Frank');
        Test.stopTest();
        
        List<User> userList = [SELECT Id, Name, Email 
                               FROM User 
                               WHERE Profile.Name = 'Minimum Access - Salesforce'
                               AND FirstName = 'Jason' 
                               AND LastName = 'Frank'
                              ];
        System.debug('userList '+ JSON.serializePretty( userList ) );
        Assert.isNotNull(userList);
        Assert.areEqual(1, userList.size(), 'There are more than one User Records created!');
    }
}