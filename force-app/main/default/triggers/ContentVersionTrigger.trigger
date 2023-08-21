trigger ContentVersionTrigger on ContentVersion (after insert) {
	/*
	 * Develop a solution so that whenever a file is getting inserted under Task, 
	 * Event or Case Object the same file should be linked to the related Account Record
	 */ 
    Set<Id> contentDocumentIdsSet = new Set<Id>();
    /* Step1 - Get the content document Id */
    for(ContentVersion version: Trigger.New){
        contentDocumentIdsSet.add(version.ContentDocumentId);
    }
    System.debug(' contentDocumentIdsSet '+ contentDocumentIdsSet);
    /* Step2 - Get the Content document link */
    List<ContentDocumentLink> contentDocumentLinkList = [SELECT Id, LinkedEntityId, ContentDocumentId
                                      FROM 
                                          ContentDocumentLink
                                      WHERE 
                                          ContentDocumentId IN: contentDocumentIdsSet
                                     ];
    
    // Check if the Version/File/Document is created under Task, Event or Case
    List<ContentDocumentLink> contentDocumentLinkToInsertList = new List<ContentDocumentLink>();
    Set<Id> taskIdsSet = new Set<Id>();
    Set<Id> caseIdsSet = new Set<Id>();
    Set<Id> eventIdsSet = new Set<Id>();
    for(ContentDocumentLink link: contentDocumentLinkList){ // 2
        // Check the sObjectType
        String sObjectName = link.LinkedEntityId.getSObjectType().getDescribe().getName(); // API Name
        if(sObjectName == 'Task'){
            taskIdsSet.add(link.LinkedEntityId);
        }else if(sObjectName == 'Case'){
            caseIdsSet.add(link.LinkedEntityId);
        }else if(sObjectName == 'Event'){
            eventIdsSet.add(link.LinkedEntityId);
        }
    }
    if(taskIdsSet.isEmpty() == false){
        // SOQL Query
        List<Task> taskList = [Select Id, WhatId FROM Task WHERE Id IN: taskIdsSet AND What.Type = 'Account'];
        for(ContentDocumentLink link: contentDocumentLinkList){
            String sObjectName = link.LinkedEntityId.getSObjectType().getDescribe().getName();
            if(sObjectName == 'Task'){
                for(Task t: taskList){
                    if(link.LinkedEntityId == t.Id){
                        // Link Clone 
                        ContentDocumentLink clonedLinkRecord = link.clone(false, false, false, false);
                        clonedLinkRecord.LinkedEntityId = t.WhatId;
                        contentDocumentLinkToInsertList.add(clonedLinkRecord);
                    }
                }
            }
        }
    }
    if(caseIdsSet.isEmpty() == false){
        // SOQL Query
        List<Case> caseList = [Select Id, AccountId FROM Case WHERE Id IN: caseIdsSet];
        for(ContentDocumentLink link: contentDocumentLinkList){
            String sObjectName = link.LinkedEntityId.getSObjectType().getDescribe().getName();
            if(sObjectName == 'Case'){
                for(Case c: caseList){
                    if(link.LinkedEntityId == c.Id){
                        // Link Clone 
                        ContentDocumentLink clonedLinkRecord = link.clone(false, false, false, false);
                        clonedLinkRecord.LinkedEntityId = c.AccountId;
                        contentDocumentLinkToInsertList.add(clonedLinkRecord);
                    }
                }
            }
        }
    }
    if(eventIdsSet.isEmpty() == false){
        // SOQL Query
        List<Event> eventList = [Select Id, WhatId FROM Event WHERE Id IN: eventIdsSet AND What.Type = 'Account'];
        for(ContentDocumentLink link: contentDocumentLinkList){
            String sObjectName = link.LinkedEntityId.getSObjectType().getDescribe().getName();
            if(sObjectName == 'Event'){
                for(Event evt: eventList){
                    if(link.LinkedEntityId == evt.Id){
                        // Link Clone 
                        ContentDocumentLink clonedLinkRecord = link.clone(false, false, false, false);
                        clonedLinkRecord.LinkedEntityId = evt.WhatId;
                        contentDocumentLinkToInsertList.add(clonedLinkRecord);
                    }
                }
            }
        }
    }
    insert contentDocumentLinkToInsertList;
}