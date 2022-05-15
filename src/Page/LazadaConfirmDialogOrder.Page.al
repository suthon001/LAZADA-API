/// <summary>
/// Page Lazada Confirm Dialog (ID 50107).
/// </summary>
page 50107 "Lazada Confirm Dialog Order"
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
                group("Group Date")
                {
                    ShowCaption = false;
                    grid(FilterGrid)
                    {
                        group("Crate Befor Date")
                        {
                            ShowCaption = false;
                            field(gvcreatedbeforeDate; gvcreatedbeforeDate)
                            {
                                ApplicationArea = all;
                                ToolTip = 'Spacifies value of Create Befor Date Field.';
                                Caption = 'Create befor Date';
                            }
                            field(gvcreatedbeforeTime; gvcreatedbeforeTime)
                            {
                                ApplicationArea = all;
                                ToolTip = 'Spacifies value of Create Befor Time Field.';
                                Caption = 'Create befor Time';
                            }
                        }
                        group("Crate After Date")
                        {
                            ShowCaption = false;
                            field(gvcreatedafterDate; gvcreatedafterDate)
                            {
                                ApplicationArea = all;
                                ToolTip = 'Spacifies value of Create After Date Field.';
                                Caption = 'Create After Date';
                            }
                            field(gvcreatedafterTime; gvcreatedafterTime)
                            {
                                ApplicationArea = all;
                                ToolTip = 'Spacifies value of Create Befor Time Field.';
                                Caption = 'Create After Time';
                            }
                        }
                        group("Update befor Date")
                        {
                            ShowCaption = false;
                            field(gvupdatebeforDate; gvupdatebeforDate)
                            {
                                ApplicationArea = all;
                                ToolTip = 'Spacifies value of Update Befor Date Field.';
                                Caption = 'Update befor Date';
                            }
                            field(gvupdatebeforTIme; gvupdatebeforTIme)
                            {
                                ApplicationArea = all;
                                ToolTip = 'Spacifies value of Update Befor Time Field.';
                                Caption = 'Update befor Time';
                            }
                        }
                        group("Update After Date")
                        {
                            ShowCaption = false;
                            field(gvupdateafterDate; gvupdateafterDate)
                            {
                                ApplicationArea = all;
                                ToolTip = 'Spacifies value of Update after Date Field.';
                                Caption = 'Update after Date';
                            }
                            field(gvupdateafterTime; gvupdateafterTime)
                            {
                                ApplicationArea = all;
                                ToolTip = 'Spacifies value of Update after Time Field.';
                                Caption = 'Update after Time';
                            }
                        }

                    }
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
            lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
            APIFunc.SetTimeStamp(lttimestamp);
            ALLTextFilter := '';
            if gvOderID <> '' then begin
                ALLTextFilter := '&order_id=' + gvOderID + '&sign_methodsha256&timestamp=' + format(lttimestamp);
                SignPath := DelChr(ALLTextFilter, '=', '&=');
                APIFunc."Get Order"('order', ALLTextFilter, SignPath);
            end else begin
                if gvcreatedafterDate <> 0D then
                    ALLTextFilter := ALLTextFilter + '&created_after=' + format(gvcreatedafterDate, 0, '<Year4>-<Month,2>-<Day,2>');
                if gvcreatedafterTime <> 0T then
                    ALLTextFilter := ALLTextFilter + 'T' + format(gvcreatedafterTime, 0, '<Hours24>:<Minutes,2>:<Seconds,2>') + '+07:00'
                else
                    if gvcreatedafterDate <> 0D then
                        ALLTextFilter := ALLTextFilter + 'T00:00:00' + '+07:00';

                if gvcreatedbeforeDate <> 0D then
                    ALLTextFilter := ALLTextFilter + '&created_before=' + format(gvcreatedbeforeDate, 0, '<Year4>-<Month,2>-<Day,2>');
                if gvcreatedbeforeTime <> 0T then
                    ALLTextFilter := ALLTextFilter + 'T' + format(gvcreatedbeforeTime, 0, '<Hours24>:<Minutes,2>:<Seconds,2>') + '+07:00'
                else
                    if gvcreatedbeforeDate <> 0D then
                        ALLTextFilter := ALLTextFilter + 'T00:00:00' + '+07:00';

                ALLTextFilter := ALLTextFilter + '&limit=10&offset=0&sign_methodsha256&sort_by=updated_at&sort_direction=DESC&status=pending&timestamp=' + format(lttimestamp);




                if gvupdateafterDate <> 0D then
                    ALLTextFilter := ALLTextFilter + '&update_after=' + format(gvupdateafterDate, 0, '<Year4>-<Month,2>-<Day,2>');
                if gvupdateafterTime <> 0T then
                    ALLTextFilter := ALLTextFilter + 'T' + format(gvupdateafterTime, 0, '<Hours24>:<Minutes,2>:<Seconds,2>') + '+07:00'
                else
                    if gvupdateafterDate <> 0D then
                        ALLTextFilter := ALLTextFilter + 'T00:00:00' + '+07:00';

                if gvupdatebeforDate <> 0D then
                    ALLTextFilter := ALLTextFilter + '&update_before=' + format(gvupdatebeforDate, 0, '<Year4>-<Month,2>-<Day,2>');
                if gvupdatebeforTIme <> 0T then
                    ALLTextFilter := ALLTextFilter + 'T' + format(gvupdatebeforTIme, 0, '<Hours24>:<Minutes,2>:<Seconds,2>') + '+07:00'
                else
                    if gvupdatebeforDate <> 0D then
                        ALLTextFilter := ALLTextFilter + 'T00:00:00+07:00';

                SignPath := DelChr(ALLTextFilter, '=', '&=');
                APIFunc."Get Order"('orders', ALLTextFilter, SignPath);
            end;
        end;
    end;

    var
        gvOderID: Code[250];
        gvupdateafterDate: Date;
        gvupdateafterTime: Time;
        gvupdatebeforDate: Date;

        gvupdatebeforTIme: Time;
        gvcreatedbeforeDate: Date;
        gvcreatedbeforeTime: Time;
        gvcreatedafterDate: Date;
        gvcreatedafterTime: Time;
        ALLTextFilter, SignPath : Text[1024];
    //gvstatus: Option " ",unpaid,pending,shipped;
}
