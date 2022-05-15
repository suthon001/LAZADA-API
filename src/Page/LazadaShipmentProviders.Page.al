page 50102 "Lazada Shipment Providers"
{
    Caption = 'Lazada Shipment Providers';
    PageType = List;
    SourceTable = "Lazada Shipment Providers";
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(tracking_code_example; Rec.tracking_code_example)
                {
                    ToolTip = 'Specifies the value of the Tracking code example field.';
                    ApplicationArea = All;
                }
                field(tracking_code_validation_regex; Rec.tracking_code_validation_regex)
                {
                    ToolTip = 'Specifies the value of the Tracking code validation regex field.';
                    ApplicationArea = All;
                }
                field(name; Rec.name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                }
                field(tracking_url; Rec.tracking_url)
                {
                    ToolTip = 'Specifies the value of the Tracking url field.';
                    ApplicationArea = All;
                }
                field(cod; Rec.cod)
                {
                    ToolTip = 'Specifies the value of the Cod field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Shipment Providers")
            {
                ApplicationArea = all;
                ToolTip = 'Get Shipment Providers';
                Image = UserInterface;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Caption = 'Get Shipment Providers';
                trigger OnAction()
                var
                    APIFunc: Codeunit "API Func";
                    lttimestamp: BigInteger;
                begin
                    lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
                    APIFunc.SetTimeStamp(lttimestamp);
                    APIFunc."Get Shipment Providers"();
                end;
            }
        }
    }
}

