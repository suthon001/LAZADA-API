/// <summary>
/// Codeunit API Func (ID 50100).
/// </summary>
codeunit 50100 "API Func"
{
    /// <summary>
    /// GetToken.
    /// </summary>
    procedure "GetAccessToken"()
    var
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltJsonArray: JsonArray;
        generatetokenTxt: Label 'https://api.lazada.com/rest/auth/token/create?code=%1&app_key=%2&timestamp=%3&sign_method=sha256&sign=%4', Locked = true;
    begin
        ClearHTTWebRequest();
        GetLazadaSetup();
        if gvLazadaSetup."Refresh Token" <> '' then
            RefreshAccessToken()
        else begin
            gvtokenpath := StrSubstNo(AccessTokenpathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Seller Code", gvTimeStam);
            gvUrlAddress := StrSubstNo(generatetokenTxt, gvLazadaSetup."Seller Code", gvLazadaSetup."App Key", gvTimeStam, GenerateSign(gvtokenpath));
            gvHttpRequestMessage.SetRequestUri(gvUrlAddress);
            gvHttpRequestMessage.Method := 'GET';
            gvHttpClient.Send(gvHttpRequestMessage, gvHttpResponseMessage);
            gvHttpResponseMessage.Content.ReadAs(gvResponseText);
            ltJsonToken.ReadFrom(gvResponseText);
            ltJsonObject := ltJsonToken.AsObject();
            if (gvHttpResponseMessage.IsSuccessStatusCode() AND (gvHttpResponseMessage.HttpStatusCode = 200)) then begin
                ltJsonToken.ReadFrom(gvResponseText);
                ltJsonObject := ltJsonToken.AsObject();
                if ltJsonObject.get('type', ltJsonToken) then
                    if ltJsonToken.AsValue().AsText() = 'ISV' then begin
                        ltJsonObject.get('message', ltJsonToken);
                        Message('%1', ltJsonToken.AsValue().AsText());
                        exit;
                    end;
                ltJsonObject.get('access_token', ltJsonToken);
                gvLazadaSetup."Access Token" := ltJsonToken.AsValue().AsText();
                ltJsonObject.get('refresh_token', ltJsonToken);
                gvLazadaSetup."Refresh Token" := ltJsonToken.AsValue().AsText();
                gvLazadaSetup.Modify();
                Commit();
            end else
                ERROR(LastMessageErr, GETLASTERRORTEXT);
        end;
        ClearHTTWebRequest();
    end;

    local procedure RefreshAccessToken()
    var
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltJsonArray: JsonArray;
        generatetokenTxt: Label 'https://api.lazada.com/rest/auth/token/refresh?refresh_token=%1&app_key=%2&timestamp=%3&sign_method=sha256&sign=%4', Locked = true;
    begin
        GetLazadaSetup();
        gvLazadaSetup.TestField("Refresh Token");
        gvtokenpath := StrSubstNo(refreshpathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Refresh Token", gvTimeStam);
        gvUrlAddress := StrSubstNo(generatetokenTxt, gvLazadaSetup."Refresh Token", gvLazadaSetup."App Key", gvTimeStam, GenerateSign(gvtokenpath));
        gvHttpRequestMessage.SetRequestUri(gvUrlAddress);
        gvHttpRequestMessage.Method := 'GET';
        gvHttpClient.Send(gvHttpRequestMessage, gvHttpResponseMessage);
        gvHttpResponseMessage.Content.ReadAs(gvResponseText);
        if (gvHttpResponseMessage.IsSuccessStatusCode() AND (gvHttpResponseMessage.HttpStatusCode = 200)) then begin
            ltJsonToken.ReadFrom(gvResponseText);
            ltJsonObject := ltJsonToken.AsObject();
            if ltJsonObject.get('type', ltJsonToken) then
                if ltJsonToken.AsValue().AsText() = 'ISV' then begin
                    ltJsonObject.get('message', ltJsonToken);
                    Message('%1', ltJsonToken.AsValue().AsText());
                    exit;
                end;
            ltJsonObject.get('access_token', ltJsonToken);
            gvLazadaSetup."Access Token" := ltJsonToken.AsValue().AsText();
            ltJsonObject.get('refresh_token', ltJsonToken);
            gvLazadaSetup."Refresh Token" := ltJsonToken.AsValue().AsText();
            gvLazadaSetup.Modify();
            Commit();
        end else
            ERROR(LastMessageErr, GETLASTERRORTEXT);
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
        ltItem.GET(pItemNo);
        ltItem.CalcFields(Inventory);
        CLEAR(PayloadOutStream);
        CLEAR(PayloadInStream);
        CLEAR(gvResponseText);
        GetAccessToken();
        GetLazadaSetup();
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
        gvHttpRequestMessage.Content := gvHttpContent;
        gvHttpRequestMessage.SetRequestUri(gvUrlAddress);
        gvHttpRequestMessage.Method := 'POST';
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
        end else
            ERROR(LastMessageErr, GETLASTERRORTEXT);

    end;

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
        CreateProductionSignTxt: Label '/product/price_quantity/updatecreateaccess_token%1app_key%2payload%3sign_methodsha256timestamp%4', Locked = true;
    begin

        ltItem.GET(pItemNo);
        ltItem.CalcFields(Inventory);
        CLEAR(PayloadOutStream);
        CLEAR(PayloadInStream);
        CLEAR(gvResponseText);
        GetAccessToken();
        GetLazadaSetup();
        if not ltdefaultdimension.GET(Database::Item, ltItem."No.", 'BRAND') then
            ltdefaultdimension.init();
        Tempblob.CreateOutStream(PayloadOutStream, TextEncoding::UTF8);
        DataText := '<Request>';
        DataText := DataText + '<Product>';
        DataText := DataText + '<Skus>';
        DataText := DataText + '<Sku>';
        DataText := DataText + STRSUBSTNO('<ItemId>%1</ItemId>', ltItem."Lazada Item Id");
        DataText := DataText + STRSUBSTNO('<SkuId>%1</SkuId>', ltItem.Inventory);
        DataText := DataText + STRSUBSTNO('<SellerSku>%1</SellerSku>', DELCHR(format(ltItem."Unit Price"), '=', ','));
        DataText := DataText + STRSUBSTNO('<SalePrice>%1</SalePrice>', 1000);
        DataText := DataText + STRSUBSTNO('<Quantity>%1</Quantity>', 50);
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
        gvHttpRequestMessage.Content := gvHttpContent;
        gvHttpRequestMessage.SetRequestUri(gvUrlAddress);
        gvHttpRequestMessage.Method := 'POST';
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
        end else
            ERROR(LastMessageErr, GETLASTERRORTEXT);
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
    begin
        MappingFieldHeader.reset();
        MappingFieldHeader.SetRange("Service Name", MappingFieldHeader."Service Name"::"Get Order");
        if MappingFieldHeader.IsEmpty then
            EXIT;

        GetAccessToken();
        GetLazadaSetup();
        pOrderFilter := pOrderFilter.Replace(':', '%3A');
        pOrderFilter := pOrderFilter.Replace('+', '%2B');
        pOrderFilter := pOrderFilter.Replace('[', '%5B');
        pOrderFilter := pOrderFilter.Replace(']', '%5D');
        pOrderFilter := pOrderFilter.Replace(',', ' %2C+');
        gvtokenpath := StrSubstNo(GetOrderTxt, pOrder, gvLazadaSetup."Access Token", gvLazadaSetup."App Key", pSignPath);
        gvUrlAddress := StrSubstNo(GetOrderPathTxt, pOrder, gvLazadaSetup."App Key", gvLazadaSetup."Access Token", GenerateSign(gvtokenpath), pOrderFilter);
        gvHttpRequestMessage.SetRequestUri(gvUrlAddress);
        gvHttpRequestMessage.Method := 'GET';
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
        end else
            ERROR(LastMessageErr, GETLASTERRORTEXT);
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

        GetAccessToken();
        GetLazadaSetup();
        gvtokenpath := StrSubstNo(GetOrderTxt, gvLazadaSetup."Access Token", gvLazadaSetup."App Key", pOrderID, gvTimeStam);
        gvUrlAddress := StrSubstNo(GetOrderItemsPathTxt, gvLazadaSetup."App Key", gvTimeStam, gvLazadaSetup."Access Token", GenerateSign(gvtokenpath), pOrderID);
        gvHttpRequestMessage.SetRequestUri(gvUrlAddress);
        gvHttpRequestMessage.Method := 'GET';
        gvHttpClient.Send(gvHttpRequestMessage, gvHttpResponseMessage);
        gvHttpResponseMessage.Content.ReadAs(gvResponseText);
        ltJsonToken.ReadFrom(gvResponseText);
        ltJsonObject := ltJsonToken.AsObject();
        ltJsonObject.SelectToken('data', ltJsonToken);
        ltJsonArray := ltJsonToken.AsArray();
        for myLoop := 0 to ltJsonArray.Count - 1 do begin
            ltJsonArray.Get(myLoop, ltJsonToken);
            InsertTransactionDetail(ltJsonToken, MappingFieldHeader."Table ID", pTableSubform);
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

    local procedure ClearHTTWebRequest()
    begin
        CLEAR(gvHttpRequestMessage);
        CLEAR(gvHttpClient);
        CLEAR(gvHttpResponseMessage);
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
