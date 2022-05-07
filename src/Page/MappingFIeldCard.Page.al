page 50102 "Mapping FIeld Card"
{
    Caption = 'Mapping FIeld Card';
    PageType = Card;
    SourceTable = "Mapping Field Header";

    layout
    {
        area(content)
        {
            group(General)
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
            }
            part(Lines; "Mapping Field Subform")
            {
                SubPageLink = "Table ID" = field("Table ID");
                SubPageView = sorting("Table ID", "Field ID");
                Caption = 'Linns';
                Enabled = rec."Table ID" <> 0;
            }
        }
    }
}
