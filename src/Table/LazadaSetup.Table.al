/// <summary>
/// Table Lazada Setup (ID 50100).
/// </summary>
table 50100 "Lazada Setup Entry"
{
    Caption = 'Lazada Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "App Key"; Text[1024])
        {
            Caption = 'App Key';
            DataClassification = ToBeClassified;
        }//"App Secret"
        field(3; "App Secret"; text[250])
        {
            Caption = 'App Secret';
            DataClassification = ToBeClassified;
        }
        field(4; "Access Token"; Text[250])
        {
            Caption = 'Access Token';
            DataClassification = ToBeClassified;
        }
        field(5; "Refresh Token"; Text[250])
        {
            Caption = 'Refresh Token';
            DataClassification = ToBeClassified;
        }
        field(6; "Seller Code"; Text[1024])
        {
            Caption = 'Seller Code';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }


}
