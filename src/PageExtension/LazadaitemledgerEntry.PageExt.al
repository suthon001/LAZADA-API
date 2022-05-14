pageextension 50105 "Lazada item ledger Entry" extends "Item Ledger Entries"
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
        }
    }
}
