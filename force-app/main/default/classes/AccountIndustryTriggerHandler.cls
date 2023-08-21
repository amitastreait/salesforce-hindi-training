public class AccountIndustryTriggerHandler {

    public static void handleBeforeInsert(){
        // sObject
        // 	 Stanadard
        // 	 Custom
        List<Account> accountList = (List<Account>)Trigger.New; //List<sObject>
        for(Account acc : accountList){
            /* Old Trigger */
            acc.Industry = 'Education';
            if(acc.Description == null){
                acc.Description = 'Account Description is blank';
            }
            
            /* Update Billing Address as Shipping Address */
            acc.BillingStreet     = acc.ShippingStreet;
            acc.BillingState      = acc.ShippingState;
            acc.BillingCity       = acc.ShippingCity;
            acc.BillingCountry    = acc.ShippingCountry;
            acc.BillingPostalCode = acc.ShippingPostalCode;
        }
    }
    
    public static void handleBeforeUpdate(){
        List<Account> accountList = (List<Account>)Trigger.New; // List<Account>
        for(Account acc : accountList){
            /* Update Billing Address as Shipping Address */
            acc.BillingStreet     = acc.ShippingStreet;
            acc.BillingState      = acc.ShippingState;
            acc.BillingCity       = acc.ShippingCity;
            acc.BillingCountry    = acc.ShippingCountry;
            acc.BillingPostalCode = acc.ShippingPostalCode;
        }
    }
    
    public static void handleAfterInsert(){
        List<Account> accountList = (List<Account>)Trigger.New;
        Map<Id, Account> newRecordsMap = (Map<Id, Account>)Trigger.newMap; // Map<Id, sObject> == Map<Id, Account>
        List<Task> taskList = new List<Task>();
        for(Account acc : accountList){
            Task taskRecord = new Task();
            taskRecord.Subject = 'Created From Apex Trigger For '+acc.Name;
            taskRecord.Description = 'Created From Apex Trigger For '+acc.Name;
            taskRecord.Status = 'Not Started';
            taskRecord.Priority = 'High';
            taskRecord.ActivityDate = System.today().addDays(7);
            taskRecord.WhatId = acc.Id;
            taskRecord.OwnerId = acc.OwnerId;
            taskList.add(taskRecord);
        }
        insert taskList;
    }
}