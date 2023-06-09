public class CreateRecords {
    
    public static void createRecords() {
        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();
        List<Opportunity> opportunities = new List<Opportunity>();
        
        // Creating 50 Accounts, Contacts, and Opportunities
        for (Integer i = 1; i <= 50; i++) {
            Account acc = new Account(Name = 'Test Account ' + i);
            Contact con = new Contact(FirstName = 'Test', LastName = 'Contact ' + i, AccountId = acc.Id);
            Opportunity opp = new Opportunity(Name = 'Test Opportunity ' + i, CloseDate = Date.today().addDays(i), AccountId = acc.Id, ContactId = con.Id, StageName = 'Prospecting');
            
            accounts.add(acc);
            contacts.add(con);
            opportunities.add(opp);
        }
        
        // Inserting the records in bulk
        insert accounts;
        insert contacts;
        insert opportunities;
    }
}