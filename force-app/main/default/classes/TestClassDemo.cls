@IsTest
public class TestClassDemo {
    @IsTest
    private static void testWithoutPermission(){
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Minimum Access - Salesforce' LIMIT 1];
        String orgId = UserInfo.getOrganizationId();  
        String dateString =   
        String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');  
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));  
        String uniqueName = orgId + dateString + randomInt;  
        User tempUser = new User(  
            FirstName = 'Amit',  
            LastName = 'Singh',  
            email = uniqueName + '@sfdc' + orgId + '.org',  
            Username = uniqueName + '@sfdc' + orgId + '.org',  
            EmailEncodingKey = 'ISO-8859-1',  
            Alias = uniqueName.substring(18, 23),  
            TimeZoneSidKey = 'America/Los_Angeles',  
            LocaleSidKey = 'en_US',  
            LanguageLocaleKey = 'en_US',  
            ProfileId = profile.Id
        );
        insert tempUser;
        System.debug(' tempUser '+tempUser.ProfileId);
        System.debug(' User '+tempUser.Id);
        // Object & Field Level
        // Record Level
        // 	OWD [ Organization Wide Default ]
        // 		Private
        // 			Record Owner & Role above the Owner in Role Hierarchy
        // 		Public Read Only
        // 			Record owner[ Edit, Delete ] & Any User in the Org with Object Level Permission can view record
        // 		Public Read/Write
        // 		Controlled By Parent - Child Object in case Master-Detail
        // 		Public Read/Write/Transfer - Lead/Case
        
        
        System.runAs(tempUser){ // Record Level Sharing - Sharing Rule
         	
            Account accountRecord = new Account(
                Name = 'Test Account'
            );
            accountRecord.Site = 'https://www.pantherschools.com';
            accountRecord.Active__c = 'Yes';
            accountRecord.Industry = 'Education';
            accountRecord.AccountSource = 'Web';
            accountRecord.External_Id__c ='1234BACCS';
            //Test.startTest();
            try{
                insert as user accountRecord;
            }catch(System.SecurityException ex){
                System.debug(ex.getStackTraceString());
            }
             // Admin Mode
            
            // OwnerId - User/Group [tempUser]
            // CreatedById - User [Admin User]
                
            List<Account> accountList = [SELECT Id, OwnerId, CreatedById, Name, Active__c, Industry, AccountSource, External_Id__c
                           FROM Account WHERE Id =:accountRecord.Id];
            if(accountList != null && accountList.size() > 0){
                Account acc = accountList.get(0);
                System.debug(acc);
                System.debug(acc.OwnerId);
                System.debug(acc.CreatedById);
            }
            
            //Test.stopTest();
        }
    }
    
    @IsTest
    private static void testWithPermission(){
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Minimum Access - Salesforce' LIMIT 1];
        String orgId = UserInfo.getOrganizationId();  
        String dateString =   
        String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');  
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));  
        String uniqueName = orgId + dateString + randomInt;  
        User tempUser = new User(  
            FirstName = 'Amit',  
            LastName = 'Singh',  
            email = uniqueName + '@sfdc' + orgId + '.org',  
            Username = uniqueName + '@sfdc' + orgId + '.org',  
            EmailEncodingKey = 'ISO-8859-1',  
            Alias = uniqueName.substring(18, 23),  
            TimeZoneSidKey = 'America/Los_Angeles',  
            LocaleSidKey = 'en_US',  
            LanguageLocaleKey = 'en_US',  
            ProfileId = profile.Id
        );
        insert tempUser;
        System.debug(' tempUser '+tempUser.ProfileId);
        System.debug(' User '+tempUser.Id);
        
        List<PermissionSet> permissionSetList = [SELECT Id, Name FROM PermissionSet WHERE Name = 'Account_Contact_Access' LIMIT 1];
        if(permissionSetList != null && permissionSetList.size() > 0){
            PermissionSet permissionSet = permissionSetList.get(0);
            PermissionSetAssignment assignmentRecord = new PermissionSetAssignment();
            assignmentRecord.PermissionSetId = permissionSet.Id;
            assignmentRecord.AssigneeId = tempUser.Id;
            
            List<PermissionSetAssignment> assignmentList = new List<PermissionSetAssignment>();
            assignmentList.add(assignmentRecord);
            insert as system assignmentList;
        }
        
        System.runAs(tempUser){
         	
            Account accountRecord = new Account(
                Name = 'Test Account'
            );
            accountRecord.Site = 'https://www.pantherschools.com';
            accountRecord.Active__c = 'Yes';
            accountRecord.Industry = 'Education';
            accountRecord.AccountSource = 'Web';
            accountRecord.External_Id__c ='1234BACCS';
            
            try{
                insert as user accountRecord;
            }catch(System.SecurityException ex){
                System.debug(ex.getMessage());
                System.debug(ex.getStackTraceString());
            }
            
            List<Account> accountList = [SELECT Id, OwnerId, CreatedById, Name, Active__c, Industry, AccountSource, External_Id__c
                           FROM Account WHERE Id =:accountRecord.Id];
            if(accountList != null && accountList.size() > 0){
                Account acc = accountList.get(0);
                System.debug(acc);
                System.debug(acc.OwnerId);
                System.debug(acc.CreatedById);
            }
        }
    }
}