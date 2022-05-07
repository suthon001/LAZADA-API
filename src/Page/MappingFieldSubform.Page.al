/// <summary>
/// Page Mapping Field Subform (ID 50103).
/// </summary>
page 50103 "Mapping Field Subform"
{
    Caption = 'Mapping Field Subform';
    PageType = ListPart;
    SourceTable = "Mapping Field Line";
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Field ID"; Rec."Field ID")
                {
                    ToolTip = 'Specifies the value of the Field ID field.';
                    ApplicationArea = All;
                }
                field("Field Name"; Rec."Field Name")
                {
                    ToolTip = 'Specifies the value of the Field Name field.';
                    ApplicationArea = All;
                }
                field("Field Type"; Rec."Field Type")
                {
                    ToolTip = 'Specifies the value of the Field Type field.';
                    ApplicationArea = All;
                }
                field("Mapping Field Name"; Rec."Mapping Field Name")
                {
                    ToolTip = 'Specifies the value of the Mapping Field Name field.';
                    ApplicationArea = All;
                }
                field(Remark; Rec.Remark)
                {
                    ToolTip = 'Specifies the value of the Remark field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
