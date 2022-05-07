/// <summary>
/// Page Mapping Field Lists (ID 50101).
/// </summary>
page 50101 "Mapping Field Lists"
{
    ApplicationArea = All;
    Caption = 'Mapping Field Lists';
    PageType = List;
    SourceTable = "Mapping Field Header";
    UsageCategory = Administration;
    Editable = false;
    CardPageId = "Mapping FIeld Card";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the value of the Table ID field.';
                    ApplicationArea = All;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ToolTip = 'Specifies the value of the Table Name field.';
                    ApplicationArea = All;
                }
                field("Service Name"; rec."Service Name")
                {
                    ToolTip = 'Specifies the value of the Service Name field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
