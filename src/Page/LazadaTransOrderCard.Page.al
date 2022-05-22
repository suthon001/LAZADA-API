/// <summary>
/// Page Lazada Trans. Order Card (ID 50105).
/// </summary>
page 50105 "Lazada Trans. Order Card"
{
    Caption = 'Lazada Trans. Order Card';
    PageType = List;
    SourceTable = "Lazada Order Trans. Header";
    SourceTableView = sorting(order_id) where("Created to Sales Order" = const(false));
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(order_id; rec.order_id)
                {
                    ToolTip = 'Specifies the value of the Order ID field.';
                    ApplicationArea = All;
                }
                field(order_number; rec.order_number)
                {
                    ToolTip = 'Specifies the value of the Order Number field.';
                    ApplicationArea = All;
                }
                field(customer_first_name; rec.customer_first_name)
                {
                    ToolTip = 'Specifies the value of the Customer first name field.';
                    ApplicationArea = All;
                }
                field(customer_last_name; rec.customer_last_name)
                {
                    ToolTip = 'Specifies the value of the Customer last name field.';
                    ApplicationArea = All;
                }
                field(Address1; Rec."address_billing.Address1")
                {
                    ToolTip = 'Specifies the value of the Address1 field.';
                    ApplicationArea = All;
                }
                field(Address2; Rec."address_billing.Address2")
                {
                    ToolTip = 'Specifies the value of the Address2 field.';
                    ApplicationArea = All;
                }
                field(Country; Rec."address_billing.Country")
                {
                    ToolTip = 'Specifies the value of the Country field.';
                    ApplicationArea = All;
                }
                field(City; Rec."address_billing.City")
                {
                    ToolTip = 'Specifies the value of the City field.';
                    ApplicationArea = All;
                }
                field(Phone; Rec."address_billing.Phone")
                {
                    ToolTip = 'Specifies the value of the Phone field.';
                    ApplicationArea = All;
                }
                field(branch_number; rec.branch_number)
                {
                    ToolTip = 'Specifies the value of the Branch number field.';
                    ApplicationArea = All;
                }
                field(payment_method; rec.payment_method)
                {
                    ToolTip = 'Specifies the value of the Payment method field.';
                    ApplicationArea = All;
                }
                field(tax_code; rec.tax_code)
                {
                    ToolTip = 'Specifies the value of the Tax code field.';
                    ApplicationArea = All;
                }
                field(voucher; rec.voucher)
                {
                    ToolTip = 'Specifies the value of the Voucher field.';
                    ApplicationArea = All;
                }
                field(voucher_code; rec.voucher_code)
                {
                    ToolTip = 'Specifies the value of the Voucher Code field.';
                    ApplicationArea = All;
                }
                field(voucher_platform; rec.voucher_platform)
                {
                    ToolTip = 'Specifies the value of the Voucher platform field.';
                    ApplicationArea = All;
                }
                field(shipping_fee_original; rec.shipping_fee_original)
                {
                    ToolTip = 'Specifies the value of the Shipping fee original field.';
                    ApplicationArea = All;
                }
                field(shipping_fee; rec.shipping_fee)
                {
                    ToolTip = 'Specifies the value of the Shipping fee field.';
                    ApplicationArea = All;
                }
                field(shipping_fee_discount_platform; rec.shipping_fee_discount_platform)
                {
                    ToolTip = 'Specifies the value of the Shipping fee discount platform field.';
                    ApplicationArea = All;
                }
                field(shipping_fee_discount_seller; rec.shipping_fee_discount_seller)
                {
                    ToolTip = 'Specifies the value of the Shipping fee discount seller field.';
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
                {
                    ToolTip = 'Specifies the value of the Price field.';
                    ApplicationArea = All;
                }

                field(delivery_info; rec.delivery_info)
                {
                    ToolTip = 'Specifies the value of the Delivery info field.';
                    ApplicationArea = All;
                }
            }
            part(Line; "Lazada Trans. Subfrom")
            {
                SubPageLink = order_id = field(order_id);
                SubPageView = sorting(order_id, "Entry No.");
                Editable = false;
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create to Sales Order")
            {
                ApplicationArea = all;
                ToolTip = 'Create Sales Order';
                Image = CreateForm;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Caption = 'Create Sales Order';
                trigger OnAction()
                begin
                    rec."Create to Sales Order"();
                end;
            }
            action(CancelProductALLLine)
            {
                Caption = 'Lazada Cancel ALL Line';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = all;
                ToolTip = 'Cancel Item';
                trigger OnAction()
                var
                    ltTransactionDetail: Record "Lazada Order Transaction Line";
                    ApiFunc: Codeunit "API Func";
                    lttimestamp: BigInteger;
                    CancelTxt: Label 'Do you want to cancel ALL Line', Locked = true;
                begin
                    if not Confirm(StrSubstNo(CancelTxt, '')) then
                        exit;
                    ltTransactionDetail.reset();
                    ltTransactionDetail.SetRange(order_id, rec.order_id);
                    ltTransactionDetail.SetRange(Cancel, false);
                    if ltTransactionDetail.FindSet() then begin
                        repeat
                            lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
                            APIFunc.SetTimeStamp(lttimestamp);
                            APIFunc."Set Status Cancel"(ltTransactionDetail.order_item_id, 'Cancel Order');
                            ltTransactionDetail."Cancel" := true;
                            ltTransactionDetail.status := 'Cancel';
                            ltTransactionDetail.Modify();
                        until ltTransactionDetail.Next() = 0;
                        rec."Created to Sales Order By" := COPYSTR(UserId(), 1, 50);
                        rec."Created to Sales DateTime" := CurrentDateTime();
                        rec."Created to Sales Order" := true;
                        rec.statuses := 'Cancel';
                        rec.Modify();
                        Commit();
                    end;
                end;
            }
        }

    }
}

