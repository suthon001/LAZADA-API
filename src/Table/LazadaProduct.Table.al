/// <summary>
/// Table Lazada Product (ID 50105).
/// </summary>
table 50105 "Lazada Product"
{
    Caption = 'Lazada Product';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "total_products"; Integer)
        {
            Caption = 'Total product';
            DataClassification = ToBeClassified;
        }
        field(2; "images"; text[250])
        {
            Caption = 'Images';
            DataClassification = ToBeClassified;
        }
        field(3; "Status"; text[50])
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(4; "quantity"; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(5; "product_weight"; Decimal)
        {
            Caption = 'Product weight';
            DataClassification = ToBeClassified;
        }
        field(6; "SellerSku"; text[50])
        {
            Caption = 'Seller Sku';
            DataClassification = ToBeClassified;
        }
        field(7; "ShopSku"; text[50])
        {
            Caption = 'Shop Sku';
            DataClassification = ToBeClassified;
        }
        field(8; "Url"; text[250])
        {
            Caption = 'Url';
            DataClassification = ToBeClassified;
        }
        field(9; "package_width"; Decimal)
        {
            Caption = 'Package width';
            DataClassification = ToBeClassified;
        }
        field(10; "special_to_time"; text[50])
        {
            Caption = 'Special to time';
            DataClassification = ToBeClassified;
        }
        field(11; "special_from_time"; text[50])
        {
            Caption = 'Special from time';
            DataClassification = ToBeClassified;
        }
        field(12; "package_height"; Decimal)
        {
            Caption = 'Package_height';
            DataClassification = ToBeClassified;
        }
        field(13; "special_price"; Decimal)
        {
            Caption = 'Special price';
            DataClassification = ToBeClassified;
        }
        field(14; "price"; Decimal)
        {
            Caption = 'Price';
            DataClassification = ToBeClassified;
        }
        field(15; "package_length"; Decimal)
        {
            Caption = 'Package length';
            DataClassification = ToBeClassified;
        }
        field(16; "package_weight"; Decimal)
        {
            Caption = 'Package weight';
            DataClassification = ToBeClassified;
        }
        field(17; "Available"; text[50])
        {
            Caption = 'Available';
            DataClassification = ToBeClassified;
        }
        field(18; "SkuId"; text[50])
        {
            Caption = 'Sku Id';
            DataClassification = ToBeClassified;
        }
        field(19; "special_to_date"; text[50])
        {
            Caption = 'Special to date';
            DataClassification = ToBeClassified;
        }
        field(20; "item_id"; text[50])
        {
            Caption = 'Item id';
            DataClassification = ToBeClassified;
        }
        field(21; "primary_category"; text[50])
        {
            Caption = 'Primary category';
            DataClassification = ToBeClassified;
        }
        field(22; "marketImages"; text[250])
        {
            Caption = 'Market Images';
            DataClassification = ToBeClassified;
        }
        field(23; "short_description"; text[250])
        {
            Caption = 'Short description';
            DataClassification = ToBeClassified;
        }
        field(24; "name"; text[250])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(25; "description"; text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(26; "warranty_type"; text[50])
        {
            Caption = 'Warranty type';
            DataClassification = ToBeClassified;
        }
        field(27; "brand"; text[50])
        {
            Caption = 'Brand';
            DataClassification = ToBeClassified;
        }
        field(28; "subStatus"; text[50])
        {
            Caption = 'Sub Status';
            DataClassification = ToBeClassified;
        }
        field(29; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }


    }
    keys
    {
        key(PK; item_id, "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Entry No." := "Get LastEntry";
    end;
    /// <summary>
    /// Get LastEntry.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure "Get LastEntry"(): Integer
    var
        ltLazadaProduct: Record "Lazada Product";
    begin
        ltLazadaProduct.reset();
        ltLazadaProduct.SetCurrentKey(item_id, "Entry No.");
        ltLazadaProduct.SetRange(item_id, Rec.item_id);
        if ltLazadaProduct.FindLast() then
            exit(ltLazadaProduct."Entry No." + 1);
        exit(1);
    end;
}
