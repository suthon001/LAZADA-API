/// <summary>
/// Page Lazada Create Update Product (ID 50108).
/// </summary>
page 50108 "Lazada Create & Update Product"
{
    Caption = 'Lazada Create & Update Product';
    PageType = List;
    CardPageId = "Item Card";
    SourceTable = Item;
    ApplicationArea = all;
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the item.';
                    ApplicationArea = All;
                }
                field("No. 2"; Rec."No. 2")
                {
                    ToolTip = 'Specifies the value of the No. 2 field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies what you are selling.';
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies the value of the Description 2 field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the price of one unit of the item or resource. You can enter a price manually or have it entered according to the Price/Profit Calculation field on the related card.';
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                    ApplicationArea = All;
                }
                field("Lazada Item Id"; rec."Lazada Item Id")
                {
                    ToolTip = 'Specifies the value of the Lazada Item Id field.';
                    ApplicationArea = All;
                }
                field("Lazada Price"; rec."Lazada Price")
                {
                    ToolTip = 'Specifies the value of the Lazada Price field.';
                    ApplicationArea = All;
                }
                field("Lazada Seller sku"; rec."Lazada Seller sku")
                {
                    ToolTip = 'Specifies the value of the Lazada Seller sku field.';
                    ApplicationArea = All;
                }
                field("Lazada Shop sku"; rec."Lazada Shop sku")
                {
                    ToolTip = 'Specifies the value of the Lazada Shop sku field.';
                    ApplicationArea = All;
                }
                field("Lazada Sku id"; rec."Lazada Sku id")
                {
                    ToolTip = 'Specifies the value of the Lazada Sku id field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)

        {
            action("Create Product Lazada")
            {
                Caption = 'Create Product Lazada';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = CreateInteraction;
                trigger OnAction()
                var
                    apifunc: Codeunit "API Func";
                    lttimestamp: BigInteger;
                    CheckItemTxt: Label 'Already created on lazada ,Ref. lazada Item id %1', Locked = true;
                begin
                    if rec."Lazada Item Id" <> '' then begin
                        Message(StrSubstNo(CheckItemTxt, rec."Lazada Item Id"));
                        exit;
                    end;
                    if not Confirm(StrSubstNo('Do you want Create Item no. %1 to Lazada System.', rec."No.")) then
                        exit;
                    lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
                    APIFunc.SetTimeStamp(lttimestamp);
                    apifunc."Create Product"(rec."No.");
                end;
            }
            action("Update Product Lazada")
            {
                Caption = 'Update Product Lazada';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = UpdateUnitCost;
                trigger OnAction()
                var
                    apifunc: Codeunit "API Func";
                    lttimestamp: BigInteger;
                    ConfirmMsg: Label 'Do you want Update Item no. %1 quantity %2 , price %3 ,to Lazada System.', Locked = true;
                    CheckItemTxt: Label 'not found item no. %1 on lazada system.', Locked = true;
                begin
                    if rec."Lazada Item Id" = '' then begin
                        Message(StrSubstNo(CheckItemTxt, rec."No."));
                        exit;
                    end;
                    rec.CalcFields(Inventory);
                    if not Confirm(StrSubstNo(ConfirmMsg, rec."No.", rec.Inventory, rec."Lazada Price")) then
                        exit;
                    lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
                    APIFunc.SetTimeStamp(lttimestamp);
                    apifunc.UpdateProductQuantity(rec."No.");
                end;
            }
            action("Remove Product Lazada")
            {
                Caption = 'Remove Product Lazada';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = RemoveLine;
                trigger OnAction()
                var
                    apifunc: Codeunit "API Func";
                    lttimestamp: BigInteger;
                    ConfirmMsg: Label 'Do you want Remove Item no. %1 on Lazada System.', Locked = true;
                    CheckItemTxt: Label 'not found item no. %1 on lazada system.', Locked = true;
                begin
                    if rec."Lazada Item Id" = '' then begin
                        Message(StrSubstNo(CheckItemTxt, rec."No."));
                        exit;
                    end;
                    rec.CalcFields(Inventory);
                    if not Confirm(StrSubstNo(ConfirmMsg, rec."No.")) then
                        exit;
                    lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
                    APIFunc.SetTimeStamp(lttimestamp);
                    apifunc."Remove Product"(rec."No.");
                    rec."Lazada Item Id" := '';
                    rec."Lazada Seller sku" := '';
                    rec."Lazada Shop sku" := '';
                    rec."Lazada Sku id" := '';
                    rec.Modify();
                end;
            }
        }
    }
}
