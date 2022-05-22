table 50106 "Lazada Get Brand & Attributes"
{
    Caption = 'Lazada Get Brand & Attributes';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Type"; Option)
        {
            OptionMembers = BRAND,ATTRIBUTES;
            OptionCaption = 'BRAND, ATTRIBUTES';
            Caption = 'Type';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "name"; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(4; "global_identifier"; Text[100])
        {
            Caption = 'Global identifier';
            DataClassification = ToBeClassified;
        }
        field(5; "name_en"; Text[100])
        {
            Caption = 'Name En';
            DataClassification = ToBeClassified;
        }
        field(6; "brand_id"; Code[50])
        {
            Caption = 'Brand id';
            DataClassification = ToBeClassified;
        }
        field(7; "input_type"; Text[50])
        {
            Caption = 'Input type';
            DataClassification = ToBeClassified;
        }
        field(8; "Attr_id"; code[50])
        {
            Caption = 'attributes id';
            DataClassification = ToBeClassified;
        }
        field(9; "Option Name"; Text[100])
        {
            Caption = 'Option Name';
            DataClassification = ToBeClassified;
        }
        field(10; attribute_type; Text[50])
        {
            Caption = 'Attribute type';
            DataClassification = ToBeClassified;
        }
        field(11; "Attr label"; Text[50])
        {
            Caption = 'label';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Type, "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Entry No." := "Get LastEntry";
    end;

    procedure "Get LastEntry"(): Integer
    var
        ltLazadaGetBrandAttributes: Record "Lazada Get Brand & Attributes";
    begin
        ltLazadaGetBrandAttributes.reset();
        ltLazadaGetBrandAttributes.SetCurrentKey(Type, "Entry No.");
        ltLazadaGetBrandAttributes.SetRange(Type, Rec.Type);
        if ltLazadaGetBrandAttributes.FindLast() then
            exit(ltLazadaGetBrandAttributes."Entry No." + 1);
        exit(1);
    end;
}
