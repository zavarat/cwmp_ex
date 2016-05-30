defmodule CWMP.Protocol.Parser.GetRPCMethodsTest do
  use ExUnit.Case, async: true

  @sample """
<SOAP-ENV:Envelope
    xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:cwmp="urn:dslforum-org:cwmp-1-0">
    <SOAP-ENV:Header>
      <cwmp:ID SOAP-ENV:mustUnderstand="1">API_aa0642e34b23820801e7642ad7cb536c</cwmp:ID>
    </SOAP-ENV:Header>
    <SOAP-ENV:Body>
      <cwmp:GetRPCMethodsResponse>
        <MethodList SOAP-ENC:arrayType="xsd:string[14]">
          <string>GetRPCMethods</string>
          <string>SetParameterValues</string>
          <string>GetParameterValues</string>
          <string>GetParameterNames</string>
          <string>GetParameterAttributes</string>
          <string>SetParameterAttributes</string>
          <string>AddObject</string>
          <string>DeleteObject</string>
          <string>Reboot</string>
          <string>Download</string>
          <string>Upload</string>
          <string>GetQueuedTransfers</string>
          <string>ScheduleInform</string>
          <string>FactoryReset</string>
        </MethodList>
      </cwmp:GetRPCMethodsResponse>
    </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
  """

  @sample_result %{entries: [%CWMP.Protocol.Messages.GetRPCMethodsResponse{
        methods: ["GetRPCMethods", "SetParameterValues", "GetParameterValues", "GetParameterNames", "GetParameterAttributes", "SetParameterAttributes", "AddObject", "DeleteObject", "Reboot", "Download", "Upload", "GetQueuedTransfers", "ScheduleInform", "FactoryReset"] }],
    header: %CWMP.Protocol.Messages.Header{hold_requests: false, id: "API_aa0642e34b23820801e7642ad7cb536c",
      session_timeout: 30, no_more_requests: false}}

  test "parses GetRPCMethodsResponse request" do
    assert(CWMP.Protocol.Parser.parse(@sample) == @sample_result)
  end

end