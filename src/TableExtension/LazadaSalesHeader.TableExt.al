/// <summary>
/// TableExtension Lazada Sales Header (ID 50102) extends Record Sales Header.
/// </summary>
tableextension 50102 "Lazada Sales Header" extends "Sales Header"
{
    fields
    {
        field(50100; "Lazada Order ID"; Code[50])
        {
            Caption = 'Lazada Order ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50101; "Lazada Status"; Text[50])
        {
            Caption = 'Lazada Status';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}
