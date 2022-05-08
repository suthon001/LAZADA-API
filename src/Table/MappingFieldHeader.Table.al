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
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = filter('Table'), "Object ID" = filter(50104));
            trigger OnValidate()
            var
                ltAllObjWithCaption: Record AllObjWithCaption;
                ltMappingFieldLine: Record "Mapping Field Line";
                ltRecordRef: RecordRef;
                ltFieldRef: FieldRef;
                ltLoopField: Integer;
                NewText: Text;
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
                    FOR ltLoopField := 1 TO ltRecordRef.FieldCount do
                        if ltRecordRef.FieldExist(ltLoopField) then begin
                            ltFieldRef := ltRecordRef.Field(ltLoopField);
                            ltMappingFieldLine.Init();
                            ltMappingFieldLine."Table ID" := rec."Table ID";
                            ltMappingFieldLine."Field ID" := ltFieldRef.Number;
                            ltMappingFieldLine."Field Name" := ltFieldRef.Name;
                            ltMappingFieldLine."Field Type" := format(ltFieldRef.Type);
                            ltMappingFieldLine."Table Subfrom" := 0;
                            NewText := LowerCase(ltFieldRef.Name);
                            ltMappingFieldLine."Mapping Field Name" := NewText.Replace(' ', '_');
                            ltMappingFieldLine.Square := 0;
                            ltMappingFieldLine.Remark := 'Order Header';
                            ltMappingFieldLine.Insert();
                        end;
                    ltRecordRef.Close();
                    Clear(ltLoopField);
                    ltRecordRef.Open(50101);
                    FOR ltLoopField := 1 TO ltRecordRef.FieldCount do
                        if ltRecordRef.FieldExist(ltLoopField) then begin
                            ltFieldRef := ltRecordRef.Field(ltLoopField);
                            ltMappingFieldLine.Init();
                            ltMappingFieldLine."Table ID" := rec."Table ID";
                            ltMappingFieldLine."Table Subfrom" := 50101;
                            ltMappingFieldLine."Field ID" := ltFieldRef.Number;
                            ltMappingFieldLine."Field Name" := ltFieldRef.Name;
                            ltMappingFieldLine."Field Type" := format(ltFieldRef.Type);
                            NewText := LowerCase(ltFieldRef.Name);
                            ltMappingFieldLine."Mapping Field Name" := NewText.Replace(' ', '_');
                            ltMappingFieldLine.Remark := 'Order Detail';
                            ltMappingFieldLine.Square := 1;
                            ltMappingFieldLine.Insert();
                        end;

                end;

            end;
        }
        field(2; "Table Name"; Text[50])
        {
            Caption = 'Table Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Service Name"; Enum "Lazada Service Type")
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
