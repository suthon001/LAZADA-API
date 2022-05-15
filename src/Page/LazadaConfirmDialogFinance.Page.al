
/// <summary>
/// Page Lazada Confirm Dialog Finance (ID 50109).
/// </summary>
page 50109 "Lazada Confirm Dialog Finance"
{
    Caption = 'Lazada Confirm Dialog';
    PageType = ConfirmationDialog;
    UsageCategory = None;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Filter';
                field(gvOderID; gvOderID)
                {
                    Caption = 'Order ID';
                    ApplicationArea = all;
                    ToolTip = 'Spacifies value of Order id field.';
                }
                field(OrderITemID; OrderITemID)
                {
                    Caption = 'Oder Item ID';
                    ApplicationArea = all;
                    ToolTip = 'Spacifies value of Order Item ID field.';
                }
                field(gvStartDate; gvStartDate)
                {
                    Caption = 'Start Date';
                    ApplicationArea = all;
                    ToolTip = 'Spacifies value of Start Date field.';
                }
                field(gvEndDate; gvEndDate)
                {
                    Caption = 'End Date';
                    ApplicationArea = all;
                    ToolTip = 'Spacifies value of End Date field.';
                }


            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        APIFunc: Codeunit "API Func";
        lttimestamp: BigInteger;
    begin
        if CloseAction = Action::Yes then begin
            if (gvStartDate = 0D) OR (gvEndDate = 0D) then
                ERROR('Start Date and End Date must have a value');
            lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
            APIFunc.SetTimeStamp(lttimestamp);
            ALLTextFilter := '';
            ALLTextFilter := '&end_time=' + format(gvEndDate, 0, '<Year4>-<Month,2>-<Day,2>') + '&limit=10&offset=0&sign_methodsha256&start_time=' + format(gvStartDate, 0, '<Year4>-<Month,2>-<Day,2>') + '&timestamp=' + format(lttimestamp);
            if gvOderID <> '' then
                ALLTextFilter := ALLTextFilter + '&trade_order_id=' + gvOderID;
            if OrderITemID <> '' then
                ALLTextFilter := ALLTextFilter + '&trade_order_line_id=' + OrderITemID;
            SignPath := DelChr(ALLTextFilter, '=', '&=');
            APIFunc."Get Finance"(ALLTextFilter, SignPath);
        end;
    end;

    var
        gvOderID, OrderITemID : Code[250];
        gvStartDate, gvEndDate : date;
        ALLTextFilter, SignPath : Text[1024];
}
