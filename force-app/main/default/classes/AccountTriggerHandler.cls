public class AccountTriggerHandler {
    // before insert
    public static void handleBeforeInsert(List<Account> accountList){
		AccountTriggerHelper.updateAccountShippingAddress(accountList); 
        AccountTriggerHelper.checkDuplicateAccount(accountList);
    }
    // before update
    public static void handleBeforeUpdate(List<Account> accountList){
        AccountTriggerHelper.updateAccountShippingAddress(accountList);
        AccountTriggerHelper.checkDuplicateAccount(accountList);
    }
    // after insert
    public static void handleAfterInsert(List<Account> accountList){
        /*
            When the Account is Created,
            Create a Task Record under that Account and assign the Task to the Account Owner.
            Use the below information
            * Subject - Created from Apex Trigger
            * Description - Created from Apex Trigger
            * Due Date - Todays Date + 7
            * Status - Not Started
            * Priority - High
            * OwnerId - Account OwnerId
            * WhatId - Account.Id
        */
        /* Sub-Problems */
        // 1. Check if the code is running after insert
        // Do not make any DML withing for loop ( LIMIT - 150 ~ 151 )
        // Do not make any SOQL withing for loop ( LIMIT - 100 ~ 101 )
        
        List<Task> taskRecordToInsertList = new List<Task>();
  		for(Account acc : accountList){ // Trigger.size = 200
            // Prepare Task Record
            Task t = new Task();
			t.Subject = 'Created from Apex Trigger';  
            t.Description = 'Created from Apex Trigger';
            t.Status = 'Not Started';
            t.Priority = 'High';
            t.ActivityDate = System.today().addDays(7);
            t.WhatId = acc.Id;
            t.OwnerId = acc.OwnerId;
            taskRecordToInsertList.add(t);
        }  
        // insert Task Record
        insert taskRecordToInsertList;
        // 200 times
    }
    // after update
    public static void handleAfterUpdate(){
        
    }
    
    
}