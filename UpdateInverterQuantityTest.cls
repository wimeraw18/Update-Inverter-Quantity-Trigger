@isTest
private class UpdateInverterQuantityTest {
    /*
    INVERTER ONE = 'QS1'
    INVERTER TWO = 'YC600'
    PANEL ONE = '60 M-HBLK'
    PANEL TWO = '60 MBLK Home PV'
    */
    @isTest static void updatePanelOneQuantityWithInverterOne() {
        // create an opportunity
        Opportunity myOpp  = new Opportunity();
        myOpp.Name         = 'Test';
        myOpp.StageName    = 'Closed Won';
        myOpp.CloseDate    = Date.today();
        myOpp.Pricebook2Id = Test.getStandardPricebookId();
        insert myOpp;

        Id pricebookId = Test.getStandardPricebookId();

        //Create panel
        Product2 panel = new Product2(
            Name        = '60 M-HBLK',
            ProductCode = 'H300W',
            isActive    = true
        );
        insert panel;

        //Create inverter
        Product2 firstInverter = new Product2(
            Name        = 'QS1',
            ProductCode = 'APS',
            isActive    = true
        );
        insert firstInverter;

        //Create pricebook entry for panel
        PricebookEntry  panelEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = panel.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert panelEntry;

        //Create pricebook entry for inverter
        PricebookEntry inverterEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = firstInverter.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert inverterEntry;

         // add panel to opp products
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id       = panelEntry.Id,
            TotalPrice       = 20 * panelEntry.UnitPrice
        );
        insert oli;
        System.debug('TEST DEBUG - Inserted panel oli');

        // add inverter to opp products
        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id = inverterEntry.Id,
            TotalPrice       = 20 * inverterEntry.UnitPrice
        );
        insert oli2;
        System.debug('TEST DEBUG - Inserted inverter oli');

        // Get updated inverter quantity
        OpportunityLineItem inverter = [
            SELECT Quantity
              FROM OpportunityLineItem
             WHERE OpportunityId = :oli.OpportunityId
               AND Id = :oli2.Id
             LIMIT 1
        ];

        System.assertEquals(5, inverter.Quantity);

        // Update quantity of panels
        oli.Quantity = 40;
        update oli;

        // Get updated quantity of inverters
        OpportunityLineItem updatedInverter = [
            SELECT Quantity
              FROM OpportunityLineItem
             WHERE OpportunityId = :oli.OpportunityId
               AND Id = :oli2.Id
             LIMIT 1
        ];

        System.assertEquals(10, updatedInverter.Quantity);
    }
    @isTest static void updatePanelTwoQuantityWithInverterOne() {
        // create an opportunity
        Opportunity myOpp  = new Opportunity();
        myOpp.Name         = 'Test';
        myOpp.StageName    = 'Closed Won';
        myOpp.CloseDate    = Date.today();
        myOpp.Pricebook2Id = Test.getStandardPricebookId();
        insert myOpp;

        Id pricebookId = Test.getStandardPricebookId();

        //Create panel
        Product2 panel = new Product2(
            Name        = '60 MBLK Home PV',
            ProductCode = 'H300W',
            isActive    = true
        );
        insert panel;

        //Create inverter
        Product2 firstInverter = new Product2(
            Name        = 'QS1',
            ProductCode = 'APS',
            isActive    = true
        );
        insert firstInverter;

        //Create pricebook entry for panel
        PricebookEntry  panelEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = panel.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert panelEntry;

        //Create pricebook entry for inverter
        PricebookEntry inverterEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = firstInverter.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert inverterEntry;

         // add panel to opp products
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id       = panelEntry.Id,
            TotalPrice       = 20 * panelEntry.UnitPrice
        );
        insert oli;
        System.debug('TEST DEBUG - Inserted panel oli');

        // add inverter to opp products
        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id = inverterEntry.Id,
            TotalPrice       = 20 * inverterEntry.UnitPrice
        );
        insert oli2;
        System.debug('TEST DEBUG - Inserted inverter oli');

        // Get updated inverter quantity
        OpportunityLineItem inverter = [
            SELECT Quantity
              FROM OpportunityLineItem
             WHERE OpportunityId = :oli.OpportunityId
               AND Id = :oli2.Id
             LIMIT 1
        ];

        System.assertEquals(5, inverter.Quantity);

        // Update quantity of panels
        oli.Quantity = 40;
        update oli;

        // Get updated quantity of inverters
        OpportunityLineItem updatedInverter = [
            SELECT Quantity
              FROM OpportunityLineItem
             WHERE OpportunityId = :oli.OpportunityId
               AND Id = :oli2.Id
             LIMIT 1
        ];

        System.assertEquals(10, updatedInverter.Quantity);
    }
    @isTest static void updatePanelOneQuantityWithInverterTwo() {
        // create an opportunity
        Opportunity myOpp  = new Opportunity();
        myOpp.Name         = 'Test';
        myOpp.StageName    = 'Closed Won';
        myOpp.CloseDate    = Date.today();
        myOpp.Pricebook2Id = Test.getStandardPricebookId();
        insert myOpp;

        Id pricebookId = Test.getStandardPricebookId();

        //Create panel
        Product2 panel = new Product2(
            Name        = '60 M-HBLK',
            ProductCode = 'H300W',
            isActive    = true
        );
        insert panel;

        //Create inverter
        Product2 firstInverter = new Product2(
            Name        = 'YC600',
            ProductCode = 'APS',
            isActive    = true
        );
        insert firstInverter;

        //Create pricebook entry for panel
        PricebookEntry  panelEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = panel.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert panelEntry;

        //Create pricebook entry for inverter
        PricebookEntry inverterEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = firstInverter.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert inverterEntry;

         // add panel to opp products
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id       = panelEntry.Id,
            TotalPrice       = 20 * panelEntry.UnitPrice
        );
        insert oli;
        System.debug('TEST DEBUG - Inserted panel oli');

        // add inverter to opp products
        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id = inverterEntry.Id,
            TotalPrice       = 20 * inverterEntry.UnitPrice
        );
        insert oli2;
        System.debug('TEST DEBUG - Inserted inverter oli');

        // Get updated inverter quantity
        OpportunityLineItem inverter = [
            SELECT Quantity
              FROM OpportunityLineItem
             WHERE OpportunityId = :oli.OpportunityId
               AND Id = :oli2.Id
             LIMIT 1
        ];

        System.assertEquals(10, inverter.Quantity);

        // Update quantity of panels
        oli.Quantity = 40;
        update oli;

        // Get updated quantity of inverters
        OpportunityLineItem updatedInverter = [
            SELECT Quantity
              FROM OpportunityLineItem
             WHERE OpportunityId = :oli.OpportunityId
               AND Id = :oli2.Id
             LIMIT 1
        ];

        System.assertEquals(20, updatedInverter.Quantity);
    }
    @isTest static void updatePanelTwoQuantityWithInverterTwo() {
        // create an opportunity
        Opportunity myOpp  = new Opportunity();
        myOpp.Name         = 'Test';
        myOpp.StageName    = 'Closed Won';
        myOpp.CloseDate    = Date.today();
        myOpp.Pricebook2Id = Test.getStandardPricebookId();
        insert myOpp;

        Id pricebookId = Test.getStandardPricebookId();

        //Create panel
        Product2 panel = new Product2(
            Name        = '60 MBLK Home PV',
            ProductCode = 'H300W',
            isActive    = true
        );
        insert panel;

        //Create inverter
        Product2 firstInverter = new Product2(
            Name        = 'YC600',
            ProductCode = 'APS',
            isActive    = true
        );
        insert firstInverter;

        //Create pricebook entry for panel
        PricebookEntry  panelEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = panel.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert panelEntry;

        //Create pricebook entry for inverter
        PricebookEntry inverterEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = firstInverter.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert inverterEntry;

         // add panel to opp products
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id       = panelEntry.Id,
            TotalPrice       = 20 * panelEntry.UnitPrice
        );
        insert oli;
        System.debug('TEST DEBUG - Inserted panel oli');

        // add inverter to opp products
        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id = inverterEntry.Id,
            TotalPrice       = 20 * inverterEntry.UnitPrice
        );
        insert oli2;
        System.debug('TEST DEBUG - Inserted inverter oli');

        // Get updated inverter quantity
        OpportunityLineItem inverter = [
            SELECT Quantity
              FROM OpportunityLineItem
             WHERE OpportunityId = :oli.OpportunityId
               AND Id = :oli2.Id
             LIMIT 1
        ];

        System.assertEquals(10, inverter.Quantity);

        // Update quantity of panels
        oli.Quantity = 40;
        update oli;

        // Get updated quantity of inverters
        OpportunityLineItem updatedInverter = [
            SELECT Quantity
              FROM OpportunityLineItem
             WHERE OpportunityId = :oli.OpportunityId
               AND Id = :oli2.Id
             LIMIT 1
        ];

        System.assertEquals(20, updatedInverter.Quantity);
    }
    @isTest static void addPanelOneThenAddInverterOne() {
        // create an opportunity
        Opportunity myOpp  = new Opportunity();
        myOpp.Name         = 'Test';
        myOpp.StageName    = 'Closed Won';
        myOpp.CloseDate    = Date.today();
        myOpp.Pricebook2Id = Test.getStandardPricebookId();
        insert myOpp;

        Id pricebookId = Test.getStandardPricebookId();

        //Create panel
        Product2 panel = new Product2(
            Name        = '60 M-HBLK',
            ProductCode = 'H300W',
            isActive    = true
        );
        insert panel;

        //Create inverter
        Product2 firstInverter = new Product2(
            Name        = 'QS1',
            ProductCode = 'H300W',
            isActive    = true
        );
        insert firstInverter;

        //Create pricebook entry for panel
        PricebookEntry  panelEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = panel.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert  panelEntry;

        //Create pricebook entry for inverter
        PricebookEntry inverterEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = firstInverter.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert inverterEntry;

        //create opportunity line item.
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            // PricebookEntryId = panelEntry.Id,
            Product2Id       = panel.Id,
            TotalPrice       = 20 * panelEntry.UnitPrice
        );
        insert oli;

        //create opportunity line item.
        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            // PricebookEntryId = inverterEntry.Id,
            Product2Id       = firstInverter.Id,
            TotalPrice       = 20 * inverterEntry.UnitPrice
        );
        insert oli2;

        OpportunityLineItem inverter = [
            SELECT Quantity
              FROM OpportunityLineItem
             WHERE OpportunityId = :oli.OpportunityId
               AND Id = :oli2.Id
             LIMIT 1
        ];

        System.assertEquals(5, inverter.Quantity);
    }
    @isTest static void addPanelTwoThenAddInverterOne() {
        // create an opportunity
        Opportunity myOpp  = new Opportunity();
        myOpp.Name         = 'Test';
        myOpp.StageName    = 'Closed Won';
        myOpp.CloseDate    = Date.today();
        myOpp.Pricebook2Id = Test.getStandardPricebookId();
        insert myOpp;

        Id pricebookId = Test.getStandardPricebookId();

        //Create panel
        Product2 panel = new Product2(
            Name        = '60 M-HBLK',
            ProductCode = 'H300W',
            isActive    = true
        );
        insert panel;

        //Create inverter
        Product2 firstInverter = new Product2(
            Name        = 'YC600',
            ProductCode = 'YC600',
            isActive    = true
        );
        insert firstInverter;

        //Create pricebook entry for panel
        PricebookEntry  panelEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = panel.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert  panelEntry;

        //Create pricebook entry for inverter
        PricebookEntry inverterEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = firstInverter.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert inverterEntry;

        //create opportunity line item.
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id       = panel.Id,
            TotalPrice       = 20 * panelEntry.UnitPrice
        );
        insert oli;

        //create opportunity line item.
        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id       = firstInverter.Id,
            TotalPrice       = 20 * inverterEntry.UnitPrice
        );
        insert oli2;

        OpportunityLineItem inverter = [
            SELECT Quantity
                FROM OpportunityLineItem
                WHERE OpportunityId = :oli.OpportunityId
                AND Id = :oli2.Id
                LIMIT 1
        ];

        System.assertEquals(10, inverter.Quantity);
    }
    @isTest static void addPanelOneThenAddInverterTwo() {
        // create an opportunity
        Opportunity myOpp  = new Opportunity();
        myOpp.Name         = 'Test';
        myOpp.StageName    = 'Closed Won';
        myOpp.CloseDate    = Date.today();
        myOpp.Pricebook2Id = Test.getStandardPricebookId();
        insert myOpp;

        Id pricebookId = Test.getStandardPricebookId();

        //Create panel
        Product2 panel = new Product2(
            Name        = '60 MBLK Home PV',
            ProductCode = 'H310W',
            isActive    = true
        );
        insert panel;

        //Create inverter
        Product2 firstInverter = new Product2(
            Name        = 'QS1',
            ProductCode = 'QS1',
            isActive    = true
        );
        insert firstInverter;

        //Create pricebook entry for panel
        PricebookEntry  panelEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = panel.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert  panelEntry;

        //Create pricebook entry for inverter
        PricebookEntry inverterEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = firstInverter.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert inverterEntry;

        //create opportunity line item.
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id = panel.Id,
            TotalPrice       = 20 * panelEntry.UnitPrice
        );
        insert oli;

        //create opportunity line item.
        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id       = firstInverter.Id,
            TotalPrice       = 20 * inverterEntry.UnitPrice
        );
        insert oli2;

        OpportunityLineItem inverter = [
            SELECT Quantity
                FROM OpportunityLineItem
                WHERE OpportunityId = :oli.OpportunityId
                AND Id = :oli2.Id
                LIMIT 1
        ];

        System.assertEquals(5, inverter.Quantity);
    }
    @isTest static void addPanelTwoThenAddInverterTwo() {
        // create an opportunity
        Opportunity myOpp  = new Opportunity();
        myOpp.Name         = 'Test';
        myOpp.StageName    = 'Closed Won';
        myOpp.CloseDate    = Date.today();
        myOpp.Pricebook2Id = Test.getStandardPricebookId();
        insert myOpp;

        Id pricebookId = Test.getStandardPricebookId();

        //Create panel
        Product2 panel = new Product2(
            Name        = '60 MBLK Home PV',
            ProductCode = 'H310W',
            isActive    = true
        );
        insert panel;

        //Create inverter
        Product2 firstInverter = new Product2(
            Name        = 'YC600',
            ProductCode = 'YC600',
            isActive    = true
        );
        insert firstInverter;

        //Create pricebook entry for panel
        PricebookEntry  panelEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = panel.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert  panelEntry;

        //Create pricebook entry for inverter
        PricebookEntry inverterEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = firstInverter.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert inverterEntry;

        //create opportunity line item.
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id = panel.Id,
            TotalPrice       = 20 * panelEntry.UnitPrice
        );
        insert oli;

        //create opportunity line item.
        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id       = firstInverter.Id,
            TotalPrice       = 20 * inverterEntry.UnitPrice
        );
        insert oli2;

        OpportunityLineItem inverter = [
            SELECT Quantity
                FROM OpportunityLineItem
                WHERE OpportunityId = :oli.OpportunityId
                AND Id = :oli2.Id
                LIMIT 1
        ];

        System.assertEquals(10, inverter.Quantity);
    }
    @isTest static void addInverterOneThenAddPanelOne() {
        // create an opportunity
        Opportunity myOpp  = new Opportunity();
        myOpp.Name         = 'Test';
        myOpp.StageName    = 'Closed Won';
        myOpp.CloseDate    = Date.today();
        myOpp.Pricebook2Id = Test.getStandardPricebookId();
        insert myOpp;

        Id pricebookId = Test.getStandardPricebookId();

        //Create panel
        Product2 panel = new Product2(
            Name        = '60 M-HBLK',
            ProductCode = 'H310W',
            isActive    = true
        );
        insert panel;

        //Create inverter
        Product2 firstInverter = new Product2(
            Name        = 'QS1',
            ProductCode = 'QS1',
            isActive    = true
        );
        insert firstInverter;

        //Create pricebook entry for panel
        PricebookEntry  panelEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = panel.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert  panelEntry;

        //Create pricebook entry for inverter
        PricebookEntry inverterEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = firstInverter.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert inverterEntry;
        
        //create opportunity line item.
        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 1,
            Product2Id       = firstInverter.Id,
            TotalPrice       = 1 * inverterEntry.UnitPrice
        );
        insert oli2;

        //create opportunity line item.
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id = panel.Id,
            TotalPrice       = 20 * panelEntry.UnitPrice
        );
        insert oli;

        OpportunityLineItem inverter = [
            SELECT Quantity
                FROM OpportunityLineItem
                WHERE OpportunityId = :oli.OpportunityId
                AND Id = :oli2.Id
                LIMIT 1
        ];

        System.assertEquals(5, inverter.Quantity);
    }
    @isTest static void addInverterTwoThenAddPanelOne() {
        // create an opportunity
        Opportunity myOpp  = new Opportunity();
        myOpp.Name         = 'Test';
        myOpp.StageName    = 'Closed Won';
        myOpp.CloseDate    = Date.today();
        myOpp.Pricebook2Id = Test.getStandardPricebookId();
        insert myOpp;

        Id pricebookId = Test.getStandardPricebookId();

        //Create panel
        Product2 panel = new Product2(
            Name        = '60 M-HBLK',
            ProductCode = 'H310W',
            isActive    = true
        );
        insert panel;

        //Create inverter
        Product2 firstInverter = new Product2(
            Name        = 'YC600',
            ProductCode = 'YC600',
            isActive    = true
        );
        insert firstInverter;

        //Create pricebook entry for panel
        PricebookEntry  panelEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = panel.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert  panelEntry;

        //Create pricebook entry for inverter
        PricebookEntry inverterEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = firstInverter.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert inverterEntry;
        
        //create opportunity line item.
        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 1,
            Product2Id       = firstInverter.Id,
            TotalPrice       = 1 * inverterEntry.UnitPrice
        );
        insert oli2;

        //create opportunity line item.
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id = panel.Id,
            TotalPrice       = 20 * panelEntry.UnitPrice
        );
        insert oli;

        OpportunityLineItem inverter = [
            SELECT Quantity
                FROM OpportunityLineItem
                WHERE OpportunityId = :oli.OpportunityId
                AND Id = :oli2.Id
                LIMIT 1
        ];

        System.assertEquals(10, inverter.Quantity);
    }
    @isTest static void addInverterOneThenAddPanelTwo() {
        // create an opportunity
        Opportunity myOpp  = new Opportunity();
        myOpp.Name         = 'Test';
        myOpp.StageName    = 'Closed Won';
        myOpp.CloseDate    = Date.today();
        myOpp.Pricebook2Id = Test.getStandardPricebookId();
        insert myOpp;

        Id pricebookId = Test.getStandardPricebookId();

        //Create panel
        Product2 panel = new Product2(
            Name        = '60 MBLK Home PV',
            ProductCode = 'H310W',
            isActive    = true
        );
        insert panel;

        //Create inverter
        Product2 firstInverter = new Product2(
            Name        = 'QS1',
            ProductCode = 'QS1',
            isActive    = true
        );
        insert firstInverter;

        //Create pricebook entry for panel
        PricebookEntry  panelEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = panel.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert  panelEntry;

        //Create pricebook entry for inverter
        PricebookEntry inverterEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = firstInverter.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert inverterEntry;
        
        //create opportunity line item.
        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 1,
            Product2Id       = firstInverter.Id,
            TotalPrice       = 1 * inverterEntry.UnitPrice
        );
        insert oli2;

        //create opportunity line item.
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id = panel.Id,
            TotalPrice       = 20 * panelEntry.UnitPrice
        );
        insert oli;

        OpportunityLineItem inverter = [
            SELECT Quantity
                FROM OpportunityLineItem
                WHERE OpportunityId = :oli.OpportunityId
                AND Id = :oli2.Id
                LIMIT 1
        ];

        System.assertEquals(5, inverter.Quantity);
    }
    @isTest static void addInverterTwoThenAddPanelTwo() {
        // create an opportunity
        Opportunity myOpp  = new Opportunity();
        myOpp.Name         = 'Test';
        myOpp.StageName    = 'Closed Won';
        myOpp.CloseDate    = Date.today();
        myOpp.Pricebook2Id = Test.getStandardPricebookId();
        insert myOpp;

        Id pricebookId = Test.getStandardPricebookId();

        //Create panel
        Product2 panel = new Product2(
            Name        = '60 MBLK Home PV',
            ProductCode = 'H310W',
            isActive    = true
        );
        insert panel;

        //Create inverter
        Product2 firstInverter = new Product2(
            Name        = 'YC600',
            ProductCode = 'YC600',
            isActive    = true
        );
        insert firstInverter;

        //Create pricebook entry for panel
        PricebookEntry  panelEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = panel.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert  panelEntry;

        //Create pricebook entry for inverter
        PricebookEntry inverterEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = firstInverter.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert inverterEntry;
        
        //create opportunity line item.
        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 1,
            Product2Id       = firstInverter.Id,
            TotalPrice       = 1 * inverterEntry.UnitPrice
        );
        insert oli2;

        //create opportunity line item.
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id = panel.Id,
            TotalPrice       = 20 * panelEntry.UnitPrice
        );
        insert oli;

        OpportunityLineItem inverter = [
            SELECT Quantity
                FROM OpportunityLineItem
                WHERE OpportunityId = :oli.OpportunityId
                AND Id = :oli2.Id
                LIMIT 1
        ];

        System.assertEquals(10, inverter.Quantity);
    }
    @isTest static void addInverterWithNonPanel() {
        // create an opportunity
        Opportunity myOpp  = new Opportunity();
        myOpp.Name         = 'Test';
        myOpp.StageName    = 'Closed Won';
        myOpp.CloseDate    = Date.today();
        myOpp.Pricebook2Id = Test.getStandardPricebookId();
        insert myOpp;

        Id pricebookId = Test.getStandardPricebookId();

        //Create panel
        Product2 panel = new Product2(
            Name        = 'Not a panel',
            ProductCode = 'test',
            isActive    = true
        );
        insert panel;

        //Create inverter
        Product2 firstInverter = new Product2(
            Name        = 'YC600',
            ProductCode = 'YC600',
            isActive    = true
        );
        insert firstInverter;

        //Create pricebook entry for panel
        PricebookEntry  panelEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = panel.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert  panelEntry;

        //Create pricebook entry for inverter
        PricebookEntry inverterEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = firstInverter.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert inverterEntry;

        //create opportunity line item.
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id = panel.Id,
            TotalPrice       = 20 * panelEntry.UnitPrice
        );
        insert oli;

        //create opportunity line item.
        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id       = firstInverter.Id,
            TotalPrice       = 20 * inverterEntry.UnitPrice
        );
        insert oli2;

        OpportunityLineItem inverter = [
            SELECT Quantity
                FROM OpportunityLineItem
                WHERE OpportunityId = :oli.OpportunityId
                AND Id = :oli2.Id
                LIMIT 1
        ];

        System.assertEquals(20, inverter.Quantity);
    } 
    @isTest static void addNonInverterWithPanel() {
        // create an opportunity
        Opportunity myOpp  = new Opportunity();
        myOpp.Name         = 'Test';
        myOpp.StageName    = 'Closed Won';
        myOpp.CloseDate    = Date.today();
        myOpp.Pricebook2Id = Test.getStandardPricebookId();
        insert myOpp;

        Id pricebookId = Test.getStandardPricebookId();

        //Create panel
        Product2 panel = new Product2(
            Name        = '60 M-HBLK',
            ProductCode = 'test',
            isActive    = true
        );
        insert panel;

        //Create inverter
        Product2 firstInverter = new Product2(
            Name        = 'Not an inverter',
            ProductCode = '1000',
            isActive    = true
        );
        insert firstInverter;

        //Create pricebook entry for panel
        PricebookEntry  panelEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = panel.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert  panelEntry;

        //Create pricebook entry for inverter
        PricebookEntry inverterEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = firstInverter.Id,
            UnitPrice    = 100.00,
            IsActive     = true
        );
        insert inverterEntry;

        //create opportunity line item.
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id = panel.Id,
            TotalPrice       = 20 * panelEntry.UnitPrice
        );
        insert oli;

        //create opportunity line item.
        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId    = myOpp.Id,
            Quantity         = 20,
            Product2Id       = firstInverter.Id,
            TotalPrice       = 20 * inverterEntry.UnitPrice
        );
        insert oli2;

        OpportunityLineItem inverter = [
            SELECT Quantity
                FROM OpportunityLineItem
                WHERE OpportunityId = :oli.OpportunityId
                AND Id = :oli2.Id
                LIMIT 1
        ];

        System.assertEquals(20, inverter.Quantity);
    } 
}