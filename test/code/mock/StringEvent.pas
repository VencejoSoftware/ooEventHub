{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit StringEvent;

interface

uses
  ooEventHub.Event;

type
  IStringEvent = interface(IEvent<String>)
    ['{E0863CE6-56CA-4DDF-ACED-46A166E8C902}']
  end;

  TStringEvent = class sealed(TInterfacedObject, IStringEvent)
  strict private
    _Event: IEvent<String>;
  public
    function ID: TEventID;
    function Content: String;
    function TimeStamp: TDateTime;
    constructor Create(const ID: TEventID; const Content: String);
    class function New(const ID: TEventID; const Content: String): IStringEvent;
  end;

implementation

function TStringEvent.ID: TEventID;
begin
  Result := _Event.ID;
end;

function TStringEvent.Content: String;
begin
  Result := _Event.Content;
end;

function TStringEvent.TimeStamp: TDateTime;
begin
  Result := _Event.TimeStamp;
end;

constructor TStringEvent.Create(const ID: TEventID; const Content: String);
begin
  _Event := TEvent<String>.New(ID, Content);
end;

class function TStringEvent.New(const ID: TEventID; const Content: String): IStringEvent;
begin
  Result := TStringEvent.Create(ID, Content);
end;

end.
