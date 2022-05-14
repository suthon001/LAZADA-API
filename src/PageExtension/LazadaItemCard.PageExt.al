pageextension 50100 "Lazada Item Card" extends "Item Card"
{
    layout
    {
        addafter(Item)
        {
            group("Lazada Information")
            {
                Caption = 'Lazada Information';
                field("Lazada Item Id"; rec."Lazada Item Id")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Lazada Item Id field.';
                }
                field("Lazada Price"; rec."Lazada Price")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Lazada Price field.';
                }
                field("Lazada Seller sku"; rec."Lazada Seller sku")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Lazada Seller sku field.';
                }
                field("Lazada Shop sku"; rec."Lazada Shop sku")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Lazada Shop sku field.';
                }
                field("Lazada Sku id"; rec."Lazada Sku id")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Lazada Sku id field.';
                }
                field("Lazada Url Image 1"; rec."Lazada Url Image 1")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Lazada Url Image 1 field.';
                }
                field("Lazada Url Image 2"; rec."Lazada Url Image 2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Lazada Url Image 2 field.';
                }
                field("Lazada Url Image 3"; rec."Lazada Url Image 3")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Lazada Url Image 3 field.';
                }
                field("Lazada Url Image 4"; rec."Lazada Url Image 4")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Lazada Url Image 4 field.';
                }
            }
        }
    }
}
