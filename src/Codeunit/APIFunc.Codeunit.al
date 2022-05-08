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
        if gvLazadaSetup."Access Token" <> '' then
            RefreshAccessToken()
        else begin
            GetLazadaSetup();
            gvTimeStam := GetTimestamp(CurrentDateTime);
            gvtokenpath := StrSubstNo(AccessTokenpathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Seller Code", gvTimeStam);
            gvUrlAddress := StrSubstNo(generatetokenTxt, gvLazadaSetup."Seller Code", gvLazadaSetup."App Key", gvTimeStam, GenerateSign(gvtokenpath));
            gvHttpRequestMessage.SetRequestUri(gvUrlAddress);
            gvHttpRequestMessage.Method := 'GET';
            gvHttpClient.Send(gvHttpRequestMessage, gvHttpResponseMessage);
            gvHttpResponseMessage.Content.ReadAs(gvResponseText);
            ltJsonToken.ReadFrom(gvResponseText);
            ltJsonObject := ltJsonToken.AsObject();
            ltJsonObject.get('access_token', ltJsonToken);
            gvLazadaSetup."Access Token" := ltJsonToken.AsValue().AsText();
            ltJsonObject.get('refresh_token', ltJsonToken);
            gvLazadaSetup."Refresh Token" := ltJsonToken.AsValue().AsText();
            gvLazadaSetup.Modify();
        end;

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
        gvTimeStam := GetTimestamp(CurrentDateTime);
        gvtokenpath := StrSubstNo(refreshpathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Refresh Token", gvTimeStam);
        gvUrlAddress := StrSubstNo(generatetokenTxt, gvLazadaSetup."Refresh Token", gvLazadaSetup."App Key", gvTimeStam, GenerateSign(gvtokenpath));
        gvHttpRequestMessage.SetRequestUri(gvUrlAddress);
        gvHttpRequestMessage.Method := 'GET';
        gvHttpClient.Send(gvHttpRequestMessage, gvHttpResponseMessage);
        gvHttpResponseMessage.Content.ReadAs(gvResponseText);
        ltJsonToken.ReadFrom(gvResponseText);
        ltJsonObject := ltJsonToken.AsObject();
        ltJsonObject.get('access_token', ltJsonToken);
        gvLazadaSetup."Access Token" := ltJsonToken.AsValue().AsText();
        ltJsonObject.get('refresh_token', ltJsonToken);
        gvLazadaSetup."Refresh Token" := ltJsonToken.AsValue().AsText();
        gvLazadaSetup.Modify();
        Commit();
    end;

    LOCAL PROCEDURE GetTimestamp(dt: DateTime) UtcTime: BigInteger;
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

    local procedure GenerateSign(ptokenpath: Text[1024]): Text
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

    procedure "Get Order"()
    var
        MappingFieldHeader: Record "Mapping Field Header";
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltJsonArray: JsonArray;
        GetOrderPathTxt: Label 'https://api.lazada.co.th/rest/order/get?app_key=%1&timestamp=%2&access_token=%3&sign_method=sha256&sign=%4', Locked = true;
    begin
        MappingFieldHeader.reset();
        MappingFieldHeader.SetRange("Service Name", MappingFieldHeader."Service Name"::"Get Order");
        if not MappingFieldHeader.Find() then
            ERROR('');
        gvDateTime := CurrentDateTime();
        RefreshAccessToken();
        GetLazadaSetup();
        gvtokenpath := StrSubstNo(refreshpathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Refresh Token", gvTimeStam);
        gvUrlAddress := StrSubstNo(GetOrderPathTxt, gvLazadaSetup."App Key", gvTimeStam, gvLazadaSetup."Access Token", GenerateSign(gvtokenpath));
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
            InsertTransaction(ltJsonToken, MappingFieldHeader."Table ID");
        end;
    end;

    procedure "Get OrderItems"(pOrderID: code[50]; pTableSubform: integer)
    var
        MappingFieldHeader: Record "Mapping Field Header";
        ltJsonToken: JsonToken;
        ltJsonValue: JsonValue;
        ltJsonObject: JsonObject;
        ltJsonArray: JsonArray;
        GetOrderItemsPathTxt: Label 'https://api.lazada.co.th/rest/order/items/get?app_key=%1&timestamp=%2&access_token=%3&sign_method=sha256&sign=%4&order_id=%5', Locked = true;
    begin
        gvDateTime := CurrentDateTime();
        RefreshAccessToken();
        GetLazadaSetup();
        gvtokenpath := StrSubstNo(refreshpathTxt, gvLazadaSetup."App Key", gvLazadaSetup."Refresh Token", gvTimeStam);
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
            // Detail if have
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
        exit(ltJsonToken.asvalue.astext);
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
        gvDateTime: DateTime;
        AccessTokenpathTxt: Label '/auth/token/createapp_key%1code%2sign_methodsha256timestamp%3', Locked = true;
        refreshpathTxt: Label '/auth/token/refreshapp_key%1refresh_token%2sign_methodsha256timestamp%3', Locked = true;

}
