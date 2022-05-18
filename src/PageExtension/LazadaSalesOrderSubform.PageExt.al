/// <summary>
/// PageExtension Lazada Sales Order Subform (ID 50102) extends Record Sales Order Subform.
/// </summary>
pageextension 50102 "Lazada Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Lazada Order ID"; rec."Lazada Order ID")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Lazada Order ID field.';
            }
            field("Lazada Order Item Id"; rec."Lazada Order Item Id")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Lazada Order Item Id field.';
            }
            field("Lazada Purchase order id"; rec."Lazada Purchase order id")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Lazada Purchase order id field.';
            }
            field("Lazada Purchase order Number"; rec."Lazada Purchase order Number")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Lazada Purchase order Number field.';
            }
            field("Lazada Package id"; rec."Lazada Package id")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Lazada Package id field.';
            }
            field("Lazada Shipment provider"; rec."Lazada Shipment provider")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Lazada Shipment provider field.';
            }
            field("Lazada Tracking number"; rec."Lazada Tracking number")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Lazada Tracking number field.';
            }
            field("Lazada Cancel"; rec."Lazada Cancel")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Lazada Cancel field.';
            }
            field("Lazada Remark"; rec."Lazada Remark")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Lazada Remark field.';
            }
        }
    }
    actions
    {
        addfirst("F&unctions")
        {
            action(CancelProduct)
            {
                Caption = 'Lazada Cancel';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = all;
                ToolTip = 'Cancel Item';
                trigger OnAction()
                var
                    ApiFunc: Codeunit "API Func";
                    lttimestamp: BigInteger;
                    CancelTxt: Label 'Do you want to cancel Product No. %1 on lazada', Locked = true;
                begin
                    rec.TestField("Lazada Remark");
                    if not Confirm(StrSubstNo(CancelTxt, rec."No.")) then
                        exit;

                    lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
                    APIFunc.SetTimeStamp(lttimestamp);
                    APIFunc."Set Status Cancel"(rec."Lazada Order Item Id", rec."Lazada Remark");
                    rec."Lazada Cancel" := true;
                    rec."Outstanding Quantity" := 0;
                    Rec."Outstanding Qty. (Base)" := 0;
                    Rec."Outstanding Amount" := 0;
                    Rec."Outstanding Amount (LCY)" := 0;
                    rec."Qty. to Ship" := 0;
                    rec."Qty. to Ship (Base)" := 0;
                    rec.Modify();
                end;
            }

        }
    }
}
