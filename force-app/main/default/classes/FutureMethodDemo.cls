public class FutureMethodDemo {
    
    public static void run(String firstName, String lastName){
        //Step1 - Created Account [ NoN-Setup Object ]
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        Account accRecord = new Account(
        	Name = 'Salesforce.org '+randomInt,
            Rating = 'Hot'
        );
        insert accRecord;
        //Step2 - Create user [ Setup Object ]
        createUser(firstName, lastName);
        try{
            Integer i = 100/0; // MathException
        }catch(System.Exception ex){
            // Log Error
        }
    }
    
    @future
    public static void method2(){
        
    }
    
    @future
    public static void method3(){
        
    }
    
    @future
    public static void createUser(String firstName, String lastName){
        
        UserRole role = [SELECT Id FROM UserRole WHERE Name='COO' LIMIT 1];
        Profile profile = [SELECT 
                           	Id 
                           FROM 
                           	Profile 
                           WHERE
                           	Name = 'Minimum Access - Salesforce' 
                           LIMIT 1];
        String orgId = UserInfo.getOrganizationId();  
        String dateString =   
            String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');  
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));  
        String uniqueName = orgId + dateString + randomInt;  
        User tempUser = new User(  
            FirstName = firstName,  
            LastName = lastName,  
            email = uniqueName + '@sfdc' + orgId + '.org',  
            Username = uniqueName + '@sfdc' + orgId + '.org',  
            EmailEncodingKey = 'ISO-8859-1',  
            Alias = uniqueName.substring(18, 23),  
            TimeZoneSidKey = 'America/Los_Angeles',  
            LocaleSidKey = 'en_US',  
            LanguageLocaleKey = 'en_US',  
            ProfileId = profile.Id,
            UserRoleId = role.Id
        );
        insert tempUser;
       
    }
}