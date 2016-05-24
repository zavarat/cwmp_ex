defmodule CWMP.Protocol.Parser.Messages.GetParameterValuesResponseRequest do

  use CWMP.Protocol.ParserHelpers
  alias CWMP.Protocol.Messages.GetParameterValuesResponse

  def initial_acc do
    %GetParameterValuesResponse{}
  end

  def start_element(state, ['ParameterValueStruct', 'ParameterList'], _attribs) do
    push_handler(state, ParameterValueStruct)
  end

  def end_element(state, ['ParameterValueStruct', 'ParameterList']) do
    update_acc(state, fn acc -> %GetParameterValuesResponse{acc | parameters: acc.parameters ++ [state.last_acc]} end)
  end
end

