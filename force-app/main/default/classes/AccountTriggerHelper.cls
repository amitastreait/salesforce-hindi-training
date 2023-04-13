public class AccountTriggerHelper {

    // reusable methods - focus
    // further processing
    // 
    public static void updateAccountShippingAddress(List<Account> accountList){
        /*
            Develop an Apex Trigger so that every time 
            1. when any account is inserted then set the value of the Industry field to Education.
            Also, 
            2. check if the Description is black then set
            the value for the description to “Account Description was blank”
		*/
        // sObject
        // 		Standard
        // 		Custom
        //List<Account> accountList = Trigger.New; // List<sObject>
        for(Account acc : accountList){ //List<sObject>
            
            if(acc.Industry == null){
                acc.Description = 'Account Industry was blank';   
            }
            
            /* 
                Develop an Apex Trigger so that every time when any account 
                is created or updated then 
                Set the Value of the Billing Address is to Shipping Address.
                ShippingStreet
                ShippingCity
                ShippingState
                ShippingPostalCode
                ShippingCountry
			*/
            if(acc.ShippingStreet == null ){
                
            }else if(acc.ShippingCity == null){
                
            }else if(acc.ShippingCountry == null){
                
            }
            System.debug(acc.ShippingAddress);
            if(acc.ShippingAddress == null){
                system.debug('ShippingAddress is null ');
            }
            //  acc.ShippingStreet == null => True
            if(acc.ShippingStreet == null || acc.ShippingCity == null || acc.ShippingState == null || acc.ShippingPostalCode == null || acc.ShippingCountry == null){
                acc.ShippingStreet 		= acc.BillingStreet; // data type must be same
                acc.ShippingCity 		= acc.BillingCity;
                acc.ShippingState 		= acc.BillingState;
                acc.ShippingPostalCode  = acc.BillingPostalCode;
                acc.ShippingCountry 	= acc.BillingCountry;
            }
        }
    }
    
    public static void checkDuplicateAccount(List<Account> newRecords){
        /*
         * The business got to know that there are multiple accounts with the same name and rating.
		   Now, as a developer, you need to make sure that no new duplicates are being
		   created with the same name and rating. 
		*/
        Set<String> accountNameSet = new Set<String>();
        Set<String> accountRatingSet = new Set<String>();
        // newRecords - 2
        // Demo - Name
        // Hot - Rating
        // (Demo, Demo)
        // (Rating, Rating)
        // {Demo}
        // {Rating}
        for(Account acc : newRecords){
            accountNameSet.add(acc.Name);
            accountRatingSet.add(acc.Rating);
        }
        
        List<Account> existingAccountList = [SELECT Id, Name, Rating 
                                             FROM Account
                                             WHERE Name IN: accountNameSet
                                             AND Rating IN: accountRatingSet
                                             AND Id NOT IN :newRecords
                                             LIMIT 50000
                                           ];
        for(Account acc : newRecords){ //Trigger.New
            for(Account extAcc: existingAccountList){
                if(acc.Name == extAcc.Name && acc.Rating == extAcc.Rating){
                    acc.addError('Duplicate account already exists with same name and rating!');
                    acc.Name.addError('Duplicate account already exists with same name and rating!');
                    acc.Rating.addError('Duplicate account already exists with same name and rating!');
                }
            }
        }
    }
    
}