table 50104 "Lazada Shipment Providers"
{
    Caption = 'Lazada Shipment Providers';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "tracking_code_example"; Code[50])
        {
            Caption = 'Tracking code example';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "enabled_delivery_options"; Text[100])
        {
            Caption = 'Enabled elivery options';
            DataClassification = ToBeClassified;
        }
        field(4; "name"; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(5; "cod"; Text[100])
        {
            Caption = 'Cod';
            DataClassification = ToBeClassified;
        }
        field(6; "tracking_code_validation_regex"; Text[100])
        {
            Caption = 'Tracking code validation regex';
            DataClassification = ToBeClassified;
        }
        field(7; "is_default"; Code[10])
        {
            Caption = 'Is default';
            DataClassification = ToBeClassified;
        }
        field(8; "tracking_url"; Text[250])
        {
            Caption = 'Tracking url';
            DataClassification = ToBeClassified;
        }
        field(9; "api_integration"; Code[10])
        {
            Caption = 'Api integration';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; tracking_code_example, "Line no.")
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
        ltLazadaShipmentProvideres: Record "Lazada Shipment Providers";
    begin
        ltLazadaShipmentProvideres.reset();
        ltLazadaShipmentProvideres.SetCurrentKey(tracking_code_example, "Line No.");
        ltLazadaShipmentProvideres.SetRange(tracking_code_example, Rec.tracking_code_example);
        if ltLazadaShipmentProvideres.FindLast() then
            exit(ltLazadaShipmentProvideres."Line No." + 1);
        exit(1);
    end;
}
