public class SOQLDemo {
    
    public void searchAccount(String accountName){
        // Like
        String likeParam = '%'+accountName+'%';
        List<Account> accountList = [SELECT Id, Name FROM Account WHERE Name Like:likeParam];
        System.debug(accountList);
    }
    
    public static void query(String objectApiName, String fieldsToReturn, Integer limitCount,
                             String filterCondition, Map<String, Object> variableBinds){
        // Known information
        // Object API Name
        // Fields to Return
        String queryString = 'SELECT '+fieldsToReturn+' FROM '+objectApiName+' WHERE '+filterCondition+' LIMIT '+limitCount;
        System.debug(queryString);
        // SELECT Id, Name FROM Account WHERE Name Like:likeParam  LIMIT 5
        List<sObject> records = Database.queryWithBinds(queryString, variableBinds, AccessLevel.USER_MODE);
        System.debug('records '+records);
        /*
         	Map<String, object> variableBinds = new Map<String, Object>();
            variableBinds.put('likeParam', '%uni%');
            variableBinds.put('accountName', 'Amazon.com');
            SOQLDemo.query('Account', 'Id, Name', 5, 'Name Like:likeParam OR Name =:accountName ',variableBinds);
        */ 
    }
}