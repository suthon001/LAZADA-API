/// <summary>
/// PageExtension Lazada Sales Order Card (ID 50101) extends Record Sales Order.
/// </summary>
pageextension 50101 "Lazada Sales Order Card" extends "Sales Order"
{
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Order,Request Approval,History,Print/Send,Navigate,Lazada';
    layout
    {
        addlast(General)
        {
            field("Lazada Order ID"; rec."Lazada Order ID")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Lazada Order ID field.';
            }
            field("Lazada Status"; rec."Lazada Status")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Lazada Status field.';
            }
        }
    }
    actions
    {
        addfirst(processing)
        {
            group(Lazada)
            {
                Caption = 'Lazada';
                action("Lazada Package")
                {
                    Caption = 'Set Status to Package';
                    Image = PickLines;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category13;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Set Status Package to Lazada System';
                    trigger OnAction()
                    var
                        APIFunc: Codeunit "API Func";
                        lttimestamp: BigInteger;
                        PackageMsg: Label 'Nothing to Send';
                    begin
                        if rec."Lazada Order ID" = '' then begin
                            Message(PackageMsg);
                            exit;
                        end;
                        if not Confirm('Do you want set status to package ? ') then
                            exit;
                        lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
                        APIFunc.SetTimeStamp(lttimestamp);
                        APIFunc."Set Status Package"(rec."Lazada Order ID", rec."No.");
                    end;
                }
                action("Lazada Delivered")
                {
                    Caption = 'Set Status to Delivered';
                    Image = PickLines;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category13;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Set Status Delivered to Lazada System';
                    trigger OnAction()
                    var
                        APIFunc: Codeunit "API Func";
                        lttimestamp: BigInteger;
                        PackageMsg: Label 'Nothing to Send';
                    begin
                        if rec."Lazada Order ID" = '' then begin
                            Message(PackageMsg);
                            exit;
                        end;
                        if not Confirm('Do you want set status to Delivered ? ') then
                            exit;
                        lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
                        APIFunc.SetTimeStamp(lttimestamp);
                        APIFunc."Set Status Delivered"(rec."Lazada Order ID", rec."No.");
                    end;
                }
                action("Lazada Failed Delivered")
                {
                    Caption = 'Set Status to Failed Delivered';
                    Image = PickLines;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category13;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Set Status Failed Delivered to Lazada System';
                    trigger OnAction()
                    var
                        APIFunc: Codeunit "API Func";
                        lttimestamp: BigInteger;
                        PackageMsg: Label 'Nothing to Send';
                    begin
                        if rec."Lazada Order ID" = '' then begin
                            Message(PackageMsg);
                            exit;
                        end;
                        if not Confirm('Do you want set status to Failed Delivered ? ') then
                            exit;
                        lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
                        APIFunc.SetTimeStamp(lttimestamp);
                        APIFunc."Set Status FailedDelivered"(rec."Lazada Order ID", rec."No.");
                    end;
                }

            }
        }
    }
}
