permissionset 50100 "PermissionSet"
{
    Assignable = true;
    Caption = 'PermissionSet', MaxLength = 30;
    Permissions =
        table "Lazada Order Trans. Header" = X,
        tabledata "Lazada Order Trans. Header" = RMID,
        table "Lazada Setup Entry" = X,
        tabledata "Lazada Setup Entry" = RMID,
        table "Lazada Order Transaction Line" = X,
        tabledata "Lazada Order Transaction Line" = RMID,
        table "Lazada Finance Detail" = X,
        tabledata "Lazada Finance Detail" = RMID,
        table "Lazada Shipment Providers" = X,
        tabledata "Lazada Shipment Providers" = RMID,
        codeunit "API Func" = X,
        page "Lazada Confirm Dialog Order" = X,
        page "Lazada Create & Update Product" = X,
        page "Lazada Setup Card" = X,
        page "Lazada Trans. Subfrom" = X,
        page "Lazada Trans. Order Card" = X,
        page "Lazada Trans. Order Lists" = X,
        page "Lazada Confirm Dialog Finance" = X,
        page "Lazada Finance Transaction" = X,
        page "Lazada Shipment Providers" = X;
}
