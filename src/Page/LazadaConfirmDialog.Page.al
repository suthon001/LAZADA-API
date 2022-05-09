page 50107 "Lazada Confirm Dialog"
{
    Caption = 'Lazada Confirm Dialog';
    PageType = ConfirmationDialog;
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
                field(gvstatus; gvstatus)
                {
                    Caption = 'Status';
                    ApplicationArea = all;
                    ToolTip = 'Spacifies value of Status field.';
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
    begin
        if CloseAction = Action::Yes then begin
            if gvOderID <> '' then begin
                ALLTextFilter := gvOderID;
                APIFunc."Get Order"('order', ALLTextFilter);
            end else begin
                // APIFunc."Get Order"('orders', ALLTextFilter);
                //&update_before=2018-02-10T16%3A00%3A00%2B08%3A00&sort_direction=DESC&offset=0&limit=10&update_after=2017-02-10T09%3A00%3A00%2B08%3A00&sort_by=updated_at&created_before=2018-02-10T16%3A00%3A00%2B08%3A00&created_after=2017-02-10T09%3A00%3A00%2B08%3A00&status=shipped'
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
        ALLTextFilter: Text[1024];
        gvstatus: Option " ",unpaid,pending,shipped;
}
