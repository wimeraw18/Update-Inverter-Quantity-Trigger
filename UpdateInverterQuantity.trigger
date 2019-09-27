trigger UpdateInverterQuantity on OpportunityLineItem (before insert, before update) {
    Map<Id, Product2> panelProdMap = new Map<Id, Product2>([ // create map for panel products
        SELECT Id, Name 
          FROM Product2
         WHERE Name = '60 MBLK Home PV' 
            OR Name = '60 M-HBLK'
    ]); 
    Map<Id, Product2> invProdMap = new Map<Id, Product2>([ // create map for inverters products
        SELECT Id, Name 
          FROM Product2
         WHERE Name = 'QS1' 
            OR Name = 'YC600'
    ]); 

    list<String> oppIds = new List<String>();
    for (OpportunityLineItem oli : Trigger.new ) { // loop through olis entering trigger, add their id's to a list oppIds
        oppIds.add(oli.OpportunityId);
    }
    list<OpportunityLineItem> panelOLIs = new list<OpportunityLineItem>(); 
    panelOLIs = [ // get all current panels in Opportunity Products
        SELECT Id, OpportunityId, Quantity, Product2.Name 
          FROM OpportunityLineItem
         WHERE OpportunityId IN :oppIds
           AND Product2Id IN :panelProdMap.keySet()
    ];
    Map<Id,OpportunityLineItem> panelOLImap = new Map<Id, OpportunityLineItem>();
    for (OpportunityLineItem oli : panelOLIs) { // loop through all current panels and add them to a map
        panelOLImap.put(oli.opportunityId, oli);
    }
    list<OpportunityLineItem> invOLIs = new list<OpportunityLineItem>();
    invOLIs = [  // get all current panels in Opportunity Products
        SELECT Id, OpportunityId, Quantity, Product2.Name  
          FROM OpportunityLineItem
         WHERE OpportunityId IN :oppIds
           AND Product2Id IN :invProdMap.keySet()
    ];
    Map<Id,OpportunityLineItem> invOLImap = new Map<Id, OpportunityLineItem>();
    for (OpportunityLineItem oli : invOLIs) { // loop through all current inverters and add them to a map
        invOLImap.put(oli.opportunityId, oli);
    }

    Integer divisor = 1; // initiate divisor for inverter quantity
    Integer panelQty; // initiate panel quantitfy
    OpportunityLineItem tempOLI; // initiate temporary oli
    List<OpportunityLineItem> toUpdate = new List<OpportunityLineItem>(); // initiate list for final update

    for (OpportunityLineItem oli : Trigger.new ) {
        System.debug('DEBUG - FOR LOOP');
        // Inverters inserted first
        if (trigger.isInsert && panelProdMap.ContainsKey(oli.Product2Id) && !invOLIs.isEmpty() ) {
            System.debug('DEBUG - inserting a panel with inverter already existing');
            if (invOLIs.get(0).Product2.Name == 'QS1' ) {
                divisor = 4;
            } else if (invOLIs.get(0).Product2.Name == 'YC600' ) {
                divisor = 2;
            }
            Decimal inverterQuantity = (oli.Quantity / divisor); 
            inverterQuantity = inverterQuantity.round(System.RoundingMode.CEILING); 
            invOLIs.get(0).Quantity = inverterQuantity;
            System.debug('DEBUG - Inverter Quantity = ' + inverterQuantity);
            update invOLIs;
        } else {
        // end Inverter inserted first
        if (trigger.isUpdate && panelProdMap.ContainsKey(oli.Product2Id )) {   // inserting/updating a panel oli
            System.debug('DEBUG - insert/update Panel');
if (invOLIs.get(0).Product2.Name == 'QS1' ) {
                divisor = 4;
            } else if (invOLIs.get(0).Product2.Name == 'YC600' ) {
                divisor = 2;
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
    }
    if (toUpdate.size() > 0  ) {
        update toUpdate;
    }
}