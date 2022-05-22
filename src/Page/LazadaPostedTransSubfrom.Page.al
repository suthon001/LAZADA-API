
page 50112 "Lazada Posted Trans. Subfrom"
{
    Caption = 'Lazada Posted Trans. Subfrom';
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
                field(buyer_id; rec.buyer_id)
                {
                    ToolTip = 'Specifies the value of the Buyer ID field.';
                    ApplicationArea = All;
                }
                field(order_item_id; rec.order_item_id)
                {
                    ToolTip = 'Specifies the value of the Order Item ID field.';
                    ApplicationArea = All;
                }
                field(product_id; rec.product_id)
                {
                    ToolTip = 'Specifies the value of the Product ID field.';
                    ApplicationArea = All;
                }
                field(name; rec.name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                }
                field(sku; rec.sku)
                {
                    ToolTip = 'Specifies the value of the Sku field.';
                    ApplicationArea = All;
                }
                field(sku_id; rec.sku_id)
                {
                    ToolTip = 'Specifies the value of the Sku ID field.';
                    ApplicationArea = All;
                }
                field(shop_id; rec.shop_id)
                {
                    ToolTip = 'Specifies the value of the Shop ID field.';
                    ApplicationArea = All;
                }
                field(invoice_number; rec.invoice_number)
                {
                    ToolTip = 'Specifies the value of the Invoice Number field.';
                    ApplicationArea = All;
                }

                field(purchase_order_id; rec.purchase_order_id)
                {
                    ToolTip = 'Specifies the value of the Purchase Order ID field.';
                    ApplicationArea = All;
                }
                field(purchase_order_number; rec.purchase_order_number)
                {
                    ToolTip = 'Specifies the value of the Purchase Order Number field.';
                    ApplicationArea = All;
                }
                field(status; rec.status)
                {
                    ToolTip = 'Specifies the value of the status field.';
                    ApplicationArea = All;
                }
                field(voucher_code; rec.voucher_code)
                {
                    ToolTip = 'Specifies the value of the Voucher Code field.';
                    ApplicationArea = All;
                }
                field(voucher_code_seller; rec.voucher_code_seller)
                {
                    ToolTip = 'Specifies the value of the Voucher Code Seller field.';
                    ApplicationArea = All;
                }
                field(voucher_seller; rec.voucher_seller)
                {
                    ToolTip = 'Specifies the value of the Voucher Seller field.';
                    ApplicationArea = All;
                }
                field(voucher_seller_lpi; rec.voucher_seller_lpi)
                {
                    ToolTip = 'Specifies the value of the Voucher Seller lpi field.';
                    ApplicationArea = All;
                }
                field(voucher_amount; rec.voucher_amount)
                {
                    ToolTip = 'Specifies the value of the Voucher Amoun field.';
                    ApplicationArea = All;
                }
                field(voucher_platform; rec.voucher_platform)
                {
                    ToolTip = 'Specifies the value of the Voucher Platform field.';
                    ApplicationArea = All;
                }

                field(voucher_code_platform; rec.voucher_code_platform)
                {
                    ToolTip = 'Specifies the value of the Voucher code Platform field.';
                    ApplicationArea = All;
                }
                field(voucher_platform_lpi; rec.voucher_platform_lpi)
                {
                    ToolTip = 'Specifies the value of the Voucher platform lpi field.';
                    ApplicationArea = All;
                }
                field(tracking_code; rec.tracking_code)
                {
                    ToolTip = 'Specifies the value of the Tracking code field.';
                    ApplicationArea = All;
                }
                field(item_price; rec.item_price)
                {
                    ToolTip = 'Specifies the value of the Item price field.';
                    ApplicationArea = All;
                }
                field(wallet_credits; rec.wallet_credits)
                {
                    ToolTip = 'Specifies the value of the Wallet credits field.';
                    ApplicationArea = All;
                }
                field(tax_amount; rec.tax_amount)
                {
                    ToolTip = 'Specifies the value of the Tax Amount field.';
                    ApplicationArea = All;
                }
                field(warehouse_code; rec.warehouse_code)
                {
                    ToolTip = 'Specifies the value of the Warehouse Code field.';
                    ApplicationArea = All;
                }
                field(shipping_amount; rec.shipping_amount)
                {
                    ToolTip = 'Specifies the value of the Shipping amount field.';
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
                field(shipping_fee_original; rec.shipping_fee_original)
                {
                    ToolTip = 'Specifies the value of the Shipping fee original field.';
                    ApplicationArea = All;
                }
                field(reason; rec.reason)
                {
                    ToolTip = 'Specifies the value of the Reason detail field.';
                    ApplicationArea = All;
                }
                field(reason_detail; rec.reason_detail)
                {
                    ToolTip = 'Specifies the value of the Reason detail field.';
                    ApplicationArea = All;
                }
                field(return_status; rec.return_status)
                {
                    ToolTip = 'Specifies the value of the Return status field.';
                    ApplicationArea = All;
                }
                field(Cancel; rec.Cancel)
                {
                    ToolTip = 'Specifies the value of the Cancel field.';
                    ApplicationArea = All;
                }
                field(Remark; rec.Remark)
                {
                    ToolTip = 'Specifies the value of the Remark field.';
                    ApplicationArea = All;
                }

            }
        }
    }
}