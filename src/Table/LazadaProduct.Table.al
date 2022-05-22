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
        field(3; "skus.Status"; text[50])
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(4; "skus.quantity"; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(5; "skus.product_weight"; Decimal)
        {
            Caption = 'Product weight';
            DataClassification = ToBeClassified;
        }
        field(6; "skus.SellerSku"; text[50])
        {
            Caption = 'Seller Sku';
            DataClassification = ToBeClassified;
        }
        field(7; "skus.ShopSku"; text[50])
        {
            Caption = 'Shop Sku';
            DataClassification = ToBeClassified;
        }
        field(8; "skus.Url"; text[250])
        {
            Caption = 'Url';
            DataClassification = ToBeClassified;
        }
        field(9; "skus.package_width"; Decimal)
        {
            Caption = 'Package width';
            DataClassification = ToBeClassified;
        }
        field(10; "skus.special_to_time"; text[50])
        {
            Caption = 'Special to time';
            DataClassification = ToBeClassified;
        }
        field(11; "skus.special_from_time"; text[50])
        {
            Caption = 'Special from time';
            DataClassification = ToBeClassified;
        }
        field(12; "skus.package_height"; Decimal)
        {
            Caption = 'Package_height';
            DataClassification = ToBeClassified;
        }
        field(13; "skus.special_price"; Decimal)
        {
            Caption = 'Special price';
            DataClassification = ToBeClassified;
        }
        field(14; "skus.price"; Decimal)
        {
            Caption = 'Price';
            DataClassification = ToBeClassified;
        }
        field(15; "skus.package_length"; Decimal)
        {
            Caption = 'Package length';
            DataClassification = ToBeClassified;
        }
        field(16; "skus.package_weight"; Decimal)
        {
            Caption = 'Package weight';
            DataClassification = ToBeClassified;
        }
        field(17; "skus.Available"; text[50])
        {
            Caption = 'Available';
            DataClassification = ToBeClassified;
        }
        field(18; "skus.SkuId"; text[50])
        {
            Caption = 'Sku Id';
            DataClassification = ToBeClassified;
        }
        field(19; "skus.special_to_date"; text[50])
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
        field(23; "attributes.short_description"; text[250])
        {
            Caption = 'Short description';
            DataClassification = ToBeClassified;
        }
        field(24; "attributes.name"; text[250])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(25; "attributes.description"; text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(26; "attributes.warranty_type"; text[50])
        {
            Caption = 'Warranty type';
            DataClassification = ToBeClassified;
        }
        field(27; "attributes.brand"; text[50])
        {
            Caption = 'Brand';
            DataClassification = ToBeClassified;
        }
        field(28; "subStatus"; text[50])
        {
            Caption = 'Sub Status';
            DataClassification = ToBeClassified;
        }


    }
    keys
    {
        key(PK; item_id)
        {
            Clustered = true;
        }
    }

}
