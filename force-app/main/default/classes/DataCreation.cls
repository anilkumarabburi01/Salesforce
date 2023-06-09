public class DataCreation {
    public void createAccountRecord(String Name,String Phone) {
        Account acc = new Account();
        acc.Name = Name;
        acc.Phone = Phone;
        insert acc;
    }
    
    public void createContactRecord(String fname,String lname,String email) {
        Contact con = new Contact();
        con.FirstName = fname;
        con.LastName = lname;
        con.Email = email;
        insert con;
    }
    
    public void createOpportunityRecord(String Name,Date closeDate,String StageName) {
        Opportunity opp = new Opportunity();
        opp.Name = Name;
        opp.CloseDate = closeDate;
        opp.StageName = StageName;
        insert opp;
    }
    
    public void createLeadRecord(String fname,String lname,String Company) {
        Lead lead = new Lead();
        lead.FirstName = fname;
        lead.LastName = lname;
        lead.Company = Company;
        insert lead;
    }
    
    public void createCampaignRecord(String Name,Date sDate,Date eDate) {
        Campaign camp = new Campaign();
        camp.Name = Name;
        camp.StartDate = sDate;
        camp.EndDate = eDate;
        insert camp;
    }
}