/// <summary>
/// TableExtension Lazada Sales Shipment Header (ID 50103) extends Record Sales Shipment Header.
/// </summary>
tableextension 50103 "Lazada Sales Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
        field(50100; "Lazada Order ID"; Code[50])
        {
            Caption = 'Lazada Order ID';
            DataClassification = ToBeClassified;
        }
        field(50101; "Lazada Status"; Text[50])
        {
            Caption = 'Lazada Status';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}