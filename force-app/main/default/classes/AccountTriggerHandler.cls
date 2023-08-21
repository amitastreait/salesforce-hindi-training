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
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        
        List<Account> newAccountList = [SELECT Id, Name, Phone, Industry, OwnerId, Owner.Name, Owner.Email FROM Account WHERE Id IN: accountList];
        
  		for(Account acc : newAccountList){ // Trigger.size = 200
            // Prepare Task Record
            if(acc.Phone == null && acc.Industry == null){ // 20
                
                // Requirement #1 - Create Task
                Task t = new Task();
                t.Subject = 'Created from Apex Trigger';  
                t.Description = 'Created from Apex Trigger';
                t.Status = 'Not Started';
                t.Priority = 'High';
                t.ActivityDate = System.today().addDays(7);
                t.WhatId = acc.Id;
                t.OwnerId = acc.OwnerId;
                taskRecordToInsertList.add(t);
                
                // Requirement #2 - Send Email
                // Prepare Email - DRAFT Email
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSubject('New Account '+acc.Name+' has been assigned!');
                // OwnerId (User/Queue)
                String emailBody = 'Dear '+acc.Owner.Name+' <br/><br/>';
                emailBody += 'A new account <b>'+acc.Name+'</b> has been created in Salesforce. The account is missing some important information Phone & Industry.<br/><br/>';
                emailBody += 'Please try to collect this information and update the account ASAP.<br/><br/>';
                emailBody += '<b>Thanks & Regards,<br/>';
                emailBody += 'Panther Schools</b>';
                
                //email.setPlainTextBody(emailBody);
                email.setHtmlBody(emailBody);
                
                List<String> toAddress = new List<String>();
                // Lead/Contact/User - Email/Id
                toAddress.add(acc.OwnerId); // OwnerEmail
                email.setToAddresses(toAddress);
                
                List<String> bccAddress = new List<String>();
                bccAddress.add('contentlearning222@gmail.com');
                
                email.setBccAddresses(bccAddress);
                
                // Prepare the Attachment and send along with the email
                Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                attach.setFileName('Panther-Schools.txt'); // pdf, txt, png, jpg, jpeg, word, zip
                
                String strBody = 'This is simple text attached from Salesforce';
                Blob textBody = Blob.valueOf(strBody);
                attach.setBody(textBody);
                
                List<Messaging.EmailFileAttachment> fileAttachments = new List<Messaging.EmailFileAttachment>();
                fileAttachments.add(attach);
                
                email.setFileAttachments( fileAttachments );
                
                email.setReplyTo('no-reply@gmail.com');
                email.setSenderDisplayName('Amit From Panther Schools');
                // Add Email to the List
                emailMessages.add(email);
            }
        }
        // insert Task Record
        insert taskRecordToInsertList;
        // 200 times
        
        // Send Email
        List<Messaging.SendEmailResult> sendEmailResults = Messaging.sendEmail(emailMessages, false);
        for(Messaging.SendEmailResult sr: sendEmailResults){ // 10 Emails - 8 Success, 2 Fail
            Boolean isSuccess = sr.isSuccess(); // True OR False
            if(isSuccess){
                System.debug('Email Sent Successfully!!');
            }else{
                System.debug('Error while sending Email \n ');
                List<Messaging.SendEmailError> errors = sr.getErrors();
                System.debug(errors);
            }
        }
    }
    // after update
    public static void handleAfterUpdate(){
        /*Account accRecord = new Account(Name = 'Salesforce.com Account');
        insert accRecord;
        // 151th DML
        Payment__c paymentRecord = new Payment__c(Account__c = accRecord.Id);
        insert paymentRecord;*/
    }
    
    @TestVisible
    private static void handleTest(){
        
    }
    
    public static void createContact(ContactInputWrapper wrapper){
        //FirstName, LastName, Email, Phone, Fax, Address
        Contact con = new Contact();
        con.FirstName = wrapper.firstName;
    }
    
    public class ContactInputWrapper {
        public String firstName;
        public String lastName;
        public String email;
        public String phone;
        public String fax;
        public String street;
        public String postalCode;
        public String country;
        public String state;
        public String city;
        public Date dob;
        public String title;
        public String accountId;
    }
    
    // Inner Class <> Wrapper Class
    public class AccountWrapper {
        // Variables
        // methods
    }
    
}