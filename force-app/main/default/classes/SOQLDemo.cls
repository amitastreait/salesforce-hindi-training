public class SOQLDemo {
    
    public void searchAccount(String accountName){
        // Like
        String likeParam = '%'+accountName+'%';
        List<Account> accountList = [SELECT Id, Name FROM Account  WHERE Name Like:likeParam];
        System.debug(accountList);
    }
}