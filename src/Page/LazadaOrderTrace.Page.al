page 50115 "Lazada Order Trace"
{
    Caption = 'Lazada Order Trace';
    PageType = Worksheet;
    SourceTable = "Lazada Get Order Trace";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group("Filter")
            {

                ShowCaption = false;
                field(gvOrderID; gvOrderID)
                {
                    Caption = 'Order ID';
                    ToolTip = 'Specifies the value of the Order ID field.';
                    ApplicationArea = all;
                }
            }
            repeater(General)
            {
                Editable = false;
                field(ofc_order_id; Rec.ofc_order_id)
                {
                    ToolTip = 'Specifies the value of the Ofc order id field.';
                    ApplicationArea = All;
                }
                field(ofc_package_id; Rec.ofc_package_id)
                {
                    ToolTip = 'Specifies the value of the Ofc package id field.';
                    ApplicationArea = All;
                }
                field(order_line_info_list; Rec.order_line_info_list)
                {
                    ToolTip = 'Specifies the value of the Order line info list field.';
                    ApplicationArea = All;
                }
                field(package_location_name; Rec.package_location_name)
                {
                    ToolTip = 'Specifies the value of the Package location name field.';
                    ApplicationArea = All;
                }
                field(detail_type; Rec.detail_type)
                {
                    ToolTip = 'Specifies the value of the Detail_type field.';
                    ApplicationArea = All;
                }
                field(status_code; Rec.status_code)
                {
                    ToolTip = 'Specifies the value of the Status code field.';
                    ApplicationArea = All;
                }
                field(event_date; Rec.event_date)
                {
                    ToolTip = 'Specifies the value of the Event_date field.';
                    ApplicationArea = All;
                }
                field(tracking_number; Rec.tracking_number)
                {
                    ToolTip = 'Specifies the value of the Tracking number field.';
                    ApplicationArea = All;
                }
                field(description; Rec.description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field(title; Rec.title)
                {
                    ToolTip = 'Specifies the value of the Title field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Order Trace")
            {
                Caption = 'Get Order Trace';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = UserInterface;
                trigger OnAction()
                var
                    APIFunc: Codeunit "API Func";
                    lttimestamp: BigInteger;
                begin
                    if gvOrderID = '' then
                        error('Orderid must have a value');
                    lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
                    APIFunc.SetTimeStamp(lttimestamp);
                    APIFunc."Get Order Trace"(gvOrderID);
                    gvOrderID := '';
                end;
            }
        }
    }
    var
        gvOrderID: Code[50];
}
