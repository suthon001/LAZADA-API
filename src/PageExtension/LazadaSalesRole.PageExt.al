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
                action(LazadaMappinFields)
                {
                    Caption = 'Lazada Mapping Field';
                    ApplicationArea = all;
                    RunObject = page "Mapping Field Lists";
                }
                action(LazadaProduct)
                {
                    Caption = 'Lazada Product';
                    ApplicationArea = all;
                    RunObject = page "Lazada Create & Update Product";
                }
                action(LazadaTransaction)
                {
                    Caption = 'Lazada Transaction';
                    ApplicationArea = all;
                    RunObject = page "Lazada Trans. Order Lists";
                }
            }
        }
    }
}
