global class AccountInsertAction {
     //iconName='slds:standard:account'
  @InvocableMethod(label='Insert Accounts'
                   iconName='slds:standard:account'
                   description='Inserts the accounts specified and returns the IDs of the new accounts.' category= 'Account')
  global static List<ID> insertAccounts(List<Account> accounts) {
    Database.SaveResult[] results = Database.insert(accounts);
    List<ID> accountIds = new List<ID>();
      for (Database.SaveResult result : results) {
      accountIds.add(result.getId());
    }
    return accountIds;
  }
}