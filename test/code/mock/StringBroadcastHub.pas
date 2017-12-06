{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit StringBroadcastHub;

interface

uses
  ooEventHub.BroadcastHub,
  ooEventHub.BroadcastHub.Filtered;

type
  IStringBroadcastHub = IBroadcastHub<String>;
  TStringBroadcastHub = TBroadcastHub<String>;
  TStringOnBroadcastFilter = TOnBroadcastFilter<String>;
  IStringBroadcastHubFiltered = IBroadcastHubFiltered<String>;
  TStringBroadcastHubFiltered = TBroadcastHubFiltered<String>;

implementation

end.
