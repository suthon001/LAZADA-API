page 50101 "Lazada Finance Transaction"
{
    Caption = 'Lazada Finance Transaction';
    PageType = List;
    SourceTable = "Lazada Finance Detail";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(order_no; Rec.order_no)
                {
                    ToolTip = 'Specifies the value of the Order No. field.';
                    ApplicationArea = All;
                }
                field(orderItem_no; Rec.orderItem_no)
                {
                    ToolTip = 'Specifies the value of the RrderItem no field.';
                    ApplicationArea = All;
                }

                field(VAT_in_amount; Rec.VAT_in_amount)
                {
                    ToolTip = 'Specifies the value of the VAT in Amount field.';
                    ApplicationArea = All;
                }
                field(WHT_amount; Rec.WHT_amount)
                {
                    ToolTip = 'Specifies the value of the WHT Amount field.';
                    ApplicationArea = All;
                }
                field(WHT_included_in_amount; Rec.WHT_included_in_amount)
                {
                    ToolTip = 'Specifies the value of the WHT included in amount field.';
                    ApplicationArea = All;
                }
                field(amount; Rec.amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = All;
                }
                field(comment; Rec.comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                    ApplicationArea = All;
                }
                field(details; Rec.details)
                {
                    ToolTip = 'Specifies the value of the Details field.';
                    ApplicationArea = All;
                }
                field(fee_name; Rec.fee_name)
                {
                    ToolTip = 'Specifies the value of the Fee Name field.';
                    ApplicationArea = All;
                }
                field(fee_type; Rec.fee_type)
                {
                    ToolTip = 'Specifies the value of the Fee Type field.';
                    ApplicationArea = All;
                }
                field(lazada_sku; Rec.lazada_sku)
                {
                    ToolTip = 'Specifies the value of the Lazada sku field.';
                    ApplicationArea = All;
                }
                field(orderItem_status; Rec.orderItem_status)
                {
                    ToolTip = 'Specifies the value of the OrderItem_status field.';
                    ApplicationArea = All;
                }
                field(paid_status; Rec.paid_status)
                {
                    ToolTip = 'Specifies the value of the Paid status field.';
                    ApplicationArea = All;
                }
                field(payment_ref_id; Rec.payment_ref_id)
                {
                    ToolTip = 'Specifies the value of the Payment Ref. id field.';
                    ApplicationArea = All;
                }
                field(reference; Rec.reference)
                {
                    ToolTip = 'Specifies the value of the Reference field.';
                    ApplicationArea = All;
                }
                field(seller_sku; Rec.seller_sku)
                {
                    ToolTip = 'Specifies the value of the Seller sku field.';
                    ApplicationArea = All;
                }
                field(shipment_type; Rec.shipment_type)
                {
                    ToolTip = 'Specifies the value of the Shipment type field.';
                    ApplicationArea = All;
                }
                field(shipping_provider; Rec.shipping_provider)
                {
                    ToolTip = 'Specifies the value of the Shipping provider field.';
                    ApplicationArea = All;
                }
                field(shipping_speed; Rec.shipping_speed)
                {
                    ToolTip = 'Specifies the value of the Shipping Speed field.';
                    ApplicationArea = All;
                }
                field(statement; Rec.statement)
                {
                    ToolTip = 'Specifies the value of the Sstatement field.';
                    ApplicationArea = All;
                }
                field(transaction_date; Rec.transaction_date)
                {
                    ToolTip = 'Specifies the value of the Transaction date field.';
                    ApplicationArea = All;
                }
                field(transaction_number; Rec.transaction_number)
                {
                    ToolTip = 'Specifies the value of the Transaction number field.';
                    ApplicationArea = All;
                }
                field(transaction_type; Rec.transaction_type)
                {
                    ToolTip = 'Specifies the value of the Transaction type field.';
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Lazada Entry")
            {
                ApplicationArea = all;
                ToolTip = 'Get Lazada Api';
                Image = UserInterface;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    APIFunc: Codeunit "API Func";
                begin
                    APIFunc.ConfirmBeforGetFinanceAPI();
                end;
            }
        }
    }
}
