/// <summary>
/// Table Mapping Field Header (ID 50102).
/// </summary>
table 50102 "Mapping Field Header"
{
    Caption = 'Mapping Field Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = ToBeClassified;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = filter('Table'));
            trigger OnValidate()
            var
                ltAllObjWithCaption: Record AllObjWithCaption;
                ltMappingFieldLine: Record "Mapping Field Line";
                ltRecordRef: RecordRef;
                ltFieldRef: FieldRef;
                ltLoopField: Integer;
            begin
                if xRec."Table ID" <> rec."Table ID" then begin
                    if xRec."Table ID" <> 0 then begin
                        ltMappingFieldLine.reset();
                        ltMappingFieldLine.SetRange("Table ID", xRec."Table ID");
                        ltMappingFieldLine.DeleteAll();
                        Commit();
                    end;
                    if not ltAllObjWithCaption.GET(ltAllObjWithCaption."Object Type"::Table, rec."Table ID") then
                        ltAllObjWithCaption.init();
                    rec."Table Name" := ltAllObjWithCaption."Object Caption";
                    ltRecordRef.Open(rec."Table ID");

                    //    if ltRecordRef.Find() then
                    FOR ltLoopField := 1 TO ltRecordRef.FieldCount do begin
                        if ltRecordRef.FieldExist(ltLoopField) then begin
                            ltFieldRef := ltRecordRef.Field(ltLoopField);
                            ltMappingFieldLine.Init();
                            ltMappingFieldLine."Table ID" := rec."Table ID";
                            ltMappingFieldLine."Field ID" := ltFieldRef.Number;
                            ltMappingFieldLine."Field Name" := ltFieldRef.Name;
                            ltMappingFieldLine."Field Type" := format(ltFieldRef.Type);
                            ltMappingFieldLine.Insert();
                        end;
                    END;

                end;

            end;
        }
        field(2; "Table Name"; Text[50])
        {
            Caption = 'Table Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Service Name"; Text[100])
        {
            Caption = 'Service Name';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Table ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        rec.TestField("Table ID");
    end;

    trigger OnDelete()
    var
        ltMappingFieldLine: Record "Mapping Field Line";
    begin
        ltMappingFieldLine.reset();
        ltMappingFieldLine.SetRange("Table ID", rec."Table ID");
        ltMappingFieldLine.DeleteAll();
    end;
}
