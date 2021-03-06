defmodule CWMP.Protocol.GenerateHelpers do
  import XmlBuilder

  defmacro __using__(_opts) do
    quote do
      import CWMP.Protocol.GenerateHelpers
    end
  end


  @moduledoc """

  A helper module for generating various bits of
  XML or other stings for the Generator modules.

  """

  @doc """

  Generates the XML for a FaultStruct used in TransferComplete and AutonomousTransferComplete and
  which ever other requests that include a FaultStruct. The 'fault' parameter is a types/fault_struct.ex
  type.

  """
  def faultStruct( fault ) do
    element( :FaultStruct, [ element( :FaultCode, fault.code ), element( :FaultString, fault.string ) ] )
  end

  @doc """

  Generates a string that represents the timestructure. If the timestructure given is
  somehow invalid, the default is used to generate a timestring. For Inform that would
  be today. For TransferComplete and others that have epoch as the default value, that is
  used.

  """
  @spec timeString( DateTime.t, DateTime.t ) :: String.t
  def timeString( timestruct, default \\ DateTime.from_unix!(0) ) do
    try do
      case timestruct do
        nil ->
          DateTime.to_iso8601(default)
        _ ->
          DateTime.to_iso8601(timestruct)
      end
    rescue
      _ ->
        DateTime.to_iso8601(default)
    end
  end

  @doc """

  Translates a boolean value to "0" or "1"

  """
  def boolValue(b) when is_boolean(b) do
    case b do
      false -> "0"
      _ -> 1
    end
  end

  def boolValue(i) when is_integer(i) do
    case i do
      0 -> "0"
      _ -> 1
    end
  end

  def boolValue(_s) do
    raise "Not a boolean value"
  end

  @doc """

  Ensures that the passed value is an integer and that it satisfies
  the restraints layed out by the anon function passed.

  """
  def integerValue(i, fun \\ fn(x) -> x end)

  def integerValue(i, fun) when is_integer( i ) do
    if fun.(i) do
      i
    else
      raise "Integer does not validate"
    end
  end

  def integerValue(i, fun) do
    case Integer.parse(i) do
      {v,""} -> if fun.(v) do
                  v
                else
                  raise "Integer does not validate"
                end
      _ -> raise "Integer value does not parse"
    end
  end

end
