/// <summary>
/// TableExtension Lazada Item (ID 50100) extends Record Item.
/// </summary>
tableextension 50100 "Lazada Item" extends Item
{
    fields
    {
        field(50100; "Lazada Price"; Decimal)
        {
            Caption = 'Lazada Price';
            DataClassification = ToBeClassified;
        }
        field(50101; "Lazada Item Id"; Code[30])
        {
            Caption = 'Lazada Item Id';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50102; "Lazada Shop sku"; Code[30])
        {
            Caption = 'Lazada Shop sku';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50103; "Lazada Seller sku"; Code[30])
        {
            Caption = 'Lazada Seller sku';
            DataClassification = ToBeClassified;
        }
        field(50104; "Lazada Sku id"; Code[30])
        {
            Caption = 'Lazada Sku id';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50105; "Lazada Url Image 1"; Text[250])
        {
            Caption = 'Lazada Url Image 1';
            DataClassification = ToBeClassified;

        }
        field(50106; "Lazada Url Image 2"; Text[250])
        {
            Caption = 'Lazada Url Image 2';
            DataClassification = ToBeClassified;

        }
        field(50107; "Lazada Url Image 3"; Text[250])
        {
            Caption = 'Lazada Url Image 3';
            DataClassification = ToBeClassified;

        }
        field(50108; "Lazada Url Image 4"; Text[250])
        {
            Caption = 'Lazada Url Image 4';
            DataClassification = ToBeClassified;

        }
        field(50109; "Package length"; Decimal)
        {
            Caption = 'Package length';
            DataClassification = ToBeClassified;

        }
        field(50110; "Package height"; Decimal)
        {
            Caption = 'Package height';
            DataClassification = ToBeClassified;

        }
        field(50111; "Package weight"; Decimal)
        {
            Caption = 'Package weight';
            DataClassification = ToBeClassified;

        }
        field(50112; "Package width"; Decimal)
        {
            Caption = 'Package width';
            DataClassification = ToBeClassified;

        }
        field(50113; "Package content"; Text[100])
        {
            Caption = 'Package content';
            DataClassification = ToBeClassified;

        }
        field(50114; "Lazada Warranty type"; Text[100])
        {
            Caption = 'Warranty type';
            DataClassification = ToBeClassified;

        }
        field(50115; "Lazada Warranty"; Text[100])
        {
            Caption = 'Warranty';
            DataClassification = ToBeClassified;

        }
    }
}
