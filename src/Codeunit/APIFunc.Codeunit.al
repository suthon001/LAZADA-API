/// <summary>
/// Codeunit API Func (ID 50100).
/// </summary>
codeunit 50100 "API Func"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure LazadaAfterInitItemLedger(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
        NewItemLedgEntry."Lazada Order ID" := ItemJournalLine."Lazada Order ID";
        NewItemLedgEntry."Lazada Order Item Id" := ItemJournalLine."Lazada Order Item Id";
        NewItemLedgEntry."Lazada Shipment provider" := ItemJournalLine."Lazada Shipment provider";
        NewItemLedgEntry."Lazada Tracking number" := ItemJournalLine."Lazada Tracking number";
        NewItemLedgEntry."Lazada Package id" := ItemJournalLine."Lazada Package id";
        NewItemLedgEntry."Lazada Purchase order id" := ItemJournalLine."Lazada Purchase order id";
        NewItemLedgEntry."Lazada Purchase order Number" := ItemJournalLine."Lazada Purchase order Number";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesLine', '', false, false)]
    local procedure LazadaOnAfterCopyItemJnlLineFromSalesLine(SalesLine: Record "Sales Line"; var ItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine."Lazada Order ID" := SalesLine."Lazada Order ID";
        ItemJnlLine."Lazada Order Item Id" := SalesLine."Lazada Order Item Id";
        ItemJnlLine."Lazada Shipment provider" := SalesLine."Lazada Shipment provider";
        ItemJnlLine."Lazada Tracking number" := SalesLine."Lazada Tracking number";
        ItemJnlLine."Lazada Package id" := SalesLine."Lazada Package id";
        ItemJnlLine."Lazada Purchase order id" := SalesLine."Lazada Purchase order id";
        ItemJnlLine."Lazada Purchase order Number" := SalesLine."Lazada Purchase order Number";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Status', false, false)]
    local procedure AfterSalesStatus(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    begin
        if Rec."Lazada Order ID" <> '' then
            if rec.Status <> rec.Status then
                if rec.Status = rec.Status::Released then
                    "Set Status Dropship"(Rec."Lazada Order ID", rec."No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnBeforeInsertInvLineFromShptLine', '', false, false)]
    local procedure LazadaOnBeforeInsertInvLineFromShptLine(var SalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    begin
        SalesLine."Lazada Order ID" := SalesShptLine."Lazada Order ID";
        SalesLine."Lazada Order Item Id" := SalesShptLine."Lazada Order Item Id";
        SalesLine."Lazada Shipment provider" := SalesShptLine."Lazada Shipment provider";
        SalesLine."Lazada Tracking number" := SalesShptLine."Lazada Tracking number";
        SalesLine."Lazada Package id" := SalesShptLine."Lazada Package id";
        SalesLine."Lazada Purchase order id" := SalesShptLine."Lazada Purchase order id";
        SalesLine."Lazada Purchase order Number" := SalesShptLine."Lazada Purchase order Number";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterFinalizePosting', '', false, false)]
    local procedure LazadaOnAfterFinalizePostingSales(var SalesHeader: Record "Sales Header")
    var
        ltSalesLine: Record "Sales Line";
    begin
        if SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::"Return Order"] then
            if SalesHeader."Lazada Order ID" <> '' then begin
                ltSalesLine.reset();
                ltSalesLine.SetRange("Document Type", SalesHeader."Document Type");
                ltSalesLine.SetRange("Document No.", SalesHeader."No.");
                ltSalesLine.SetRange(type, ltSalesLine.type::Item);
                if ltSalesLine.findset() then
                    repeat
                        UpdateProductQuantity(ltSalesLine."No.");
                    until ltSalesLine.next() = 0;
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeDeleteAfterPosting', '', false, false)]
    local procedure LazadaOnBeforeDeleteAfterPosting(SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesHeader: Record "Sales Header")
    var
        ltSalesInvoiceLine: Record "Sales Invoice Line";
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then begin
            ltSalesInvoiceLine.reset();
            ltSalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
            ltSalesInvoiceLine.SetRange(Type, ltSalesInvoiceLine.Type::Item);
            ltSalesInvoiceLine.SetFilter("Lazada Order Item Id", '<>%1', '');
            if ltSalesInvoiceLine.FindFirst() then
                repeat
                    "Set Invoice"(ltSalesInvoiceLine."Lazada Order Item Id", ltSalesInvoiceLine."Document No.");
                until ltSalesInvoiceLine.next() = 0;
        end;
    end;
    // /OnAfterDeleteAfterPosting
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterFinalizePosting', '', false, false)]
    local procedure LazadaOnAfterFinalizePostingPurch(var PurchHeader: Record "Purchase Header")
    var
        ltPurchaseLine: Record "Purchase Line";
        ltItem: Record Item;
    begin
        if PurchHeader."Document Type" IN [PurchHeader."Document Type"::Order, PurchHeader."Document Type"::"Return Order"] then begin
            ltPurchaseLine.reset();
            ltPurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
            ltPurchaseLine.SetRange("Document No.", PurchHeader."No.");
            ltPurchaseLine.SetRange(type, ltPurchaseLine.type::Item);
            if ltPurchaseLine.findset() then
                repeat
                    ltItem.GET(ltPurchaseLine."No.");
                    if ltItem."Lazada Item Id" <> '' then
                        UpdateProductQuantity(ltPurchaseLine."No.");
                until ltPurchaseLine.next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnBeforeUpdateDeleteLines', '', false, false)]
    local procedure LazadaOnBeforeUpdateDeleteLines(var ItemJournalLine: Record "Item Journal Line")
    var
        ltitemjournalline: Record "Item Journal Line";
        ltItem: record "Item";
    begin
        ltitemjournalline.reset();
        ltitemjournalline.CopyFilters(ItemJournalLine);
        ltitemjournalline.SetFilter("Entry Type", '%1|%2', ltitemjournalline."Entry Type"::"Negative Adjmt.", ltitemjournalline."Entry Type"::"Positive Adjmt.");
        if ltitemjournalline.FindSet() then
            repeat
                ltItem.GET(ltitemjournalline."Item No.");
                if ltItem."Lazada Item Id" <> '' then
                    UpdateProductQuantity(ltitemjournalline."Item No.");
            until ltitemjournalline.next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Sales Shipment Line", 'OnAfterSalesShptLineModify', '', false, false)]
    local procedure LazadaOnAfterSalesShptLineModify(var SalesShptLine: Record "Sales Shipment Line")
    var
        ltItem: Record Item;
    begin
        if ltItem.get(SalesShptLine."No.") then
            if ltItem."Lazada Item Id" <> '' then
                UpdateProductQuantity(ltItem."No.");
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Return Shipment Line", 'OnAfterReturnShptLineModify', '', false, false)]
    local procedure LazadaOnAfterReturnShptLineModify(var ReturnShptLine: Record "Return Shipment Line")
    var
        ltItem: Record Item;
    begin
        if ltItem.get(ReturnShptLine."No.") then
            if ltItem."Lazada Item Id" <> '' then
                UpdateProductQuantity(ltItem."No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnAfterPurchRcptLineModify', '', false, false)]
    local procedure LazadaOnAfterPurchRcptLineModify(var PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        ltItem: Record Item;
    begin
        if ltItem.get(PurchRcptLine."No.") then
            if ltItem."Lazada Item Id" <> '' then
                UpdateProductQuantity(ltItem."No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Return Receipt Line", 'OnAfterReturnRcptLineModify', '', false, false)]
    local procedure LazadaOnAfterReturnRcptLineModify(var ReturnRcptLine: Record "Return Receipt Line")
    var
        ltItem: Record Item;
    begin
        if ltItem.get(ReturnRcptLine."No.") then
            if ltItem."Lazada Item Id" <> '' then
                UpdateProductQuantity(ltItem."No.");
    end;

    /// <summary>
    /// GetToken.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure "GetAccessToken"(): Boolean;
    var
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltJsonArray: JsonArray;
        generatetokenTxt: Label 'https://api.lazada.com/rest/auth/token/create?code=%1&app_key=%2&timestamp=%3&sign_method=sha256&sign=%4', Locked = true;
    begin
        GetLazadaSetup();
        if not gvLazadaSetup.Active then
            exit(false);
        if gvLazadaSetup."Refresh Token" <> '' then
            RefreshAccessToken()
        else begin
            gvtokenpath := StrSubstNo(AccessTokenpathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Seller Code", gvTimeStam);
            gvUrlAddress := StrSubstNo(generatetokenTxt, gvLazadaSetup."Seller Code", gvLazadaSetup."App Key", gvTimeStam, GenerateSign(gvtokenpath));
            ConnectToLazada('GET', gvUrlAddress, ltJsonObject, ltJsonToken);
            ltJsonObject.get('access_token', ltJsonToken);
            gvLazadaSetup."Access Token" := ltJsonToken.AsValue().AsText();
            ltJsonObject.get('refresh_token', ltJsonToken);
            gvLazadaSetup."Refresh Token" := ltJsonToken.AsValue().AsText();
            gvLazadaSetup.Modify();
            Commit();
        end;
        GetLazadaSetup();
        exit(true);
    end;

    local procedure RefreshAccessToken()
    var
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltJsonArray: JsonArray;
        generatetokenTxt: Label 'https://api.lazada.com/rest/auth/token/refresh?refresh_token=%1&app_key=%2&timestamp=%3&sign_method=sha256&sign=%4', Locked = true;
    begin
        gvLazadaSetup.TestField("Refresh Token");
        gvtokenpath := StrSubstNo(refreshpathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Refresh Token", gvTimeStam);
        gvUrlAddress := StrSubstNo(generatetokenTxt, gvLazadaSetup."Refresh Token", gvLazadaSetup."App Key", gvTimeStam, GenerateSign(gvtokenpath));
        ConnectToLazada('GET', gvUrlAddress, ltJsonObject, ltJsonToken);
        ltJsonObject.get('access_token', ltJsonToken);
        gvLazadaSetup."Access Token" := ltJsonToken.AsValue().AsText();
        ltJsonObject.get('refresh_token', ltJsonToken);
        gvLazadaSetup."Refresh Token" := ltJsonToken.AsValue().AsText();
        gvLazadaSetup.Modify();
        Commit();
    end;

    PROCEDURE GetTimestamp(dt: DateTime) UtcTime: BigInteger;
    VAR
        ltmyTime: Time;
        ltmilliseconds: Decimal;
        ltseconds: Integer;
        ltminutes: Integer;
        lthours: Integer;
        ltdays: Integer;
        ltTimeStampDecimal: Decimal;
        ltTimeStampInteger: BigInteger;
    BEGIN
        dt -= GetUTCOffset();
        ltmyTime := DT2TIME(dt);
        IF EVALUATE(lthours, FORMAT(ltmyTime, 0, '<Hours24,2>')) THEN;
        IF EVALUATE(ltminutes, FORMAT(ltmyTime, 0, '<Minutes,2>')) THEN;
        IF EVALUATE(ltseconds, FORMAT(ltmyTime, 0, '<Seconds,2>')) THEN;
        IF EVALUATE(ltmilliseconds, FORMAT(ltmyTime, 0, '<Second dec>')) THEN;
        ltdays := (DT2DATE(dt) - DMY2DATE(1, 1, 1970));
        ltTimeStampDecimal := ltdays * 24 * 60 * 60 + lthours * 60 * 60 + ltminutes * 60 + ltseconds + ltmilliseconds;
        ltTimeStampInteger := ltTimeStampDecimal * 1000;
        EXIT(ltTimeStampInteger);
    END;

    LOCAL PROCEDURE GetUTCOffset(): Integer;
    VAR
        UTCDateTime: DateTime;
        LocalDateTime: DateTime;
        UTCTime: Time;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        LocalDateTimeXMLFormat: Text;
    BEGIN
        LocalDateTime := CREATEDATETIME(TODAY(), 010000T);
        LocalDateTimeXMLFormat := FORMAT(LocalDateTime, 0, 9);
        EVALUATE(Day, COPYSTR(LocalDateTimeXMLFormat, 9, 2));
        EVALUATE(Month, COPYSTR(LocalDateTimeXMLFormat, 6, 2));
        EVALUATE(Year, COPYSTR(LocalDateTimeXMLFormat, 1, 4));
        EVALUATE(UTCTime, COPYSTR(LocalDateTimeXMLFormat, 12, 8));

        UTCDateTime := CREATEDATETIME(DMY2DATE(Day, Month, Year), UTCTime);
        EXIT(LocalDateTime - UTCDateTime);
    END;

    local procedure GenerateSign(ptokenpath: Text): Text
    var
        CryptographyMgt: Codeunit "Cryptography Management";
        HashAlgorithmType: Option HMACMD5,HMACSHA1,HMACSHA256,HMACSHA384,HMACSHA512;

    begin
        EXIT(CryptographyMgt.GenerateHash(ptokenpath, gvLazadaSetup."App Secret", HashAlgorithmType::HMACSHA256));
    end;

    local procedure GetLazadaSetup()
    begin
        gvLazadaSetup.GET();
        gvLazadaSetup.TestField("Seller Code");
        gvLazadaSetup.TestField("App Key");
        gvLazadaSetup.TestField("App Secret");
    end;

    procedure "Set Invoice"(pOderItemID: Code[50]; pInvoiceNo: Code[30])
    var
        ltJsonObject: JsonObject;
        ltJsonToken: JsonToken;
        SetInvoicePath: Label 'https://api.lazada.co.th/rest/order/invoice_number/set?app_key=%1&access_token=%2&sign_method=sha256&sign=%3&timestamp=%4&invoice_number=%5&order_item_id=%6', Locked = true;
        SetInvoiceSign: Label '/order/invoice_number/setaccess_token%1app_key%2invoice_number&3order_item_id%4sign_methodsha256timestamp%5', Locked = true;
    begin
        if GetAccessToken() then begin
            gvtokenpath := StrSubstNo(SetInvoiceSign, gvLazadaSetup."Access Token", gvLazadaSetup."App Key", pInvoiceNo, pOderItemID, gvTimeStam);
            gvUrlAddress := StrSubstNo(SetInvoicePath, gvLazadaSetup."App Key", gvLazadaSetup."Access Token", GenerateSign(gvtokenpath), gvTimeStam, pInvoiceNo, pOderItemID);
            ConnectToLazada('POST', gvUrlAddress, ltJsonObject, ltJsonToken);
        end;
    end;
    /// <summary>
    /// Create Product.
    /// </summary>
    /// <param name="pItemNo">Code[30].</param>

    procedure "Create Product"(pItemNo: Code[30])
    var
        ltItem: Record Item;
        ltdefaultdimension: Record "Default Dimension";
        Tempblob: Codeunit "Temp Blob";
        DataText, ltPayload : Text[2048];
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltJsonArray: JsonArray;
        CreateProductionPathTxt: Label 'https://api.lazada.co.th/rest/product/create?app_key=%1&access_token=%2&sign_method=sha256&sign=%3&timestamp=%4&payload=%5', Locked = true;
        CreateProductionSignTxt: Label '/product/createaccess_token%1app_key%2payload%3sign_methodsha256timestamp%4', Locked = true;

    begin
        if GetAccessToken() then begin
            ltItem.GET(pItemNo);
            ltItem.CalcFields(Inventory);
            CLEAR(PayloadOutStream);
            CLEAR(PayloadInStream);
            CLEAR(gvResponseText);

            if not ltdefaultdimension.GET(Database::Item, ltItem."No.", 'BRAND') then
                ltdefaultdimension.init();
            Tempblob.CreateOutStream(PayloadOutStream, TextEncoding::UTF8);
            DataText := '<Request>';
            DataText := DataText + '<Product>';
            DataText := DataText + STRSUBSTNO('<PrimaryCategory>%1</PrimaryCategory>', 10002019);
            DataText := DataText + STRSUBSTNO('<SPUId>%1</SPUId>', '');
            DataText := DataText + STRSUBSTNO('<AssociatedSku>%1</AssociatedSku>', '');
            DataText := DataText + '<Attributes>';
            DataText := DataText + STRSUBSTNO('<name>%1</name>', ltItem.Description);
            DataText := DataText + STRSUBSTNO('<description>%1</description>', ltItem.Description);
            DataText := DataText + STRSUBSTNO('<brand>%1</brand>', ltdefaultdimension."Dimension Value Code");
            DataText := DataText + '</Attributes>';
            DataText := DataText + '<Skus>';
            DataText := DataText + '<Sku>';
            DataText := DataText + STRSUBSTNO('<SellerSku>%1</SellerSku>', ltItem.Description);
            DataText := DataText + STRSUBSTNO('<quantity>%1</quantity>', ltItem.Inventory);
            DataText := DataText + STRSUBSTNO('<price>%1</price>', DELCHR(format(ltItem."Lazada Price"), '=', ','));
            DataText := DataText + STRSUBSTNO('<package_length>%1</package_length>', 11);
            DataText := DataText + STRSUBSTNO('<package_height>%1</package_height>', 22);
            DataText := DataText + STRSUBSTNO('<package_weight>%1</package_weight>', 33);
            DataText := DataText + STRSUBSTNO('<package_width>%1</package_width>', 44);
            DataText := DataText + STRSUBSTNO('<package_content>%1</package_content>', ltItem.Description);
            DataText := DataText + '</Sku>';
            DataText := DataText + '</Skus>';
            DataText := DataText + '</Product>';
            PayloadOutStream.WriteText(DataText);
            TempBlob.CreateInStream(PayloadInStream, TextEncoding::UTF8);
            PayloadInStream.ReadText(ltPayload);
            gvtokenpath := StrSubstNo(CreateProductionSignTxt, gvLazadaSetup."Access Token", gvLazadaSetup."App Key", ltPayload, gvTimeStam);
            gvUrlAddress := StrSubstNo(CreateProductionPathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Access Token", GenerateSign(gvtokenpath), gvTimeStam, ltPayload);
            ConnectToLazada('POST', gvUrlAddress, ltJsonObject, ltJsonToken);
            ltJsonObject.get('$.data.item_id', ltJsonToken);
            ltItem."Lazada Item Id" := ltJsonToken.AsValue().AsText();
            ltJsonObject.SelectToken('sku_list', ltJsonToken);
            ltJsonArray := ltJsonToken.AsArray();
            ltJsonArray.GET(0, ltJsonToken);
            ltJsonObject.get('$.seller_sku', ltJsonToken);
            ltItem."Lazada Seller sku" := ltJsonToken.AsValue().AsText();
            ltJsonObject.get('$.shop_sku', ltJsonToken);
            ltItem."Lazada Shop sku" := ltJsonToken.AsValue().AsText();
            ltJsonObject.get('$.sku_id', ltJsonToken);
            ltItem."Lazada Sku id" := ltJsonToken.AsValue().AsText();
            ltItem.Modify();
        end;
    end;


    /// <summary>
    /// Remove Product.
    /// </summary>
    /// <param name="pITemNo">Code[30].</param>
    procedure "Remove Product"(pITemNo: Code[30])
    var
        ltItem: Record Item;
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltJsonArray: JsonArray;
        ltSkulit: Text;
        RemovePatchTxt: Label 'https://api.lazada.co.th/rest/product/remove?app_key=%2&access_token=%3&sign_method=sha256&sign=%4&seller_sku_list=%5', Locked = true;
        RemoveProductTxt: Label '/product/removeaccess_token%2app_key%3seller_sku_list%4', Locked = true;

    begin
        if GetAccessToken() then begin
            ltItem.get(pITemNo);
            ltSkulit := '[SkuId_' + ltItem."Lazada Item Id" + '_' + ltItem."Lazada Sku id" + ']';
            gvtokenpath := StrSubstNo(RemoveProductTxt, gvLazadaSetup."Access Token", gvLazadaSetup."App Key", ltSkulit);
            ltSkulit := ltSkulit.Replace('[', '%5B');
            ltSkulit := ltSkulit.Replace(']', '%5D');
            gvUrlAddress := StrSubstNo(RemovePatchTxt, gvLazadaSetup."App Key", gvLazadaSetup."Access Token", GenerateSign(gvtokenpath), ltSkulit);
            ConnectToLazada('POST', gvUrlAddress, ltJsonObject, ltJsonToken);
        end;

    end;
    /// <summary>
    /// UpdateProductQuantity.
    /// </summary>
    /// <param name="pItemNo">Code[30].</param>
    procedure UpdateProductQuantity(pItemNo: Code[30])
    var
        ltItem: Record Item;
        ltdefaultdimension: Record "Default Dimension";
        Tempblob: Codeunit "Temp Blob";
        DataText, ltPayload : Text[2048];
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltJsonArray: JsonArray;
        CreateProductionPathTxt: Label 'https://api.lazada.co.th/rest/product/price_quantity/update?app_key=%1&access_token=%2&sign_method=sha256&sign=%3&timestamp=%4&payload=%5', Locked = true;
        CreateProductionSignTxt: Label '/product/price_quantity/updateaccess_token%1app_key%2payload%3sign_methodsha256timestamp%4', Locked = true;
    begin
        if GetAccessToken() then begin
            ltItem.GET(pItemNo);
            ltItem.CalcFields(Inventory);
            CLEAR(PayloadOutStream);
            CLEAR(PayloadInStream);
            CLEAR(gvResponseText);
            if not ltdefaultdimension.GET(Database::Item, ltItem."No.", 'BRAND') then
                ltdefaultdimension.init();
            Tempblob.CreateOutStream(PayloadOutStream, TextEncoding::UTF8);
            DataText := '<Request>';
            DataText := DataText + '<Product>';
            DataText := DataText + '<Skus>';
            DataText := DataText + '<Sku>';
            DataText := DataText + STRSUBSTNO('<ItemId>%1</ItemId>', ltItem."Lazada Item Id");
            DataText := DataText + STRSUBSTNO('<SkuId>%1</SkuId>', ltItem."Lazada Sku id");
            DataText := DataText + STRSUBSTNO('<SellerSku>%1</SellerSku>', ltItem."Lazada Seller sku");
            DataText := DataText + STRSUBSTNO('<SalePrice>%1</SalePrice>', DELCHR(format(ltItem."Lazada Price"), '=', ','));
            DataText := DataText + STRSUBSTNO('<Quantity>%1</Quantity>', ltItem.Inventory);
            DataText := DataText + STRSUBSTNO('<SaleStartDate>%1</SaleStartDate>', format(Today, 0, '<Year4>-<Month,2>-<Day,2>'));
            DataText := DataText + STRSUBSTNO('<SaleEndDate>%1</SaleEndDate>', format(Today, 0, '<Year4>-<Month,2>-<Day,2>'));
            DataText := DataText + '</Sku>';
            DataText := DataText + '</Skus>';
            DataText := DataText + '</Product>';
            DataText := DataText + '</Request>';
            PayloadOutStream.WriteText(DataText);
            TempBlob.CreateInStream(PayloadInStream, TextEncoding::UTF8);
            PayloadInStream.ReadText(ltPayload);
            gvtokenpath := StrSubstNo(CreateProductionSignTxt, gvLazadaSetup."Access Token", gvLazadaSetup."App Key", ltPayload, gvTimeStam);
            gvUrlAddress := StrSubstNo(CreateProductionPathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Access Token", GenerateSign(gvtokenpath), gvTimeStam, ltPayload);
            ConnectToLazada('POST', gvUrlAddress, ltJsonObject, ltJsonToken);
        end;
    end;

    /// <summary>
    /// Set Status Cancel.
    /// </summary>
    /// <param name="pOrderItemID">Code[50].</param>
    /// <param name="pRemark">Text[100].</param>
    procedure "Set Status Cancel"(pOrderItemID: Code[50]; pRemark: Text[100])
    var
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltfilter: Text;
        CreateProductionPathTxt: Label 'https://api.lazada.co.th/rest/order/cancel?app_key=%1&access_token=%2&sign_method=sha256&sign=%3&timestamp=%4%5', Locked = true;
        CreateProductionSignTxt: Label '/order/cancelaccess_token%1app_key%2order_item_id%3reason_detail%4reason_id15sign_methodsha256timestamp%5', Locked = true;
    begin
        if GetAccessToken() then begin
            ltfilter := '&order_item_id=' + pOrderItemID + '&reason_id=15' + '&reason_detail=' + pRemark;
            gvtokenpath := StrSubstNo(CreateProductionSignTxt, gvLazadaSetup."Access Token", gvLazadaSetup."App Key", pOrderItemID, pRemark, gvTimeStam);
            gvUrlAddress := StrSubstNo(CreateProductionPathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Access Token", GenerateSign(gvtokenpath), gvTimeStam, ltfilter);
            ConnectToLazada('POST', gvUrlAddress, ltJsonObject, ltJsonToken);
        end;
    end;


    /// <summary>
    /// Set Status Dropship.
    /// </summary>
    /// <param name="pOrderID">Code[30].</param>
    procedure "Set Status Dropship"(pOrderID: Code[30]; pOrderNo: Code[30])
    var
        ltSalesLine: Record "Sales Line";
        ltSalesHeader: Record "Sales Header";
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltorderitem, ltorderitem2, ltshipmentprovider, ltTrackingCode, TotalFilter : Text;
        SetStatusPathTxt: Label 'https://api.lazada.co.th/rest/order/rts?app_key=%1&access_token=%2&sign_method=sha256&sign=%3&timestamp=%4%5', Locked = true;
        SetStatusSignTxt: Label '/order/rtsaccess_token%1app_key%2delivery_typedropshiporder_item_ids%3shipment_provider%4sign_methodsha256tracking_number%5timestamp%6', Locked = true;
    begin
        if GetAccessToken() then begin
            ltorderitem2 := '';
            ltorderitem := '';
            ltshipmentprovider := '';
            ltTrackingCode := '';
            ltSalesLine.reset();
            ltSalesLine.SetRange("Document No.", pOrderNo);
            ltSalesLine.SetRange("Lazada Order ID", pOrderID);
            ltSalesLine.SetFilter("Lazada Order Item Id", '<>%1', '');
            if ltSalesLine.FindSet() then begin
                ltorderitem := '[';
                ltshipmentprovider := ltSalesLine."Lazada Shipment provider";
                ltTrackingCode := ltSalesLine."Lazada Tracking number";
                repeat
                    if ltorderitem2 <> '' then
                        ltorderitem2 := ltorderitem2 + ',';
                    ltorderitem2 := ltorderitem2 + ltSalesLine."Lazada Order Item Id";
                until ltSalesLine.next() = 0;
                ltorderitem := ltorderitem + ltorderitem2 + ']';
            end;
            TotalFilter := '&delivery_type=dropship&order_item_ids=' + ltorderitem + '&shipment_provider=' + ltshipmentprovider + '&tracking_number=' + ltTrackingCode;
            TotalFilter := TotalFilter.Replace('[', '%5B');
            TotalFilter := TotalFilter.Replace(']', '%5D');
            TotalFilter := TotalFilter.Replace(',', ' %2C');
            gvtokenpath := StrSubstNo(SetStatusSignTxt, gvLazadaSetup."Access Token", gvLazadaSetup."App Key", ltorderitem, ltshipmentprovider, ltTrackingCode, gvTimeStam);
            gvUrlAddress := StrSubstNo(SetStatusPathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Access Token", GenerateSign(gvtokenpath), gvTimeStam, TotalFilter);
            ConnectToLazada('POST', gvUrlAddress, ltJsonObject, ltJsonToken);
            ltSalesHeader.GET(ltSalesHeader."Document Type"::Order, pOrderNo);
            ltSalesHeader."Lazada Status" := 'Ready to Ship';
            ltSalesHeader.Modify();
        end;
    end;

    /// <summary>
    /// Set Status Package.
    /// </summary>
    /// <param name="pOrderID">Code[30].</param>
    procedure "Set Status Package"(pOrderID: Code[30]; pSalesOrderNo: Code[30])
    var
        ltSalesLine: Record "Sales Line";
        ltSalesHeader: Record "Sales Header";
        ltOrderItemID: Code[50];
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltJsonArray: JsonArray;
        ltorderitem, ltorderitem2, ltshippingprovider, TotalFilter : Text;
        SetStatusPathTxt: Label 'https://api.lazada.co.th/rest/order/pack?app_key=%1&access_token=%2&sign_method=sha256&sign=%3&timestamp=%4%5', Locked = true;
        SetStatusSignTxt: Label '/order/packaccess_token%1app_key%2delivery_typedropshiporder_item_ids%3shipping_provider%4sign_methodsha256timestamp%5', Locked = true;
    begin
        if GetAccessToken() then begin
            ltorderitem2 := '';
            ltorderitem := '';
            ltshippingprovider := '';
            ltSalesLine.reset();
            ltSalesLine.SetRange("Document No.", pSalesOrderNo);
            ltSalesLine.SetRange("Lazada Order ID", pOrderID);
            ltSalesLine.SetFilter("Lazada Order Item Id", '<>%1', '');
            if ltSalesLine.FindSet() then begin
                ltorderitem := '[';
                ltshippingprovider := ltSalesLine."Lazada Shipment provider";
                repeat
                    if ltorderitem2 <> '' then
                        ltorderitem2 := ltorderitem2 + ',';
                    ltorderitem2 := ltorderitem2 + ltSalesLine."Lazada Order Item Id";
                until ltSalesLine.next() = 0;
                ltorderitem := ltorderitem + ltorderitem2 + ']';
            end;
            TotalFilter := '&delivery_type=dropship&order_item_ids=' + ltorderitem + '&shipping_provider=' + ltshippingprovider;
            TotalFilter := TotalFilter.Replace('[', '%5B');
            TotalFilter := TotalFilter.Replace(']', '%5D');
            TotalFilter := TotalFilter.Replace(',', ' %2C');
            gvtokenpath := StrSubstNo(SetStatusSignTxt, gvLazadaSetup."Access Token", gvLazadaSetup."App Key", ltorderitem, ltshippingprovider, gvTimeStam);
            gvUrlAddress := StrSubstNo(SetStatusPathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Access Token", GenerateSign(gvtokenpath), gvTimeStam, TotalFilter);
            ConnectToLazada('POST', gvUrlAddress, ltJsonObject, ltJsonToken);
            ltSalesHeader.GET(ltSalesHeader."Document Type"::Order, pSalesOrderNo);
            ltSalesHeader."Lazada Status" := 'Package';
            ltSalesHeader.Modify();
            ltJsonObject.SelectToken('order_items', ltJsonToken);
            ltJsonArray := ltJsonToken.AsArray();
            for myLoop := 0 to ltJsonArray.Count - 1 do begin
                ltJsonArray.Get(myLoop, ltJsonToken);
                ltJsonObject.get('$.order_item_id', ltJsonToken);
                ltOrderItemID := ltJsonToken.AsValue().AsText();
                ltSalesLine.reset();
                ltSalesLine.SetRange("Document No.", pSalesOrderNo);
                ltSalesLine.SetRange("Lazada Order ID", pOrderID);
                ltSalesLine.SetRange("Lazada Order Item Id", ltOrderItemID);
                if ltSalesLine.FindSet() then begin
                    repeat
                        ltJsonObject.get('$.tracking_number', ltJsonToken);
                        ltSalesLine."Lazada Tracking number" := ltJsonToken.AsValue().AsText();
                        ltJsonObject.get('$.shipment_provider', ltJsonToken);
                        ltSalesLine."Lazada Shipment provider" := ltJsonToken.AsValue().AsText();
                        ltJsonObject.get('$.package_id', ltJsonToken);
                        ltSalesLine."Lazada Package id" := ltJsonToken.AsValue().AsText();
                        ltSalesLine.Modify();
                    until ltSalesLine.Next() = 0;
                end;
            end;
        end;
    end;

    /// <summary>
    /// Set Status Delivered.
    /// </summary>
    /// <param name="pOrderID">Code[30].</param>
    procedure "Set Status Delivered"(pOrderID: Code[30]; pSalesOrderNo: Code[30])
    var
        ltSalesLine: Record "Sales Line";
        ltSalesHeader: Record "Sales Header";
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltorderitem, ltorderitem2, TotalFilter : Text;
        SetStatusPathTxt: Label 'https://api.lazada.co.th/rest/order/sof/delivered?app_key=%1&access_token=%2&sign_method=sha256&sign=%3&timestamp=%4%5', Locked = true;
        SetStatusSignTxt: Label '/order/sof/deliveredaccess_token%1app_key%2order_item_ids%3sign_methodsha256timestamp%4', Locked = true;
    begin
        if GetAccessToken() then begin
            ltorderitem2 := '';
            ltorderitem := '';
            ltSalesLine.reset();
            ltSalesLine.SetRange("Document No.", pSalesOrderNo);
            ltSalesLine.SetRange("Lazada Order ID", pOrderID);
            ltSalesLine.SetFilter("Lazada Order Item Id", '<>%1', '');
            if ltSalesLine.FindSet() then begin
                ltorderitem := '[';
                repeat
                    if ltorderitem2 <> '' then
                        ltorderitem2 := ltorderitem2 + ',';
                    ltorderitem2 := ltorderitem2 + ltSalesLine."Lazada Order Item Id";
                until ltSalesLine.next() = 0;
                ltorderitem := ltorderitem + ltorderitem2 + ']';
            end;
            TotalFilter := '&order_item_ids=' + ltorderitem;
            TotalFilter := TotalFilter.Replace('[', '%5B');
            TotalFilter := TotalFilter.Replace(']', '%5D');
            TotalFilter := TotalFilter.Replace(',', ' %2C');
            gvtokenpath := StrSubstNo(SetStatusSignTxt, gvLazadaSetup."Access Token", gvLazadaSetup."App Key", ltorderitem, gvTimeStam);
            gvUrlAddress := StrSubstNo(SetStatusPathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Access Token", GenerateSign(gvtokenpath), gvTimeStam, TotalFilter);
            ConnectToLazada('POST', gvUrlAddress, ltJsonObject, ltJsonToken);
            ltSalesHeader.GET(ltSalesHeader."Document Type"::Order, pSalesOrderNo);
            ltSalesHeader."Lazada Status" := 'Delivered';
            ltSalesHeader.Modify();
        end;
    end;

    /// <summary>
    /// Set Status FailedDelivered.
    /// </summary>
    /// <param name="pOrderID">Code[30].</param>
    procedure "Set Status FailedDelivered"(pOrderID: Code[30]; pSalesOrderNo: Code[30])
    var
        ltSalesLine: Record "Sales Line";
        ltSalesHeader: Record "Sales Header";
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltorderitem, ltorderitem2, TotalFilter : Text;
        SetStatusPathTxt: Label 'https://api.lazada.co.th/rest/order/sof/failed_delivery?app_key=%1&access_token=%2&sign_method=sha256&sign=%3&timestamp=%4%5', Locked = true;
        SetStatusSignTxt: Label '/order/sof/failed_deliveryaccess_token%1app_key%2order_item_ids%3sign_methodsha256timestamp%4', Locked = true;
    begin
        if GetAccessToken() then begin
            ltorderitem2 := '';
            ltorderitem := '';
            ltSalesLine.reset();
            ltSalesLine.SetRange("Document No.", pSalesOrderNo);
            ltSalesLine.SetRange("Lazada Order ID", pOrderID);
            ltSalesLine.SetFilter("Lazada Order Item Id", '<>%1', '');
            if ltSalesLine.FindSet() then begin
                ltorderitem := '[';
                repeat
                    if ltorderitem2 <> '' then
                        ltorderitem2 := ltorderitem2 + ',';
                    ltorderitem2 := ltorderitem2 + ltSalesLine."Lazada Order Item Id";
                until ltSalesLine.next() = 0;
                ltorderitem := ltorderitem + ltorderitem2 + ']';
            end;
            TotalFilter := '&order_item_ids=' + ltorderitem;
            TotalFilter := TotalFilter.Replace('[', '%5B');
            TotalFilter := TotalFilter.Replace(']', '%5D');
            TotalFilter := TotalFilter.Replace(',', ' %2C');
            gvtokenpath := StrSubstNo(SetStatusSignTxt, gvLazadaSetup."Access Token", gvLazadaSetup."App Key", ltorderitem, gvTimeStam);
            gvUrlAddress := StrSubstNo(SetStatusPathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Access Token", GenerateSign(gvtokenpath), gvTimeStam, TotalFilter);
            ConnectToLazada('POST', gvUrlAddress, ltJsonObject, ltJsonToken);
            ltSalesHeader.GET(ltSalesHeader."Document Type"::Order, pSalesOrderNo);
            ltSalesHeader."Lazada Status" := 'Failed Delivered';
            ltSalesHeader.Modify();
        end;
    end;
    /// <summary>
    /// Get Order.
    /// </summary>
    /// <param name="pOrder">Text[50].</param>
    /// <param name="pOrderFilter">Text[1024].</param>
    /// <param name="pSignPath">text[1024].</param>
    procedure "Get Order"(pOrder: Text[50]; pOrderFilter: Text[1024]; pSignPath: text[1024])
    var
        MappingFieldHeader: Record "Mapping Field Header";
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltJsonArray: JsonArray;
        GetOrderPathTxt: Label 'https://api.lazada.co.th/rest/%1/get?app_key=%2&access_token=%3&sign_method=sha256&sign=%4%5', Locked = true;
        GetOrderTxt: Label '/%1/getaccess_token%2app_key%3%4', Locked = true;
        MappingFieldErr: Label 'not found get order please check lazada mapping field table';
    begin
        if GetAccessToken() then begin
            MappingFieldHeader.reset();
            MappingFieldHeader.SetRange("Service Name", MappingFieldHeader."Service Name"::"Get Order");
            if MappingFieldHeader.IsEmpty then
                error(MappingFieldErr);


            pOrderFilter := pOrderFilter.Replace(':', '%3A');
            pOrderFilter := pOrderFilter.Replace('+', '%2B');
            pOrderFilter := pOrderFilter.Replace('[', '%5B');
            pOrderFilter := pOrderFilter.Replace(']', '%5D');
            pOrderFilter := pOrderFilter.Replace(',', ' %2C');
            gvtokenpath := StrSubstNo(GetOrderTxt, pOrder, gvLazadaSetup."Access Token", gvLazadaSetup."App Key", pSignPath);
            gvUrlAddress := StrSubstNo(GetOrderPathTxt, pOrder, gvLazadaSetup."App Key", gvLazadaSetup."Access Token", GenerateSign(gvtokenpath), pOrderFilter);
            ConnectToLazada('GET', gvUrlAddress, ltJsonObject, ltJsonToken);
            if pOrder = 'order' then begin
                ltJsonObject.SelectToken('data', ltJsonToken);
                InsertTransaction(ltJsonToken, MappingFieldHeader."Table ID")
            end else
                if pOrder = 'orders' then begin
                    ltJsonObject.SelectToken('orders', ltJsonToken);
                    ltJsonArray := ltJsonToken.AsArray();
                    for myLoop := 0 to ltJsonArray.Count - 1 do begin
                        ltJsonArray.Get(myLoop, ltJsonToken);
                        InsertTransaction(ltJsonToken, MappingFieldHeader."Table ID");
                    end;
                end;

        end;
    end;

    /// <summary>
    /// Get OrderItems.
    /// </summary>
    /// <param name="pOrderID">code[50].</param>
    /// <param name="pTableSubform">integer.</param>
    procedure "Get OrderItems"(pOrderID: code[50]; pTableSubform: integer)
    var
        MappingFieldHeader: Record "Mapping Field Header";
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltJsonArray: JsonArray;
        GetOrderItemsPathTxt: Label 'https://api.lazada.co.th/rest/order/items/get?app_key=%1&timestamp=%2&access_token=%3&sign_method=sha256&sign=%4&order_id=%5', Locked = true;
        GetOrderTxt: Label '/order/items/getaccess_token%1app_key%2order_id%3sign_methodsha256timestamp%4', Locked = true;
    begin

        if GetAccessToken() then begin
            gvtokenpath := StrSubstNo(GetOrderTxt, gvLazadaSetup."Access Token", gvLazadaSetup."App Key", pOrderID, gvTimeStam);
            gvUrlAddress := StrSubstNo(GetOrderItemsPathTxt, gvLazadaSetup."App Key", gvTimeStam, gvLazadaSetup."Access Token", GenerateSign(gvtokenpath), pOrderID);
            ConnectToLazada('GET', gvUrlAddress, ltJsonObject, ltJsonToken);
            ltJsonObject.SelectToken('data', ltJsonToken);
            ltJsonArray := ltJsonToken.AsArray();
            for myLoop := 0 to ltJsonArray.Count - 1 do begin
                ltJsonArray.Get(myLoop, ltJsonToken);
                InsertTransactionDetail(ltJsonToken, MappingFieldHeader."Table ID", pTableSubform);
            end;
        end;
    end;

    local procedure InsertTransaction(pJsonToken: JsonToken; pTableID: Integer)
    var
        MappingFieldLine: Record "Mapping Field Line";
        ltJsonObject: JsonObject;
        ltRecordRef: RecordRef;
        ltFieldRef: FieldRef;
        ltLoopField: Integer;
        test: Text;
    begin
        ltJsonObject := pJsonToken.AsObject();
        MappingFieldLine.reset();
        MappingFieldLine.SetCurrentKey("Table ID", Square, "Field ID");
        MappingFieldLine.SetRange("Table ID", pTableID);
        MappingFieldLine.SetFilter("Mapping Field Name", '<>%1', '');
        MappingFieldLine.SetRange("Table Subfrom", 0);
        if MappingFieldLine.FindSet() then begin
            ltRecordRef.Open(MappingFieldLine."Table ID");
            ltRecordRef.Init();
            repeat
                ltFieldRef := ltRecordRef.FIELD(MappingFieldLine."Field ID");
                ltFieldRef.Value := SelectJsonToken(ltJsonObject, '$.' + MappingFieldLine."Mapping Field Name");
            until MappingFieldLine.Next() = 0;
            ltRecordRef.Insert(true);
            ltRecordRef.Close();
            //if have Detail
            MappingFieldLine.reset();
            MappingFieldLine.SetCurrentKey("Table ID", Square, "Field ID");
            MappingFieldLine.SetRange("Table ID", pTableID);
            MappingFieldLine.SetFilter("Mapping Field Name", '<>%1', '');
            MappingFieldLine.SetFilter("Table Subfrom", '<>%1', 0);
            if MappingFieldLine.FindSet() then
                "Get OrderItems"(SelectJsonToken(ltJsonObject, '$.order_id'), MappingFieldLine."Table Subfrom");
        end;
    end;

    local procedure InsertTransactionDetail(pJsonToken: JsonToken; pTableID: Integer; pTablesubform: Integer)
    var
        MappingFieldLine: Record "Mapping Field Line";
        ltJsonObject: JsonObject;
        ltRecordRef: RecordRef;
        ltFieldRef: FieldRef;
        ltLoopField: Integer;
        test: Text;
    begin
        ltJsonObject := pJsonToken.AsObject();
        MappingFieldLine.reset();
        MappingFieldLine.SetCurrentKey("Table ID", Square, "Field ID");
        MappingFieldLine.SetRange("Table ID", pTableID);
        MappingFieldLine.SetFilter("Mapping Field Name", '<>%1', '');
        MappingFieldLine.SetRange("Table Subfrom", pTablesubform);
        if MappingFieldLine.FindSet() then begin
            ltRecordRef.Open(MappingFieldLine."Table ID");
            ltRecordRef.Init();
            repeat
                ltFieldRef := ltRecordRef.FIELD(MappingFieldLine."Field ID");
                ltFieldRef.Value := SelectJsonToken(ltJsonObject, '$.' + MappingFieldLine."Mapping Field Name");
            until MappingFieldLine.Next() = 0;
            ltRecordRef.Insert(true);
            ltRecordRef.Close();
        end;
    end;

    local procedure SelectJsonToken(JsonObject: JsonObject; Path: text): text;
    var
        ltJsonToken: JsonToken;
    begin
        if not JsonObject.SelectToken(Path, ltJsonToken) then
            exit('');
        if ltJsonToken.AsValue.IsNull then
            exit('');
        exit(ltJsonToken.asvalue.astext());
    end;

    local procedure ConnectToLazada(pMethod: Code[30]; pBaseUrl: Text; var pJsonObject: JsonObject; var pJsonToken: JsonToken)
    var
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltJsonArray: JsonArray;
    begin
        CLEAR(gvHttpRequestMessage);
        CLEAR(gvHttpClient);
        CLEAR(gvHttpResponseMessage);
        CLEAR(gvResponseText);
        gvHttpRequestMessage.Content := gvHttpContent;
        gvHttpRequestMessage.SetRequestUri(pBaseUrl);
        gvHttpRequestMessage.Method := pMethod;
        gvHttpClient.Send(gvHttpRequestMessage, gvHttpResponseMessage);
        gvHttpResponseMessage.Content.ReadAs(gvResponseText);
        if (gvHttpResponseMessage.IsSuccessStatusCode() AND (gvHttpResponseMessage.HttpStatusCode = 200)) then begin
            ltJsonToken.ReadFrom(gvResponseText);
            ltJsonObject := ltJsonToken.AsObject();
            if ltJsonObject.get('type', ltJsonToken) then
                if ltJsonToken.AsValue().AsText() = 'ISV' then begin
                    ltJsonObject.get('message', ltJsonToken);
                    Message('%1', ltJsonToken.AsValue().AsText());
                    error('');
                end;
            pJsonObject := ltJsonObject;
            pJsonToken := ltJsonToken;
        end else
            ERROR(LastMessageErr, GETLASTERRORTEXT);
    end;
    /// <summary>
    /// SetTimeStamp.
    /// </summary>
    /// <param name="pTimeStamp">BigInteger.</param>
    procedure SetTimeStamp(pTimeStamp: BigInteger)
    begin
        gvTimeStam := pTimeStamp;
    end;
    /// <summary>
    /// ConfirmBeforGetAPI.
    /// </summary>
    procedure ConfirmBeforGetAPI()
    var
        ConfirmLazada: Page "Lazada Confirm Dialog";
    begin
        CLEAR(confirmLazada);
        ConfirmLazada.RunModal();
        Clear(confirmLazada);
    end;


    var
        gvLazadaSetup: Record "Lazada Setup Entry";
        gvHttpClient: HttpClient;
        gvHttpContent: HttpContent;
        gvHttpHeadersContent: HttpHeaders;
        gvHttpRequestMessage: HttpRequestMessage;
        gvHttpResponseMessage: HttpResponseMessage;
        PayloadOutStream: OutStream;
        PayloadInStream: InStream;
        gvTimeStam: BigInteger;
        gvResponseText, gvUrlAddress, gvtokenpath : Text;
        myLoop: Integer;

        AccessTokenpathTxt: Label '/auth/token/createapp_key%1code%2sign_methodsha256timestamp%3', Locked = true;
        refreshpathTxt: Label '/auth/token/refreshapp_key%1refresh_token%2sign_methodsha256timestamp%3', Locked = true;
        LastMessageErr: Label 'Error Connection :%1', Locked = true;

}
