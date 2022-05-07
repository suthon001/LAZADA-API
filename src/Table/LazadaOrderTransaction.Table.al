// <summary>
// Table Lazada Order Transaction (ID 50101).
// </summary>
table 50101 "Lazada Order Transaction"
{
    Caption = 'Lazada Order Transaction';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Tax Amount"; Decimal)
        {
            Caption = 'Tax Amount';
            DataClassification = ToBeClassified;
        }
        field(3; "Voucher Seller"; Decimal)
        {
            Caption = 'Voucher Seller';
            DataClassification = ToBeClassified;
        }
        field(5; "Purchase Order ID"; Code[50])
        {
            Caption = 'Purchase Order ID';
            DataClassification = ToBeClassified;
        }
        field(6; "Voucher Code Seller"; Code[50])
        {
            Caption = 'Voucher Code Seller';
            DataClassification = ToBeClassified;
        }
        field(7; "Voucher Code"; Code[50])
        {
            Caption = 'Voucher Code';
            DataClassification = ToBeClassified;
        }
        field(8; "Package ID"; Code[50])
        {
            Caption = 'Package ID';
            DataClassification = ToBeClassified;
        }
        field(9; "Buyer ID"; Code[50])
        {
            Caption = 'Buyer ID';
            DataClassification = ToBeClassified;
        }
        field(10; "Variation"; Code[50])
        {
            Caption = 'Variation';
            DataClassification = ToBeClassified;
        }
        field(11; "Product ID"; Code[50])
        {
            Caption = 'Product ID';
            DataClassification = ToBeClassified;
        }
        field(12; "Voucher code Platform"; Code[50])
        {
            Caption = 'Voucher code Platform';
            DataClassification = ToBeClassified;
        }
        field(13; "Purchase Order Number"; Code[50])
        {
            Caption = 'Purchase Order Number';
            DataClassification = ToBeClassified;
        }
        field(14; "Sku"; Code[50])
        {
            Caption = 'Sku';
            DataClassification = ToBeClassified;
        }
        field(15; "Order type"; text[50])
        {
            Caption = 'Order type';
            DataClassification = ToBeClassified;
        }
        field(16; "Invoice Number"; Code[50])
        {
            Caption = 'Invoice Number';
            DataClassification = ToBeClassified;
        }
        field(17; "Cancel Return initiator"; Text[100])
        {
            Caption = 'Cancel Return initiator';
            DataClassification = ToBeClassified;
        }
        field(18; "Shop Sku"; Code[50])
        {
            Caption = 'Shop Sku';
            DataClassification = ToBeClassified;
        }
        field(19; "Is reroute"; Code[10])
        {
            Caption = 'Is reroute';
            DataClassification = ToBeClassified;
        }
        field(20; "Stage Pay Status"; text[50])
        {
            Caption = 'Stage Pay Status';
            DataClassification = ToBeClassified;
        }
        field(21; "Sku ID"; Code[50])
        {
            Caption = 'Sku ID';
            DataClassification = ToBeClassified;
        }
        field(22; "Tracking code pre"; Code[50])
        {
            Caption = 'Tracking code pre';
            DataClassification = ToBeClassified;
        }
        field(23; "Order Item ID"; Code[50])
        {
            Caption = 'Order Item ID';
            DataClassification = ToBeClassified;
        }
        field(24; "Shop ID"; Code[50])
        {
            Caption = 'Shop ID';
            DataClassification = ToBeClassified;
        }
        field(25; "Order flag"; Code[10])
        {
            Caption = 'Order fla';
            DataClassification = ToBeClassified;
        }
        field(26; "Is fbl"; Code[10])
        {
            Caption = 'Is fbl';
            DataClassification = ToBeClassified;
        }
        field(27; "Name"; text[150])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(28; "Delivery option sof"; Code[10])
        {
            Caption = 'Delivery option sof';
            DataClassification = ToBeClassified;
        }
        field(29; "Order ID"; Code[50])
        {
            Caption = 'Order ID';
            DataClassification = ToBeClassified;
        }
        field(30; "Voucher Platform"; Decimal)
        {
            Caption = 'Voucher Platform';
            DataClassification = ToBeClassified;
        }
        field(31; "Product main image"; text[250])
        {
            Caption = 'Product main image';
            DataClassification = ToBeClassified;
        }
        field(32; "Paid price"; Decimal)
        {
            Caption = 'Paid price';
            DataClassification = ToBeClassified;
        }
        field(33; "Product detail url"; text[250])
        {
            Caption = 'Product detail url';
            DataClassification = ToBeClassified;
        }
        field(34; "Warehouse Code"; Code[20])
        {
            Caption = 'Warehouse Code';
            DataClassification = ToBeClassified;
        }
        field(35; "Shipping type"; Text[100])
        {
            Caption = 'Shipping type';
            DataClassification = ToBeClassified;
        }
        field(36; "Voucher Seller lpi"; Decimal)
        {
            Caption = 'Voucher Seller lpi';
            DataClassification = ToBeClassified;
        }
        field(37; "Shipping fee discount platform"; Decimal)
        {
            Caption = 'Shipping fee discount platform';
            DataClassification = ToBeClassified;
        }
        field(38; "Wallet credits"; Decimal)
        {
            Caption = 'Wallet credits';
            DataClassification = ToBeClassified;
        }
        field(39; "Currency"; Code[10])
        {
            Caption = 'Currency';
            DataClassification = ToBeClassified;
        }
        field(40; "Shipping provider type"; text[50])
        {
            Caption = 'Shipping provider type';
            DataClassification = ToBeClassified;
        }
        field(41; "Voucher platform lpi"; Decimal)
        {
            Caption = 'Voucher platform lpi';
            DataClassification = ToBeClassified;
        }
        field(42; "Shipping fee original"; Decimal)
        {
            Caption = 'Shipping fee original';
            DataClassification = ToBeClassified;
        }
        field(43; "Item price"; Decimal)
        {
            Caption = 'Item price';
            DataClassification = ToBeClassified;
        }
        field(44; "Is digital"; Code[10])
        {
            Caption = 'Is digital';
            DataClassification = ToBeClassified;
        }
        field(45; "Shipping service cost"; Decimal)
        {
            Caption = 'Shipping service cost';
            DataClassification = ToBeClassified;
        }
        field(46; "Tracking code"; Code[50])
        {
            Caption = 'Tracking code';
            DataClassification = ToBeClassified;
        }
        field(47; "Shipping fee discount seller"; Decimal)
        {
            Caption = 'Shipping fee discount seller';
            DataClassification = ToBeClassified;
        }
        field(48; "Shipping amount"; Decimal)
        {
            Caption = 'Shipping amount';
            DataClassification = ToBeClassified;
        }
        field(49; "Reason detail"; text[100])
        {
            Caption = 'Reason detail';
            DataClassification = ToBeClassified;
        }
        field(50; "Return status"; Code[10])
        {
            Caption = 'Return status';
            DataClassification = ToBeClassified;
        }
        field(51; "Shipment provider"; Code[50])
        {
            Caption = 'Shipment provider';
            DataClassification = ToBeClassified;
        }
        field(52; "Voucher Amount"; Decimal)
        {
            Caption = 'Voucher Amoun';
            DataClassification = ToBeClassified;
        }
        field(53; "Digital delivery info"; Text[50])
        {
            Caption = 'Digital delivery info';
            DataClassification = ToBeClassified;
        }
        field(54; "Extra attributes"; Text[50])
        {
            Caption = 'Extra attribute';
            DataClassification = ToBeClassified;
        }
        field(55; "Sla Date"; Date)
        {
            Caption = 'Sla Date';
            DataClassification = ToBeClassified;
        }
        field(56; "Sla Time"; Time)
        {
            Caption = 'Sla Time';
            DataClassification = ToBeClassified;
        }
        field(57; "Pick up store address"; Text[150])
        {
            Caption = 'Pick up store address';
            DataClassification = ToBeClassified;
        }
        field(58; "Pick up store name"; Text[150])
        {
            Caption = 'Pick up store name';
            DataClassification = ToBeClassified;
        }
        field(59; "Pick up store code"; Text[100])
        {
            Caption = 'Pick up store code';
            DataClassification = ToBeClassified;
        }
        field(60; "Interface DateTime"; DateTime)
        {
            Caption = 'Interface DateTime';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    procedure "Get LastEntry"(): Integer
    var
        ltLazadatransaction: Record "Lazada Order Transaction";
    begin
        ltLazadatransaction.reset();
        ltLazadatransaction.SetCurrentKey("Entry No.");
        if ltLazadatransaction.FindLast() then
            exit(ltLazadatransaction."Entry No." + 1);
        exit(1);
    end;
}
