page 50113 "Lazada Brand"
{
    Caption = 'Lazada Brand';
    PageType = List;
    SourceTable = "Lazada Get Brand & Attributes";
    SourceTableView = sorting(Type, "Entry No.") where(Type = const(BRAND));
    ModifyAllowed = false;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(name; Rec.name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                }
                field(global_identifier; Rec.global_identifier)
                {
                    ToolTip = 'Specifies the value of the Global identifier field.';
                    ApplicationArea = All;
                }
                field(name_en; Rec.name_en)
                {
                    ToolTip = 'Specifies the value of the Name En field.';
                    ApplicationArea = All;
                }
                field(brand_id; Rec.brand_id)
                {
                    ToolTip = 'Specifies the value of the Brand id field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Brand")
            {
                Caption = 'Get Brand';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = UserInterface;
                trigger OnAction()
                var
                    APIFunc: Codeunit "API Func";
                begin
                    APIFunc."Get Brand"();
                end;
            }
        }
    }
}
