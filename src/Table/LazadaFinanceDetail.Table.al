/// <summary>
/// Table Lazada Finance Detail (ID 50101).
/// </summary>
table 50101 "Lazada Finance Detail"
{
    Caption = 'Lazada Finance Detail';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "order_no"; code[50])
        {
            Caption = 'Order No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "transaction_date"; Text[20])
        {
            Caption = 'Transaction date';
            DataClassification = ToBeClassified;
        }
        field(4; "amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(5; "paid_status"; Text[50])
        {
            Caption = 'Paid status';
            DataClassification = ToBeClassified;
        }
        field(6; "shipping_provider"; Text[50])
        {
            Caption = 'Shipping provider';
            DataClassification = ToBeClassified;
        }
        field(7; "WHT_included_in_amount"; Text[50])
        {
            Caption = 'WHT included in amount';
            DataClassification = ToBeClassified;
        }
        field(8; "payment_ref_id"; Text[50])
        {
            Caption = 'Payment Ref. id';
            DataClassification = ToBeClassified;
        }
        field(9; "lazada_sku"; Text[50])
        {
            Caption = 'Lazada sku';
            DataClassification = ToBeClassified;
        }
        field(10; "fee_type"; Text[50])
        {
            Caption = 'Fee Type';
            DataClassification = ToBeClassified;
        }
        field(11; "transaction_type"; Text[50])
        {
            Caption = 'Transaction type';
            DataClassification = ToBeClassified;
        }
        field(12; "orderItem_no"; code[50])
        {
            Caption = 'RrderItem no';
            DataClassification = ToBeClassified;
        }
        field(13; "orderItem_status"; Text[50])
        {
            Caption = 'OrderItem_status';
            DataClassification = ToBeClassified;
        }
        field(14; "reference"; Text[50])
        {
            Caption = 'Reference';
            DataClassification = ToBeClassified;
        }
        field(26; "fee_name"; Text[50])
        {
            Caption = 'Fee Name';
            DataClassification = ToBeClassified;
        }
        field(16; "shipping_speed"; Text[50])
        {
            Caption = 'Shipping Speed';
            DataClassification = ToBeClassified;
        }
        field(17; "WHT_amount"; Decimal)
        {
            Caption = 'WHT Amount';
            DataClassification = ToBeClassified;
        }
        field(18; "transaction_number"; Text[50])
        {
            Caption = 'Transaction number';
            DataClassification = ToBeClassified;
        }
        field(19; "seller_sku"; Text[50])
        {
            Caption = 'Seller sku';
            DataClassification = ToBeClassified;
        }
        field(20; "statement"; Text[50])
        {
            Caption = 'Sstatement';
            DataClassification = ToBeClassified;
        }
        field(21; "details"; Text[100])
        {
            Caption = 'Details';
            DataClassification = ToBeClassified;
        }
        field(22; "comment"; Text[100])
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;
        }
        field(23; "VAT_in_amount"; Decimal)
        {
            Caption = 'VAT in Amount';
            DataClassification = ToBeClassified;
        }
        field(24; "shipment_type"; Text[50])
        {
            Caption = 'Shipment type';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; order_no, "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Line No." := "Get LastEntry";
    end;
    /// <summary>
    /// Get LastEntry.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure "Get LastEntry"(): Integer
    var
        ltLazadaFinanaceDetail: Record "Lazada Finance Detail";
    begin
        ltLazadaFinanaceDetail.reset();
        ltLazadaFinanaceDetail.SetCurrentKey(order_no, "Line No.");
        ltLazadaFinanaceDetail.SetRange(order_no, Rec.order_no);
        if ltLazadaFinanaceDetail.FindLast() then
            exit(ltLazadaFinanaceDetail."line No." + 1);
        exit(1);
    end;

}
