trigger OpportunityTrigger on Opportunity (before insert, before update) {
    if (trigger.isBefore && trigger.isUpdate){
        OpportunityClass.DocusignContent(trigger.new);
        OpportunityClass.NameOpportunity(trigger.new);
    } else if (trigger.isBefore && trigger.isInsert) {
        OpportunityClass.NameOpportunity(trigger.new);
    }
}