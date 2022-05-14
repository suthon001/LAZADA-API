/// <summary>
/// Page Lazada Trans. Order Lists (ID 50104).
/// </summary>
page 50104 "Lazada Trans. Order Lists"
{
    Caption = 'Lazada Trans. Order Lists';
    PageType = List;
    SourceTable = "Lazada Order Trans. Header";
    Editable = false;
    CardPageId = "Lazada Trans. Order Card";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Order ID"; Rec."Order ID")
                {
                    ToolTip = 'Specifies the value of the Order ID field.';
                    ApplicationArea = All;
                }
                field("Order Number"; Rec."Order Number")
                {
                    ToolTip = 'Specifies the value of the Order Number field.';
                    ApplicationArea = All;
                }

                field("Customer first name"; Rec."Customer first name")
                {
                    ToolTip = 'Specifies the value of the Customer first name field.';
                    ApplicationArea = All;
                }
                field("Customer last name"; Rec."Customer last name")
                {
                    ToolTip = 'Specifies the value of the Customer last name field.';
                    ApplicationArea = All;
                }
                field(Address1; Rec.Address1)
                {
                    ToolTip = 'Specifies the value of the Address1 field.';
                    ApplicationArea = All;
                }
                field(Address2; Rec.Address2)
                {
                    ToolTip = 'Specifies the value of the Address2 field.';
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ToolTip = 'Specifies the value of the Country field.';
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    ToolTip = 'Specifies the value of the Phone field.';
                    ApplicationArea = All;
                }
                field("Branch number"; Rec."Branch number")
                {
                    ToolTip = 'Specifies the value of the Branch number field.';
                    ApplicationArea = All;
                }
                field("Payment method"; Rec."Payment method")
                {
                    ToolTip = 'Specifies the value of the Payment method field.';
                    ApplicationArea = All;
                }
                field("Tax code"; Rec."Tax code")
                {
                    ToolTip = 'Specifies the value of the Tax code field.';
                    ApplicationArea = All;
                }
                field("Voucher Code"; Rec."Voucher Code")
                {
                    ToolTip = 'Specifies the value of the Voucher Code field.';
                    ApplicationArea = All;
                }
                field("Voucher platform"; Rec."Voucher platform")
                {
                    ToolTip = 'Specifies the value of the Voucher platform field.';
                    ApplicationArea = All;
                }
                field("Shipping fee original"; Rec."Shipping fee original")
                {
                    ToolTip = 'Specifies the value of the Shipping fee original field.';
                    ApplicationArea = All;
                }
                field("Shipping fee"; Rec."Shipping fee")
                {
                    ToolTip = 'Specifies the value of the Shipping fee field.';
                    ApplicationArea = All;
                }
                field("Shipping fee discount platform"; Rec."Shipping fee discount platform")
                {
                    ToolTip = 'Specifies the value of the Shipping fee discount platform field.';
                    ApplicationArea = All;
                }
                field("Shipping fee discount seller"; Rec."Shipping fee discount seller")
                {
                    ToolTip = 'Specifies the value of the Shipping fee discount seller field.';
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
                {
                    ToolTip = 'Specifies the value of the Price field.';
                    ApplicationArea = All;
                }

                field("Delivery info"; Rec."Delivery info")
                {
                    ToolTip = 'Specifies the value of the Delivery info field.';
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
                    APIFunc.ConfirmBeforGetAPI();
                end;
            }
        }
    }
}
