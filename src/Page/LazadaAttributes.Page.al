page 50114 "Lazada Attributes"
{
    Caption = 'Lazada Attributes';
    PageType = List;
    SourceTable = "Lazada Get Brand & Attributes";
    SourceTableView = sorting(Type, "Entry No.") where(Type = const(ATTRIBUTES));
    ModifyAllowed = false;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group("Filter")
            {

                ShowCaption = false;
                field(gvPrimaryCategoryid; gvPrimaryCategoryid)
                {
                    Caption = 'Category ID';
                    ToolTip = 'Specifies the value of the Category ID field.';
                    ApplicationArea = all;
                }
                repeater(General)
                {
                    Editable = false;
                    field(name; Rec.name)
                    {
                        ToolTip = 'Specifies the value of the Name field.';
                        ApplicationArea = All;
                    }
                    field(input_type; Rec.input_type)
                    {
                        ToolTip = 'Specifies the value of the Input type field.';
                        ApplicationArea = All;
                    }
                    field("Option Name"; Rec."Option Name")
                    {
                        ToolTip = 'Specifies the value of the Option Name field.';
                        ApplicationArea = All;
                    }
                    field(name_en; Rec.name_en)
                    {
                        ToolTip = 'Specifies the value of the Name En field.';
                        ApplicationArea = All;
                    }
                    field(Attr_id; Rec.Attr_id)
                    {
                        ToolTip = 'Specifies the value of the attributes id field.';
                        ApplicationArea = All;
                    }
                    field(attribute_type; Rec.attribute_type)
                    {
                        ToolTip = 'Specifies the value of the Attribute type field.';
                        ApplicationArea = All;
                    }
                    field("Attr label"; Rec."Attr label")
                    {
                        ToolTip = 'Specifies the value of the label field.';
                        ApplicationArea = All;
                    }
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Get Attributes")
            {
                Caption = 'Get Attributes';
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
                    if gvPrimaryCategoryid = '' then
                        error('Category id must have a value');
                    APIFunc."Get Attributes"(gvPrimaryCategoryid);
                    gvPrimaryCategoryid := '';
                end;
            }
        }
    }
    var
        gvPrimaryCategoryid: Code[30];
}

