/// <summary>
/// Table Lazada Order Trans. Header (ID 50102).
/// </summary>
table 50102 "Lazada Order Trans. Header"
{
    Caption = 'Lazada Order Transaction Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "order_id"; Code[50])
        {
            Caption = 'Order ID';
            DataClassification = ToBeClassified;
        }
        field(2; "order_number"; Code[50])
        {
            Caption = 'Order Number';
            DataClassification = ToBeClassified;
        }
        field(3; "voucher_code"; Code[50])
        {
            Caption = 'Voucher Code';
            DataClassification = ToBeClassified;
        }
        field(4; "gift_option"; Code[10])
        {
            Caption = 'Gift option';
            DataClassification = ToBeClassified;
        }
        field(5; "shipping_fee_discount_platform"; Decimal)
        {
            Caption = 'Shipping fee discount platform';
            DataClassification = ToBeClassified;
        }
        field(6; "customer_last_name"; text[100])
        {
            Caption = 'Customer last name';
            DataClassification = ToBeClassified;
        }
        field(7; "price"; Decimal)
        {
            Caption = 'Price';
            DataClassification = ToBeClassified;
        }
        field(8; "national_registration_number"; Code[50])
        {
            Caption = 'National registration number';
            DataClassification = ToBeClassified;
        }
        field(9; "shipping_fee_original"; Decimal)
        {
            Caption = 'Shipping fee original';
            DataClassification = ToBeClassified;
        }
        field(10; "payment_method"; Code[20])
        {
            Caption = 'Payment method';
            DataClassification = ToBeClassified;
        }
        field(11; "customer_first_name"; text[100])
        {
            Caption = 'Customer first name';
            DataClassification = ToBeClassified;
        }
        field(12; "shipping_fee_discount_seller"; Decimal)
        {
            Caption = 'Shipping fee discount seller';
            DataClassification = ToBeClassified;
        }
        field(13; "shipping_fee"; Decimal)
        {
            Caption = 'Shipping fee';
            DataClassification = ToBeClassified;
        }
        field(14; "branch_number"; Code[20])
        {
            Caption = 'Branch number';
            DataClassification = ToBeClassified;
        }
        field(15; "tax_code"; Code[20])
        {
            Caption = 'Tax code';
            DataClassification = ToBeClassified;
        }
        field(16; "items_count"; Integer)
        {
            Caption = 'Items count';
            DataClassification = ToBeClassified;
        }
        field(17; "delivery_info"; Code[10])
        {
            Caption = 'Delivery info';
            DataClassification = ToBeClassified;
        }
        field(18; "statuses"; Code[50])
        {
            Caption = 'Statuses';
            DataClassification = ToBeClassified;
        }
        field(19; "gift_message"; Text[100])
        {
            Caption = 'Gift message';
            DataClassification = ToBeClassified;
        }
        field(20; "remarks"; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(21; "address_billing.country"; Text[50])
        {
            Caption = 'Country';
            DataClassification = ToBeClassified;
        }
        field(22; "address_billing.address1"; Text[100])
        {
            Caption = 'Address1';
            DataClassification = ToBeClassified;
        }
        field(23; "address_billing.address2"; Text[100])
        {
            Caption = 'Address2';
            DataClassification = ToBeClassified;
        }
        field(24; "address_billing.address3"; Text[100])
        {
            Caption = 'Address3';
            DataClassification = ToBeClassified;
        }
        field(25; "address_billing.city"; Text[100])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
        }
        field(26; "address_billing.phone"; text[50])
        {
            Caption = 'Phone';
            DataClassification = ToBeClassified;
        }
        field(27; "address_billing.phone2"; Text[50])
        {
            Caption = 'Phone2';
            DataClassification = ToBeClassified;
        }
        field(28; "voucher_platform"; Decimal)
        {
            Caption = 'Voucher platform';
            DataClassification = ToBeClassified;
        }
        field(29; "Created at"; Text[50])
        {
            Caption = 'Created at';
            DataClassification = ToBeClassified;
        }

        field(30; "Updated at"; Text[50])
        {
            Caption = 'Updated at';
            DataClassification = ToBeClassified;
        }
        field(31; "voucher"; Decimal)
        {
            Caption = 'Voucher';
            DataClassification = ToBeClassified;
        }
        field(32; "Created to Sales Order"; Boolean)
        {
            Caption = 'Created to Sales Order';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(33; "Created to Sales Order By"; Code[50])
        {
            Caption = 'Created to Sales Order By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Created to Sales DateTime"; DateTime)
        {
            Caption = 'Created to Sales Order DateTime';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Completely Cancel Order"; Boolean)
        {
            Caption = 'Completely Cancel Order';
            FieldClass = FlowField;
            CalcFormula = min("Lazada Order Transaction Line".Cancel where(order_id = field(order_id)));
            Editable = false;
        }
        field(36; "Ref. Sales Order No."; Code[30])
        {
            Caption = 'Ref. Sales Order No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }
    keys
    {
        key(PK; order_id)
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        ltLazadatransactionLine: Record "Lazada Order Transaction Line";
    begin
        ltLazadatransactionLine.reset();
        ltLazadatransactionLine.SetRange(order_id, rec.order_id);
        ltLazadatransactionLine.DeleteAll(true);
    end;

    procedure "Create to Sales Order"()
    var
        ltTransactionDetail: Record "Lazada Order Transaction Line";
        ltSalesHeader: Record "Sales Header";
        ltSalesLine: Record "Sales Line";
        ltSalesSetup: Record "Sales & Receivables Setup";
        ltSalesOrderCard: Page "Sales Order";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNoSeries: Code[20];
        ltLineNo: Integer;
        ConfirmOrderMsg: Label 'Do you want Create %1 to Sale Order ?', Locked = true;
        ConfirmOpenOrderMsg: Label 'Do you want open sales order %1 ?', Locked = true;
    begin
        ltSalesSetup.GET();
        ltSalesSetup.TestField("Order Nos.");
        NewNoSeries := '';
        ltLineNo := 0;
        Rec.CalcFields("Completely Cancel Order");
        if rec."Completely Cancel Order" then begin
            Message('Nothing to Create');
            exit;
        end;
        if not Confirm(StrSubstNo(ConfirmOrderMsg, order_id)) then
            exit;
        if NoSeriesMgt.SelectSeries(ltSalesSetup."Order Nos.", ltSalesSetup."Order Nos.", NewNoSeries) then begin
            ltTransactionDetail.Get(rec.order_id, 1);
            ltSalesHeader.init();
            ltSalesHeader."Document Type" := ltSalesHeader."Document Type"::Order;
            ltSalesHeader."No." := NoSeriesMgt.GetNextNo(NewNoSeries, WorkDate(), true);
            ltSalesHeader."Posting Date" := WorkDate();
            ltSalesHeader."Document Date" := WorkDate();
            ltSalesHeader.Validate("Sell-to Customer No.", ltTransactionDetail.buyer_id);
            ltSalesHeader."Lazada Order ID" := rec.order_id;
            ltSalesHeader."Lazada Status" := rec.statuses;
            IF ltSalesHeader.Insert(true) then begin
                ltTransactionDetail.reset();
                ltTransactionDetail.SetRange(order_id, rec.order_id);
                ltTransactionDetail.SetRange(Cancel, false);
                if ltTransactionDetail.FindSet() then begin
                    repeat
                        ltLineNo := ltLineNo + 10000;
                        ltSalesLine.init();
                        ltSalesLine."Document Type" := ltSalesHeader."Document Type";
                        ltSalesLine."Document No." := ltSalesHeader."No.";
                        ltSalesLine."Line No." := ltLineNo;
                        ltSalesLine.Type := ltSalesLine.Type::Item;
                        ltSalesLine.Validate("No.", ltTransactionDetail.product_id);
                        ltSalesLine.Insert(true);
                        ltSalesLine.Validate(Quantity, 1);
                        ltSalesLine.Validate("Unit Price", ltTransactionDetail.item_price);
                        ltSalesLine."Lazada Order ID" := rec.order_id;
                        ltSalesLine."Lazada Order Item Id" := ltTransactionDetail.order_item_id;
                        ltSalesLine."Lazada Purchase order id" := ltTransactionDetail.purchase_order_id;
                        ltSalesLine."Lazada Purchase order Number" := ltTransactionDetail.purchase_order_id;
                        ltSalesLine."Lazada Tracking number" := ltTransactionDetail.tracking_code;
                        ltSalesLine."Lazada Package id" := ltTransactionDetail.package_id;
                        ltSalesLine."Lazada Shipment provider" := ltTransactionDetail.shipment_provider;
                        ltSalesLine.Modify();
                    until ltTransactionDetail.Next() = 0;
                end else begin
                    Message('Nothing to Create');
                    Error('');
                end;
                rec."Ref. Sales Order No." := ltSalesHeader."No.";
                rec."Created to Sales Order By" := COPYSTR(UserId(), 1, 50);
                rec."Created to Sales DateTime" := CurrentDateTime();
                rec."Created to Sales Order" := true;
                rec.Modify();
                Commit();
                if NOT Confirm(StrSubstNo(ConfirmOpenOrderMsg, ltSalesHeader."No.")) then
                    exit;
                CLEAR(ltSalesOrderCard);
                ltSalesOrderCard.SetTableView(ltSalesHeader);
                ltSalesOrderCard.RunModal();
                CLEAR(ltSalesOrderCard);
            end;
        end;
    end;
}
