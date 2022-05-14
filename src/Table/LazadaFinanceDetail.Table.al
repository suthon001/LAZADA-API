/// <summary>
/// Table Lazada Finance Detail (ID 50105).
/// </summary>
table 50105 "Lazada Finance Detail"
{
    Caption = 'Lazada Finance Detail';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Order no"; code[50])
        {
            Caption = 'Order No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Order No")
        {
            Clustered = true;
        }
    }
}
