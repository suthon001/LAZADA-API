/// <summary>
/// Page Lazada Trans. Subfrom (ID 50106).
/// </summary>
page 50106 "Lazada Trans. Subfrom"
{
    Caption = 'Lazada Trans. Subfrom';
    PageType = ListPart;
    SourceTable = "Lazada Order Transaction Line";
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Buyer ID"; Rec."Buyer ID")
                {
                    ToolTip = 'Specifies the value of the Buyer ID field.';
                    ApplicationArea = All;
                }
                field("Order Item ID"; Rec."Order Item ID")
                {
                    ToolTip = 'Specifies the value of the Order Item ID field.';
                    ApplicationArea = All;
                }
                field("Product ID"; Rec."Product ID")
                {
                    ToolTip = 'Specifies the value of the Product ID field.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                }
                field(Sku; Rec.Sku)
                {
                    ToolTip = 'Specifies the value of the Sku field.';
                    ApplicationArea = All;
                }
                field("Sku ID"; Rec."Sku ID")
                {
                    ToolTip = 'Specifies the value of the Sku ID field.';
                    ApplicationArea = All;
                }
                field("Shop ID"; Rec."Shop ID")
                {
                    ToolTip = 'Specifies the value of the Shop ID field.';
                    ApplicationArea = All;
                }
                field("Invoice Number"; Rec."Invoice Number")
                {
                    ToolTip = 'Specifies the value of the Invoice Number field.';
                    ApplicationArea = All;
                }

                field("Purchase Order ID"; Rec."Purchase Order ID")
                {
                    ToolTip = 'Specifies the value of the Purchase Order ID field.';
                    ApplicationArea = All;
                }
                field("Purchase Order Number"; Rec."Purchase Order Number")
                {
                    ToolTip = 'Specifies the value of the Purchase Order Number field.';
                    ApplicationArea = All;
                }
                field("Voucher Code"; Rec."Voucher Code")
                {
                    ToolTip = 'Specifies the value of the Voucher Code field.';
                    ApplicationArea = All;
                }
                field("Voucher Code Seller"; Rec."Voucher Code Seller")
                {
                    ToolTip = 'Specifies the value of the Voucher Code Seller field.';
                    ApplicationArea = All;
                }
                field("Voucher Amount"; Rec."Voucher Amount")
                {
                    ToolTip = 'Specifies the value of the Voucher Amoun field.';
                    ApplicationArea = All;
                }
                field("Voucher Platform"; Rec."Voucher Platform")
                {
                    ToolTip = 'Specifies the value of the Voucher Platform field.';
                    ApplicationArea = All;
                }
                field("Voucher Seller"; Rec."Voucher Seller")
                {
                    ToolTip = 'Specifies the value of the Voucher Seller field.';
                    ApplicationArea = All;
                }
                field("Voucher Seller lpi"; Rec."Voucher Seller lpi")
                {
                    ToolTip = 'Specifies the value of the Voucher Seller lpi field.';
                    ApplicationArea = All;
                }
                field("Voucher code Platform"; Rec."Voucher code Platform")
                {
                    ToolTip = 'Specifies the value of the Voucher code Platform field.';
                    ApplicationArea = All;
                }
                field("Voucher platform lpi"; Rec."Voucher platform lpi")
                {
                    ToolTip = 'Specifies the value of the Voucher platform lpi field.';
                    ApplicationArea = All;
                }
                field("Tracking code"; Rec."Tracking code")
                {
                    ToolTip = 'Specifies the value of the Tracking code field.';
                    ApplicationArea = All;
                }
                field("Item price"; Rec."Item price")
                {
                    ToolTip = 'Specifies the value of the Item price field.';
                    ApplicationArea = All;
                }
                field("Wallet credits"; Rec."Wallet credits")
                {
                    ToolTip = 'Specifies the value of the Wallet credits field.';
                    ApplicationArea = All;
                }
                field("Tax Amount"; Rec."Tax Amount")
                {
                    ToolTip = 'Specifies the value of the Tax Amount field.';
                    ApplicationArea = All;
                }
                field("Warehouse Code"; Rec."Warehouse Code")
                {
                    ToolTip = 'Specifies the value of the Warehouse Code field.';
                    ApplicationArea = All;
                }
                field("Shipping amount"; Rec."Shipping amount")
                {
                    ToolTip = 'Specifies the value of the Shipping amount field.';
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
                field("Shipping fee original"; Rec."Shipping fee original")
                {
                    ToolTip = 'Specifies the value of the Shipping fee original field.';
                    ApplicationArea = All;
                }
                field("Reason detail"; Rec."Reason detail")
                {
                    ToolTip = 'Specifies the value of the Reason detail field.';
                    ApplicationArea = All;
                }
                field("Return status"; Rec."Return status")
                {
                    ToolTip = 'Specifies the value of the Return status field.';
                    ApplicationArea = All;
                }

            }
        }
    }
}
