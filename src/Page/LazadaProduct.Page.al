page 50108 "Lazada Product"
{
    Caption = 'Lazada Product';
    PageType = List;
    SourceTable = "Lazada Product";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(item_id; Rec.item_id)
                {
                    ToolTip = 'Specifies the value of the Item id field.';
                    ApplicationArea = All;
                }
                field("attributes.name"; Rec."attributes.name")
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                }
                field("attributes.description"; Rec."attributes.description")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("attributes.short_description"; Rec."attributes.short_description")
                {
                    ToolTip = 'Specifies the value of the Short description field.';
                    ApplicationArea = All;
                }
                field("attributes.brand"; Rec."attributes.brand")
                {
                    ToolTip = 'Specifies the value of the Brand field.';
                    ApplicationArea = All;
                }
                field("attributes.warranty_type"; Rec."attributes.warranty_type")
                {
                    ToolTip = 'Specifies the value of the Warranty type field.';
                    ApplicationArea = All;
                }
                field(marketImages; Rec.marketImages)
                {
                    ToolTip = 'Specifies the value of the Market Images field.';
                    ApplicationArea = All;
                }
                field(primary_category; Rec.primary_category)
                {
                    ToolTip = 'Specifies the value of the Primary category field.';
                    ApplicationArea = All;
                }
                field("skus.Available"; Rec."skus.Available")
                {
                    ToolTip = 'Specifies the value of the Available field.';
                    ApplicationArea = All;
                }
                field("skus.SellerSku"; Rec."skus.SellerSku")
                {
                    ToolTip = 'Specifies the value of the Seller Sku field.';
                    ApplicationArea = All;
                }
                field("skus.ShopSku"; Rec."skus.ShopSku")
                {
                    ToolTip = 'Specifies the value of the Shop Sku field.';
                    ApplicationArea = All;
                }
                field("skus.SkuId"; Rec."skus.SkuId")
                {
                    ToolTip = 'Specifies the value of the Sku Id field.';
                    ApplicationArea = All;
                }
                field("skus.Status"; Rec."skus.Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("skus.Url"; Rec."skus.Url")
                {
                    ToolTip = 'Specifies the value of the Url field.';
                    ApplicationArea = All;
                }
                field("skus.package_height"; Rec."skus.package_height")
                {
                    ToolTip = 'Specifies the value of the Package_height field.';
                    ApplicationArea = All;
                }
                field("skus.package_length"; Rec."skus.package_length")
                {
                    ToolTip = 'Specifies the value of the Package length field.';
                    ApplicationArea = All;
                }
                field("skus.package_weight"; Rec."skus.package_weight")
                {
                    ToolTip = 'Specifies the value of the Package weight field.';
                    ApplicationArea = All;
                }
                field("skus.package_width"; Rec."skus.package_width")
                {
                    ToolTip = 'Specifies the value of the Package width field.';
                    ApplicationArea = All;
                }
                field("skus.price"; Rec."skus.price")
                {
                    ToolTip = 'Specifies the value of the Price field.';
                    ApplicationArea = All;
                }
                field("skus.product_weight"; Rec."skus.product_weight")
                {
                    ToolTip = 'Specifies the value of the Product weight field.';
                    ApplicationArea = All;
                }
                field("skus.quantity"; Rec."skus.quantity")
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    ApplicationArea = All;
                }
                field("skus.special_from_time"; Rec."skus.special_from_time")
                {
                    ToolTip = 'Specifies the value of the Special from time field.';
                    ApplicationArea = All;
                }
                field("skus.special_price"; Rec."skus.special_price")
                {
                    ToolTip = 'Specifies the value of the Special price field.';
                    ApplicationArea = All;
                }
                field("skus.special_to_date"; Rec."skus.special_to_date")
                {
                    ToolTip = 'Specifies the value of the Special to date field.';
                    ApplicationArea = All;
                }
                field("skus.special_to_time"; Rec."skus.special_to_time")
                {
                    ToolTip = 'Specifies the value of the Special to time field.';
                    ApplicationArea = All;
                }
                field(subStatus; Rec.subStatus)
                {
                    ToolTip = 'Specifies the value of the Sub Status field.';
                    ApplicationArea = All;
                }
                field(total_products; Rec.total_products)
                {
                    ToolTip = 'Specifies the value of the Total product field.';
                    ApplicationArea = All;
                }
                field(images; Rec.images)
                {
                    ToolTip = 'Specifies the value of the Images field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Product Lazada")
            {
                Caption = 'Get Product Lazada';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = UserInterface;
                trigger OnAction()
                var
                    apifunc: Codeunit "API Func";
                    lttimestamp: BigInteger;
                begin

                end;
            }

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
                    ltItem: Record Item;
                    ltItemLists: Page "Item List";
                    apifunc: Codeunit "API Func";
                    lttimestamp: BigInteger;
                begin
                    CLEAR(ltItemLists);
                    ltItem.reset();
                    ltItem.SetRange("Lazada Item Id", '');
                    ltItemLists.SetTableView(ltItem);
                    ltItemLists.Editable := false;
                    ltItemLists.LookupMode := true;
                    if ltItemLists.RunModal() = Action::LookupOK then begin
                        ltItemLists.GetRecord(ltItem);
                        lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
                        APIFunc.SetTimeStamp(lttimestamp);
                        apifunc."Create Product"(ltItem."No.");
                    end;
                    CLEAR(ltItemLists);

                end;
            }
            action("Update Product Lazada")
            {
                Caption = 'Update Qty. & Price Product Lazada';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = UpdateUnitCost;
                trigger OnAction()
                var
                    ltItem: Record Item;
                    apifunc: Codeunit "API Func";
                    lttimestamp: BigInteger;
                    ConfirmMsg: Label 'Do you want Update Item no. %1 quantity %2 , price %3 ,to Lazada System.', Locked = true;
                    CheckItemTxt: Label 'not found item no. %1 on lazada system.', Locked = true;
                begin
                    ltItem.reset();
                    ltItem.SetRange("Lazada Item Id", rec.item_id);
                    ltItem.SetRange("Lazada Sku id", rec."skus.SkuId");
                    if ltItem.FindFirst() then begin
                        ltItem.CalcFields(Inventory);
                        if not Confirm(StrSubstNo(ConfirmMsg, ltItem."No.", ltItem.Inventory, ltItem."Lazada Price")) then
                            exit;
                        lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
                        APIFunc.SetTimeStamp(lttimestamp);
                        apifunc.UpdateProductQuantity(ltItem."No.");
                    end else
                        Message(StrSubstNo(CheckItemTxt, ltItem."No."));
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
                    ltItem: Record Item;
                    apifunc: Codeunit "API Func";
                    lttimestamp: BigInteger;
                    ConfirmMsg: Label 'Do you want Remove Item no. %1 on Lazada System.', Locked = true;
                    CheckItemTxt: Label 'not found item no. %1 on lazada system.', Locked = true;
                begin
                    ltItem.reset();
                    ltItem.SetRange("Lazada Item Id", rec.item_id);
                    ltItem.SetRange("Lazada Sku id", rec."skus.SkuId");
                    if ltItem.FindFirst() then begin
                        if not Confirm(StrSubstNo(ConfirmMsg, ltItem."No.")) then
                            exit;
                        lttimestamp := APIFunc.GetTimestamp(CurrentDateTime());
                        APIFunc.SetTimeStamp(lttimestamp);
                        apifunc."Remove Product"(ltItem."No.");
                        ltItem."Lazada Item Id" := '';
                        ltItem."Lazada Seller sku" := '';
                        ltItem."Lazada Shop sku" := '';
                        ltItem."Lazada Sku id" := '';
                        ltItem.Modify();
                        rec.Delete();
                    end else
                        Message(StrSubstNo(CheckItemTxt, ltItem."No."));
                end;
            }
        }
    }
}

