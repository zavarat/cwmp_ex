defmodule CWMP.Protocol.Generator.Messages.InformRequest do
  import XmlBuilder

  def generate(req) do
    ctime = case Timex.format(req.current_time, "%FT%T%:z", :strftime) do
      {:ok, timestr} -> timestr
      _ -> raise "Invalid time structure"
    end
    element('cwmp:Inform', [
      deviceId( req.device_id ),
      events( req.events ),
      element( :MaxEnvelopes, req.max_envelopes ),
      element( :CurrentTime, ctime ),
      element( :RetryCount, req.retry_count ),
      parameters( req.parameters )
    ])
  end

  defp deviceId( deviceid ) do
    element('DeviceId',[ element(:Manufacturer, deviceid.manufacturer),
                         element(:OUI, deviceid.oui),
                         element(:ProductClass, deviceid.product_class),
                         element(:SerialNumber, deviceid.serial_number) ])
  end

  defp events( informevents ) do
    eventlist=for e <- informevents, do: element( :EventStruct, [ element( :EventCode, e.code ), element( :CommandKey, e.command_key ) ] )
    element(:Event, %{'SOAP-ENC:arrayType': "cwmp:EventStruct[#{length(eventlist)}]"}, [eventlist])
  end

  defp parameters( parameterlist ) do
    plist=for p <- parameterlist, do: element( :ParameterValueStruct, [ element( :Name, p.name ), element( :Value, %{'xsi:type': p.type}, p.value ) ] )
    element(:ParameterList, %{'SOAP-ENC:arrayType': "cwmp:ParameterValueStruct[#{length(plist)}]"}, [plist])

  end

end

