/// <summary>
/// Table Lazada Order Transaction (ID 50103).
/// </summary>
table 50103 "Lazada Order Transaction Line"
{
    Caption = 'Lazada Order Transaction Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "tax_amount"; Decimal)
        {
            Caption = 'Tax Amount';
            DataClassification = ToBeClassified;
        }
        field(3; "voucher_seller"; Decimal)
        {
            Caption = 'Voucher Seller';
            DataClassification = ToBeClassified;
        }
        field(5; "purchase_order_id"; Code[50])
        {
            Caption = 'Purchase Order ID';
            DataClassification = ToBeClassified;
        }
        field(6; "voucher_code_seller"; Code[50])
        {
            Caption = 'Voucher Code Seller';
            DataClassification = ToBeClassified;
        }
        field(7; "voucher_code"; Code[50])
        {
            Caption = 'Voucher Code';
            DataClassification = ToBeClassified;
        }
        field(8; "package_id"; Code[50])
        {
            Caption = 'Package ID';
            DataClassification = ToBeClassified;
        }
        field(9; "buyer_id"; Code[50])
        {
            Caption = 'Buyer ID';
            DataClassification = ToBeClassified;
        }
        field(10; "variation"; Code[50])
        {
            Caption = 'Variation';
            DataClassification = ToBeClassified;
        }
        field(11; "product_id"; Code[50])
        {
            Caption = 'Product ID';
            DataClassification = ToBeClassified;
        }
        field(12; "voucher_code_platform"; Code[50])
        {
            Caption = 'Voucher code Platform';
            DataClassification = ToBeClassified;
        }
        field(13; "purchase_order_number"; Code[50])
        {
            Caption = 'Purchase Order Number';
            DataClassification = ToBeClassified;
        }
        field(14; "sku"; Code[50])
        {
            Caption = 'Sku';
            DataClassification = ToBeClassified;
        }
        field(15; "order_type"; text[50])
        {
            Caption = 'Order type';
            DataClassification = ToBeClassified;
        }
        field(16; "invoice_number"; Code[50])
        {
            Caption = 'Invoice Number';
            DataClassification = ToBeClassified;
        }
        field(17; "cancel_return_initiator"; Text[100])
        {
            Caption = 'Cancel Return initiator';
            DataClassification = ToBeClassified;
        }
        field(18; "shop_sku"; Code[50])
        {
            Caption = 'Shop Sku';
            DataClassification = ToBeClassified;
        }
        field(19; "is_reroute"; Code[10])
        {
            Caption = 'Is reroute';
            DataClassification = ToBeClassified;
        }
        field(20; "stage_pay_status"; text[50])
        {
            Caption = 'Stage Pay Status';
            DataClassification = ToBeClassified;
        }
        field(21; "sku_id"; Code[50])
        {
            Caption = 'Sku ID';
            DataClassification = ToBeClassified;
        }
        field(22; "tracking_code_pre"; Code[50])
        {
            Caption = 'Tracking code pre';
            DataClassification = ToBeClassified;
        }
        field(23; "order_item_id"; Code[50])
        {
            Caption = 'Order Item ID';
            DataClassification = ToBeClassified;
        }
        field(24; "shop_id"; Code[50])
        {
            Caption = 'Shop ID';
            DataClassification = ToBeClassified;
        }
        field(25; "order_flag"; Code[10])
        {
            Caption = 'Order fla';
            DataClassification = ToBeClassified;
        }
        field(26; "is_fbl"; Code[10])
        {
            Caption = 'Is fbl';
            DataClassification = ToBeClassified;
        }
        field(27; "name"; text[150])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(28; "delivery_option_sof"; Code[10])
        {
            Caption = 'Delivery option sof';
            DataClassification = ToBeClassified;
        }
        field(29; "order_id"; Code[50])
        {
            Caption = 'Order ID';
            DataClassification = ToBeClassified;
        }
        field(30; "voucher_platform"; Decimal)
        {
            Caption = 'Voucher Platform';
            DataClassification = ToBeClassified;
        }
        field(31; "product_main_image"; text[250])
        {
            Caption = 'Product main image';
            DataClassification = ToBeClassified;
        }
        field(32; "paid_price"; Decimal)
        {
            Caption = 'Paid price';
            DataClassification = ToBeClassified;
        }
        field(33; "product_detail_url"; text[250])
        {
            Caption = 'Product detail url';
            DataClassification = ToBeClassified;
        }
        field(34; "warehouse_code"; Code[20])
        {
            Caption = 'Warehouse Code';
            DataClassification = ToBeClassified;
        }
        field(35; "shipping_type"; Text[100])
        {
            Caption = 'Shipping type';
            DataClassification = ToBeClassified;
        }
        field(36; "voucher_seller_lpi"; Decimal)
        {
            Caption = 'Voucher Seller lpi';
            DataClassification = ToBeClassified;
        }
        field(37; "shipping_fee_discount_platform"; Decimal)
        {
            Caption = 'Shipping fee discount platform';
            DataClassification = ToBeClassified;
        }
        field(38; "wallet_credits"; Decimal)
        {
            Caption = 'Wallet credits';
            DataClassification = ToBeClassified;
        }
        field(39; "currency"; Code[10])
        {
            Caption = 'Currency';
            DataClassification = ToBeClassified;
        }
        field(40; "shipping_provider_type"; text[50])
        {
            Caption = 'Shipping provider type';
            DataClassification = ToBeClassified;
        }
        field(41; "voucher_platform_lpi"; Decimal)
        {
            Caption = 'Voucher platform lpi';
            DataClassification = ToBeClassified;
        }
        field(42; "shipping_fee_original"; Decimal)
        {
            Caption = 'Shipping fee original';
            DataClassification = ToBeClassified;
        }
        field(43; "item_price"; Decimal)
        {
            Caption = 'Item price';
            DataClassification = ToBeClassified;
        }
        field(44; "is_digital"; Code[10])
        {
            Caption = 'Is digital';
            DataClassification = ToBeClassified;
        }
        field(45; "shipping_service_cost"; Decimal)
        {
            Caption = 'Shipping service cost';
            DataClassification = ToBeClassified;
        }
        field(46; "tracking_code"; Code[50])
        {
            Caption = 'Tracking code';
            DataClassification = ToBeClassified;
        }
        field(47; "shipping_fee_discount_seller"; Decimal)
        {
            Caption = 'Shipping fee discount seller';
            DataClassification = ToBeClassified;
        }
        field(48; "shipping_amount"; Decimal)
        {
            Caption = 'Shipping amount';
            DataClassification = ToBeClassified;
        }
        field(49; "reason_detail"; text[100])
        {
            Caption = 'Reason detail';
            DataClassification = ToBeClassified;
        }
        field(50; "return_status"; Code[10])
        {
            Caption = 'Return status';
            DataClassification = ToBeClassified;
        }
        field(51; "shipment_provider"; Code[50])
        {
            Caption = 'Shipment provider';
            DataClassification = ToBeClassified;
        }
        field(52; "voucher_amount"; Decimal)
        {
            Caption = 'Voucher Amoun';
            DataClassification = ToBeClassified;
        }
        field(53; "digital_delivery_info"; Text[50])
        {
            Caption = 'Digital delivery info';
            DataClassification = ToBeClassified;
        }
        field(54; "extra_attributes"; Text[50])
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
        field(57; "pick_up_store_address"; Text[150])
        {
            Caption = 'Pick up store address';
            DataClassification = ToBeClassified;
        }
        field(58; "pick_up_store_name"; Text[150])
        {
            Caption = 'Pick up store name';
            DataClassification = ToBeClassified;
        }
        field(59; "pick_up_store_code"; Text[100])
        {
            Caption = 'Pick up store code';
            DataClassification = ToBeClassified;
        }
        field(60; "Interface DateTime"; DateTime)
        {
            Caption = 'Interface DateTime';
            DataClassification = ToBeClassified;
        }
        field(61; "reason"; Text[100])
        {
            Caption = 'Reason';
            DataClassification = ToBeClassified;
        }
        field(62; "status"; Text[50])
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; order_id, "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Entry No." := "Get LastEntry";
    end;
    /// <summary>
    /// Get LastEntry.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure "Get LastEntry"(): Integer
    var
        ltLazadatransaction: Record "Lazada Order Transaction Line";
    begin
        ltLazadatransaction.reset();
        ltLazadatransaction.SetCurrentKey(order_id, "Entry No.");
        ltLazadatransaction.SetRange(order_id, Rec.order_id);
        if ltLazadatransaction.FindLast() then
            exit(ltLazadatransaction."Entry No." + 1);
        exit(1);
    end;


}
