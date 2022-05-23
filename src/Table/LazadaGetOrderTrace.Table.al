table 50107 "Lazada Get Order Trace"
{
    Caption = 'Get Order Trace';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "ofc_order_id"; text[100])
        {
            Caption = 'Ofc order id';
            DataClassification = ToBeClassified;
        }
        field(3; "order_line_info_list"; text[100])
        {
            Caption = 'Order line info list';
            DataClassification = ToBeClassified;
        }
        field(4; "ofc_package_id"; text[100])
        {
            Caption = 'Ofc package id';
            DataClassification = ToBeClassified;
        }
        field(5; "tracking_number"; text[100])
        {
            Caption = 'Tracking number';
            DataClassification = ToBeClassified;
        }
        field(6; "package_location_name"; text[250])
        {
            Caption = 'Package location name';
            DataClassification = ToBeClassified;
        }
        field(7; "status_code"; text[100])
        {
            Caption = 'Status code';
            DataClassification = ToBeClassified;
        }
        field(8; "detail_type"; text[100])
        {
            Caption = 'Detail_type';
            DataClassification = ToBeClassified;
        }
        field(9; "event_date"; text[100])
        {
            Caption = 'Event_date';
            DataClassification = ToBeClassified;
        }
        field(10; "description"; text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(11; "title"; text[100])
        {
            Caption = 'Title';
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
        ltLazadaOrderTrace: Record "Lazada Get Order Trace";
    begin
        ltLazadaOrderTrace.reset();
        ltLazadaOrderTrace.SetCurrentKey("Entry No.");
        if ltLazadaOrderTrace.FindLast() then
            exit(ltLazadaOrderTrace."Entry No." + 1);
        exit(1);
    end;
}
