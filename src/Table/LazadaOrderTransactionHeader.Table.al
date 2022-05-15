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
        field(21; "country"; Text[50])
        {
            Caption = 'Country';
            DataClassification = ToBeClassified;
        }
        field(22; "address1"; Text[100])
        {
            Caption = 'Address1';
            DataClassification = ToBeClassified;
        }
        field(23; "address2"; Text[100])
        {
            Caption = 'Address2';
            DataClassification = ToBeClassified;
        }
        field(24; "address3"; Text[100])
        {
            Caption = 'Address3';
            DataClassification = ToBeClassified;
        }
        field(25; "city"; Text[100])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
        }
        field(26; "phone"; text[50])
        {
            Caption = 'Phone';
            DataClassification = ToBeClassified;
        }
        field(27; "phone2"; Text[50])
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
}
