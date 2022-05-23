permissionset 50100 LazadaPermission
{
    Assignable = true;
    Caption = 'LazadaPermission', MaxLength = 30;
    Permissions =
        table "Lazada Finance Detail" = X,
        tabledata "Lazada Finance Detail" = RMID,
        table "Lazada Get Brand & Attributes" = X,
        tabledata "Lazada Get Brand & Attributes" = RMID,
        table "Lazada Order Trans. Header" = X,
        tabledata "Lazada Order Trans. Header" = RMID,
        table "Lazada Product" = X,
        tabledata "Lazada Product" = RMID,
        table "Lazada Setup Entry" = X,
        tabledata "Lazada Setup Entry" = RMID,
        table "Lazada Order Transaction Line" = X,
        tabledata "Lazada Order Transaction Line" = RMID,
        table "Lazada Shipment Providers" = X,
        tabledata "Lazada Shipment Providers" = RMID,
        table "Lazada Get Order Trace" = X,
        tabledata "Lazada Get Order Trace" = RMID,
        codeunit "API Func" = X,
        page "Lazada Brand" = X,
        page "Lazada Confirm Dialog Finance" = X,
        page "Lazada Confirm Dialog Order" = X,
        page "Lazada Confirm Dialog Product" = X,
        page "Lazada Finance Transaction" = X,
        page "Lazada Posted Order Card" = X,
        page "Lazada Posted Trans. Subfrom" = X,
        page "Lazada Setup Card" = X,
        page "Lazada Shipment Providers" = X,
        page "Lazada Trans. Order Card" = X,
        page "Lazada Trans. Order Lists" = X,
        page "Lazada Trans. Subfrom" = X,
        page "Lazada Product" = X,
        page "Lazada Posted Order Lists" = X,
        page "Lazada Attributes" = X,
        page "Lazada Order Trace" = X;
}
