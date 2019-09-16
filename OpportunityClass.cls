public class OpportunityClass{
    public static void DocusignContent(List<Opportunity> oppList){
        Set<Id> OpportunityIds = new Set<Id>(); 
        List<OpportunityLineItem> olis = new List<OpportunityLineItem>();
        List<OpportunityLineItem> panels = new List<OpportunityLineItem>();
        List<OpportunityLineItem> inverters = new List<OpportunityLineItem>();
        for(Opportunity Opp : oppList){
            OpportunityIds.add(Opp.Id);
        }
        if(OpportunityIds.size() > 0){
            olis  = [SELECT Product2.Family, Product2.Name, Product2.Manufacturer__c, OpportunityId,Product2.Wattage__c, Quantity FROM OpportunityLineItem WHERE OpportunityId IN: OpportunityIds LIMIT 10000];
            panels = [SELECT Id FROM OpportunityLineItem WHERE OpportunityId IN: OpportunityIds AND Product2.Family = 'Panels' LIMIT 1];
            inverters = [SELECT Id FROM OpportunityLineItem WHERE OpportunityId IN: OpportunityIds AND Product2.Family = 'Inverters' LIMIT 1];
            for(Opportunity Opp : oppList) {   
                if (!olis.isEmpty()) {         
                    for (OpportunityLineItem oli : olis) {
                        if(Opp.Id == oli.OpportunityId){
                            if (panels.isEmpty()) {
                                opp.Panel_Name__c         = null;
                                opp.Panel_Wattage__c      = null;
                                opp.Panel_Manufacturer__c = null;
                            } else if (inverters.isEmpty()) {
                                opp.Inverter_Name__c         = null;
                                opp.Inverter_Manufacturer__c = null;
                                opp.Inverter_Quantity__c     = null;
                            } 
                            if (oli.Product2.Family == 'Inverters') {
                                opp.Inverter_Name__c         = oli.Product2.Name;
                                opp.Inverter_Manufacturer__c = oli.Product2.Manufacturer__c;
                                opp.Inverter_Quantity__c     = oli.Quantity;
                            } else if (oli.Product2.Family == 'Panels') {
                                opp.Panel_Name__c         = oli.Product2.Name;
                                opp.Panel_Wattage__c      = oli.Product2.Wattage__c;
                                opp.Panel_Manufacturer__c = oli.Product2.Manufacturer__c;
                            }
                        }
                    }
                } else if (panels.isEmpty() && inverters.isEmpty()) {
                    opp.Inverter_Name__c         = null;
                    opp.Panel_Name__c            = null;
                    opp.Panel_Wattage__c         = null;
                    opp.Panel_Manufacturer__c    = null;
                    opp.Inverter_Manufacturer__c = null;
                    opp.Inverter_Quantity__c     = null;
                }
            }
        }
    }

    public static void NameOpportunity(List<Opportunity> oppList){
        Set<Id> AccountIds = new Set<Id>(); // Initialize a list of Ids
        Map<Id, Account> accountMap = new Map<Id, Account>();
        
        // Add an account ID to the list for every opportunity caught by trigger
        for (Opportunity op : oppList) {
            if(op.AccountId != null) {
                AccountIds.add(op.AccountId);
            }
        }
        
        // Create a map of Ids and account, querying the name from account records whose Id is in the AccountIds list generated earlier
        if(AccountIds.size() > 0) {
            accountMap = new Map<Id, Account>([SELECT Name,Mailing_City__c, Mailing_State__c FROM Account WHERE Id IN : AccountIds]);
        }
        System.debug(accountMap);
        
        // Update the Opportunity name for every opportunity entering the trigger that has an Account
        if(!accountMap.isEmpty()) {
            for (Opportunity myOpp : oppList) {
                if (myOpp.AccountId != null) {
                    // User checks the checkbox
                    if (myOpp.Same_as_Mailing_Address__c == true && accountMap.get(myOpp.AccountId).Mailing_City__c != null && accountMap.get(myOpp.AccountId).Mailing_State__c != null) {
                            myOpp.Name = accountMap.get(myOpp.AccountId).Name + ' - ' + accountMap.get(myOpp.AccountId).Mailing_City__c + ', ' + accountMap.get(myOpp.AccountId).Mailing_State__c;
                    } 
                    // User manually enters project address, checkbox unchecked
                    else if (myOpp.Same_as_Mailing_Address__c == false) {
                        // Project city and state entered
                        if (myOpp.Project_City__c != null && myOpp.Project_State__c != null) {
                                myOpp.Name = accountMap.get(myOpp.AccountId).Name + ' - ' + myOpp.Project_City__c + ', ' + myOpp.Project_State__c;
                        } 
                        // No Project state entered
                        else if (myOpp.Project_City__c != null && myOpp.Project_State__c == null) {
                                myOpp.Name = accountMap.get(myOpp.AccountId).Name + ' - ' + myOpp.Project_City__c;
                        }
                        // No Project city entered
                        else if (myOpp.Project_City__c == null && myOpp.Project_State__c != null) {
                                myOpp.Name = accountMap.get(myOpp.AccountId).Name + ' - ' + myOpp.Project_State__c;
                        // No Project city or Project state entered
                        } else if (myOpp.Project_City__c == null && myOpp.Project_State__c == null) {
                                myOpp.Name = accountMap.get(myOpp.AccountId).Name;
                        }
                    }
                }
            }
        }
    }
}