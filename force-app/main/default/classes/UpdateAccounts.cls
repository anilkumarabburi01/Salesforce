public class UpdateAccounts {
    
    public static void updateAccountNames() {
        List<Account> accountsToUpdate = new List<Account>();
        
        List<Account> accounts = [SELECT Id, Name, CreatedDate FROM Account];
        for (Account acc : accounts) {
            if (acc.CreatedDate.date() == Date.today()) {
                acc.Name = 'Today Accounts';
            } else {
                acc.Name = 'Past Accounts';
            }
            accountsToUpdate.add(acc);
        }
        
        update accountsToUpdate;
    }
}