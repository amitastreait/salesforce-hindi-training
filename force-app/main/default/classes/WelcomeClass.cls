public class WelcomeClass {
	// , ; :
    @InvocableMethod(label='Displays Welcome Message' 
                     description='This method will retutn a welcome message'
                     category='PantherSchools'
                     iconName='slds:custom:custom80'
                    )
    public static List<String> welcomeMessage(List<String> inputs){
        // Welcome Message typeof - String => List<String>
        // List<String> => List<List<String>>
        // List<sObject> => List<List<sObject>>
        // List<Id> => List<List<Id>>
        String userName = inputs.get(0);
        List<String> welcomeMessageList = new List<String>();
        welcomeMessageList.add('Hi '+userName+', Welcome  to the flow Bootcamp! I am coming from Invocable Apex!');
        return welcomeMessageList;
    }
}