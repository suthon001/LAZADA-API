table 50103 "Mapping Field Line"
{
    Caption = 'Mapping Field Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Field ID"; Integer)
        {
            Caption = 'Field ID';
            DataClassification = ToBeClassified;
            TableRelation = Field."No." where(TableNo = field("Table ID"), Enabled = filter(true));
            trigger OnValidate()
            var
                ltField: Record Field;
            begin
                if xRec."Field ID" <> Rec."Field ID" then begin
                    if not ltField.GET(rec."Table ID", rec."Field ID") then
                        ltField.Init();
                    "Field Name" := ltField.FieldName;
                    "Field Type" := format(ltField.Type);
                end;
            end;
        }
        field(3; "Field Name"; Text[50])
        {
            Caption = 'Field Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Field Type"; Code[30])
        {
            Caption = 'Field Type';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Mapping Field Name"; text[50])
        {
            Caption = 'Mapping Field Name';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                rec.TestField("Field ID");
            end;
        }
        field(6; Remark; Text[100])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
        field(7; "Table Subfrom"; Integer)
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
        field(8; "Square"; Integer)
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Table ID", "Table Subfrom", "Field ID")
        {
            Clustered = true;
        }
        key(FK; "Table ID", Square, "Field ID")
        {

        }
    }
}
