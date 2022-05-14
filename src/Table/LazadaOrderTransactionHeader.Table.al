/// <summary>
/// Table Lazada Order Trans. Header (ID 50104).
/// </summary>
table 50104 "Lazada Order Trans. Header"
{
    Caption = 'LazadaOrder Transaction Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Order ID"; Code[50])
        {
            Caption = 'Order ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Order Number"; Code[50])
        {
            Caption = 'Order Number';
            DataClassification = ToBeClassified;
        }
        field(3; "Voucher Code"; Code[50])
        {
            Caption = 'Voucher Code';
            DataClassification = ToBeClassified;
        }
        field(4; "Gift option"; Code[10])
        {
            Caption = 'Gift option';
            DataClassification = ToBeClassified;
        }
        field(5; "Shipping fee discount platform"; Decimal)
        {
            Caption = 'Shipping fee discount platform';
            DataClassification = ToBeClassified;
        }
        field(6; "Customer last name"; text[100])
        {
            Caption = 'Customer last name';
            DataClassification = ToBeClassified;
        }
        field(7; "Price"; Decimal)
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
        field(8; "National registration number"; Code[50])
        {
            Caption = 'National registration number';
            DataClassification = ToBeClassified;
        }
        field(9; "Shipping fee original"; Decimal)
        {
            Caption = 'Shipping fee original';
            DataClassification = ToBeClassified;
        }
        field(10; "Payment method"; Code[20])
        {
            Caption = 'Payment method';
            DataClassification = ToBeClassified;
        }
        field(11; "Customer first name"; text[100])
        {
            Caption = 'Customer first name';
            DataClassification = ToBeClassified;
        }
        field(12; "Shipping fee discount seller"; Decimal)
        {
            Caption = 'Shipping fee discount seller';
            DataClassification = ToBeClassified;
        }
        field(13; "Shipping fee"; Decimal)
        {
            Caption = 'Shipping fee';
            DataClassification = ToBeClassified;
        }
        field(14; "Branch number"; Code[20])
        {
            Caption = 'Branch number';
            DataClassification = ToBeClassified;
        }
        field(15; "Tax code"; Code[20])
        {
            Caption = 'Tax code';
            DataClassification = ToBeClassified;
        }
        field(16; "Items count"; Integer)
        {
            Caption = 'Items count';
            DataClassification = ToBeClassified;
        }
        field(17; "Delivery info"; Code[10])
        {
            Caption = 'Delivery info';
            DataClassification = ToBeClassified;
        }
        field(18; "Statuses"; Code[50])
        {
            Caption = 'Statuses';
            DataClassification = ToBeClassified;
        }
        field(19; "Gift message"; Text[100])
        {
            Caption = 'Gift message';
            DataClassification = ToBeClassified;
        }
        field(20; "Remarks"; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(21; "Country"; Text[50])
        {
            Caption = 'Country';
            DataClassification = ToBeClassified;
        }
        field(22; "Address1"; Text[100])
        {
            Caption = 'Address1';
            DataClassification = ToBeClassified;
        }
        field(23; "Address2"; Text[100])
        {
            Caption = 'Address2';
            DataClassification = ToBeClassified;
        }
        field(24; "Address3"; Text[100])
        {
            Caption = 'Address3';
            DataClassification = ToBeClassified;
        }
        field(25; "City"; Text[100])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
        }
        field(26; "Phone"; text[50])
        {
            Caption = 'Phone';
            DataClassification = ToBeClassified;
        }
        field(27; "Phone2"; Text[50])
        {
            Caption = 'Phone2';
            DataClassification = ToBeClassified;
        }
        field(28; "Voucher platform"; Decimal)
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

    }
    keys
    {
        key(PK; "Order ID")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        ltLazadatransactionLine: Record "Lazada Order Transaction Line";
    begin
        ltLazadatransactionLine.reset();
        ltLazadatransactionLine.SetRange("Order ID", rec."Order ID");
        ltLazadatransactionLine.DeleteAll(true);
    end;
}
