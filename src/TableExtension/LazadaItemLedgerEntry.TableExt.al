/// <summary>
/// TableExtension Lazada Item Ledger Entry (ID 50105) extends Record Item Ledger Entry.
/// </summary>
tableextension 50105 "Lazada Item Ledger Entry" extends "Item Ledger Entry"
{
    fields
    {
        field(50100; "Lazada Order Item Id"; Code[30])
        {
            Caption = 'Lazada Order Item Id';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50101; "Lazada Shipment provider"; Text[50])
        {
            Caption = 'Lazada Shipment provider';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50102; "Lazada Tracking number"; Text[50])
        {
            Caption = 'Lazada Tracking number';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50103; "Lazada Order ID"; code[50])
        {
            Caption = 'Lazada Order ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50104; "Lazada Package id"; Code[50])
        {
            Caption = 'Lazada Remark';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50105; "Lazada Purchase order id"; Code[50])
        {
            Caption = 'Lazada Purchase order id';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50106; "Lazada Purchase order Number"; Code[50])
        {
            Caption = 'Lazada Purchase order Number';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}
