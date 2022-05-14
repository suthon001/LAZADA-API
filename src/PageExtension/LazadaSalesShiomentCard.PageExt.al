pageextension 50103 "Lazada Sales Shipment Card" extends "Posted Sales Shipment"
{
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
}
