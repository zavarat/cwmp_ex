defmodule CWMP.Protocol.Generator.RequestDownloadTest do
  use ExUnit.Case, async: true

  @sample ~s|<SOAP-ENV:Envelope xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cwmp="urn:dslforum-org:cwmp-1-4" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
\t<SOAP-ENV:Header>
\t\t<cwmp:ID SOAP-ENV:mustUnderstand="1">API_69412286f02e475b44783c61972f0a91</cwmp:ID>
\t</SOAP-ENV:Header>
\t<SOAP-ENV:Body>
\t\t<cwmp:RequestDownload>
\t\t\t<FileType>2 Web Content</FileType>
\t\t\t<FileTypeArg SOAP-ENC:arrayType="cwmp:ArgStruct[1]">
\t\t\t\t<ArgStruct>
\t\t\t\t\t<Name>Version</Name>
\t\t\t\t\t<Value>v2.0</Value>
\t\t\t\t</ArgStruct>
\t\t\t</FileTypeArg>
\t\t</cwmp:RequestDownload>
\t</SOAP-ENV:Body>
</SOAP-ENV:Envelope>|

  test "generates RequestDownload request" do
    assert(CWMP.Protocol.Generator.generate!(
      %CWMP.Protocol.Messages.Header{id: "API_69412286f02e475b44783c61972f0a91"},
      %CWMP.Protocol.Messages.RequestDownload{
        filetype: "2 Web Content",
        filetype_arg: [
          %CWMP.Protocol.Messages.ArgStruct{
            name: "Version",
            value: "v2.0"}
        ]}) == @sample)
  end

end
