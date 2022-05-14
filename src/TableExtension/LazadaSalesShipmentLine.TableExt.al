/// <summary>
/// TableExtension Lazada Sales Shipment Line (ID 50104) extends Record Sales Shipment Line.
/// </summary>
tableextension 50104 "Lazada Sales Shipment Line" extends "Sales Shipment Line"
{
    fields
    {
        field(50100; "Lazada Order Item Id"; Code[30])
        {
            Caption = 'Lazada Order Item Id';
            DataClassification = ToBeClassified;
        }
        field(50101; "Lazada Shipment provider"; Text[50])
        {
            Caption = 'Lazada Shipment provider';
            DataClassification = ToBeClassified;
        }
        field(50102; "Lazada Tracking number"; Text[50])
        {
            Caption = 'Lazada Tracking number';
            DataClassification = ToBeClassified;
        }
        field(50103; "Lazada Order ID"; code[50])
        {
            Caption = 'Lazada Order ID';
            DataClassification = ToBeClassified;
        }
    }
}
