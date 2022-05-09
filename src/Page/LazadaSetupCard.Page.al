/// <summary>
/// Page Lazada Setup (ID 50100).
/// </summary>
page 50100 "Lazada Setup Card"
{
    Caption = 'Lazada Setup';
    PageType = Card;
    SourceTable = "Lazada Setup Entry";
    ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Seller Code"; Rec."Seller Code")
                {
                    ToolTip = 'Specifies the value of the Seller Code field.';
                    ApplicationArea = All;
                }
                field("App Key"; rec."App Key")
                {
                    ToolTip = 'Specifies the value of the App Key field.';
                    ApplicationArea = All;
                }
                field("App Secret"; rec."App Secret")
                {
                    ToolTip = 'Specifies the value of the App Secret field.';
                    ApplicationArea = All;
                }
                field("Access Token"; rec."Access Token")
                {
                    ToolTip = 'Specifies the value of the Access Token field.';
                    ApplicationArea = All;
                }
                field("Refresh Token"; rec."Refresh Token")
                {
                    ToolTip = 'Specifies the value of the Refresh Token field.';
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(Processing)

        {
            action("Get Access Token")
            {
                Caption = 'Access Token';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    apifunc: Codeunit "API Func";
                begin
                    apifunc.GetAccessToken();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

}
