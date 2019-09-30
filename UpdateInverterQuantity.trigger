trigger UpdateInverterQuantity on OpportunityLineItem (before insert, before update) {
    Map<Id, Product2> panelProdMap = new Map<Id, Product2>([
        SELECT Id, Name 
          FROM Product2
         WHERE Name = '60 MBLK Home PV' 
            OR Name = '60 M-HBLK'
    ]); 
    Map<Id, Product2> invProdMap = new Map<Id, Product2>([
        SELECT Id, Name 
          FROM Product2
         WHERE Name = 'QS1' 
            OR Name = 'YC600'
    ]); 

    list<String> oppIds = new List<String>();
    for (OpportunityLineItem oli : Trigger.new ) {
        oppIds.add(oli.OpportunityId);
    }
    list<OpportunityLineItem> panelOLIs = new list<OpportunityLineItem>();
    panelOLIs = [
        SELECT Id, OpportunityId, Quantity, Product2.Name 
          FROM OpportunityLineItem
         WHERE OpportunityId IN :oppIds
           AND Product2Id IN :panelProdMap.keySet()
    ];
    Map<Id,OpportunityLineItem> panelOLImap = new Map<Id, OpportunityLineItem>();
    for (OpportunityLineItem oli : panelOLIs) {
        panelOLImap.put(oli.opportunityId, oli);
    }
    list<OpportunityLineItem> invOLIs = new list<OpportunityLineItem>();
    invOLIs = [
        SELECT Id, OpportunityId, Quantity, Product2.Name  
          FROM OpportunityLineItem
         WHERE OpportunityId IN :oppIds
           AND Product2Id IN :invProdMap.keySet()
    ];
    Map<Id,OpportunityLineItem> invOLImap = new Map<Id, OpportunityLineItem>();
    for (OpportunityLineItem oli : invOLIs) {
        invOLImap.put(oli.opportunityId, oli);
    }

    Integer divisor;
    Integer panelQty;
    OpportunityLineItem tempOLI;
    List<OpportunityLineItem> toUpdate = new List<OpportunityLineItem>();

    for (OpportunityLineItem oli : Trigger.new ) {
        System.debug('DEBUG - FOR LOOP');
        if (panelProdMap.ContainsKey(oli.Product2Id )) {   //inserting/updating a panel oli
            System.debug('DEBUG - insert/update Panel');
            if ( panelProdMap.get(oli.Product2Id).Name == '60 M-HBLK' ) {
                divisor = 4;
            } else if ( panelProdMap.get(oli.Product2Id).Name == '60 MBLK Home PV' ) {
                divisor = 2;
            } else {
                divisor = 1;
            }
            if (invOLImap.ContainsKey(oli.OpportunityId )) {
                System.debug('DEBUG - found previous invertors');
                tempOLI = invOLImap.get(oli.OpportunityId );     //we have a matching panel OLI
                Decimal inverterQuantity = (oli.Quantity / divisor); 
                inverterQuantity = inverterQuantity.round(System.RoundingMode.CEILING); 
                if (tempOLI.Quantity <> inverterQuantity ) {
                     tempOLI.Quantity = inverterQuantity;
                     toUpdate.add(tempOLI);
                }
            } 
        }
        if (invProdMap.ContainsKey(oli.Product2Id )) {     //inserting/updating a invertor oli
            if (trigger.isUpdate && (oli.Quantity <> trigger.oldMap.get(oli.Id).Quantity) ) {
                System.debug('DEBUG - update Invertor with old map');
                //quantity has been changed on the invertor - do something else
            } else {
                System.debug('DEBUG - insert Invertor');
                if ( invProdMap.get(oli.Product2Id).Name == 'QS1' ) {
                    divisor = 4;
                } else if ( invProdMap.get(oli.Product2Id).Name == 'YC600' ) {
                    divisor = 2;
                } else {
                    divisor = 1;
                }
                if (panelOLImap.ContainsKey(oli.OpportunityId )) {
                    System.debug('DEBUG - found previous panels');
                    tempOLI = panelOLImap.get(oli.OpportunityId );     //we have a matching panel OLI
                    Decimal inverterQuantity = (tempOLI.Quantity / divisor); 
                    inverterQuantity = inverterQuantity.round(System.RoundingMode.CEILING); 
                    if (oli.Quantity <> inverterQuantity ) {
                         oli.Quantity = inverterQuantity;
                    }
                }
            }
        }
    } 
    if (toUpdate.size() > 0  ) {
        update toUpdate;
    }
}