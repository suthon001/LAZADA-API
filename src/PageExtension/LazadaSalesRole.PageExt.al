/// <summary>
/// PageExtension Lazada Sales Role (ID 50107) extends Record Order Processor Role Center.
/// </summary>
pageextension 50107 "Lazada Sales Role" extends "Order Processor Role Center"
{
    actions
    {
        addfirst(sections)
        {
            group(Lazada)
            {
                Caption = 'Lazada';
                action(LazadaSetup)
                {
                    Caption = 'Lazada Setup';
                    ApplicationArea = all;
                    RunObject = page "Lazada Setup Card";
                }
                action(LazadaProduct)
                {
                    Caption = 'Lazada Product';
                    ApplicationArea = all;
                    RunObject = page "Lazada Create & Update Product";
                }
                action(LazadaOrderTransaction)
                {
                    Caption = 'Lazada Order Transaction';
                    ApplicationArea = all;
                    RunObject = page "Lazada Trans. Order Lists";
                }
                action(LazadaFinanceTransaction)
                {
                    Caption = 'Lazada Finance Transaction';
                    ApplicationArea = all;
                    RunObject = page "Lazada Finance Transaction";
                }
                action(LazadaShipmentProvides)
                {
                    Caption = 'Lazada Shipment Providers';
                    ApplicationArea = all;
                    RunObject = page "Lazada Shipment Providers";
                }
            }
        }
    }
}
