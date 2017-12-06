{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Object to define a event subscriber
  @created(04/12/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooEventHub.Subscriber;

interface

uses
  SysUtils,
  ooEventHub.Event;

type
{$REGION 'documentation'}
// @abstract(Type to define a subscriber identifier)
{$ENDREGION}
  TSubscriberID = TGuid;
{$REGION 'documentation'}
{
  @abstract(Object to define a event subscriber)
  @member(ID Subscriber identifier)
  @member(
    HandleEvent Handle the received event
    @param(Event Event object received)
  )
}
{$ENDREGION}

  ISubscriber<T> = interface
    ['{12D6DFBA-BED2-4C15-845C-0D68AC7C094A}']
    function ID: TSubscriberID;
    procedure HandleEvent(const Event: IEvent<T>);
  end;

{$REGION 'documentation'}
// @abstract(Type to define a callback to referenced method)
{$ENDREGION}

  TSubscriberCalback<T> = reference to procedure(const Event: IEvent<T>);

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISubscriber))
  Subscriber with callback capacities
  @member(ID @seealso(ISubscriber.ID))
  @member(HandleEvent @seealso(ISubscriber.HandleEvent))
  @member(
    Create Object constructor
    @param(ID Subscriber identifier)
    @param(Callback Callback method as reference)
  )
  @member(
    New Create a new @classname as interface and make unique ID
    @param(Callback Callback method as reference)
  )
  @member(
    NewWithID Create a new @classname as interface
    @param(ID Subscriber identifier)
    @param(Callback Callback method as reference)
  )
}
{$ENDREGION}

  TSubscriber<T> = class sealed(TInterfacedObject, ISubscriber<T>)
  strict private
    _ID: TSubscriberID;
    _Callback: TSubscriberCalback<T>;
  public
    function ID: TSubscriberID;
    procedure HandleEvent(const Event: IEvent<T>);
    constructor Create(const ID: TSubscriberID; const Callback: TSubscriberCalback<T>);
    class function New(const Callback: TSubscriberCalback<T>): ISubscriber<T>;
    class function NewWithID(const ID: TSubscriberID; const Callback: TSubscriberCalback<T>): ISubscriber<T>;
  end;

implementation

function TSubscriber<T>.ID: TSubscriberID;
begin
  Result := _ID;
end;

procedure TSubscriber<T>.HandleEvent(const Event: IEvent<T>);
begin
  if Assigned(_Callback) then
    _Callback(Event);
end;

constructor TSubscriber<T>.Create(const ID: TSubscriberID; const Callback: TSubscriberCalback<T>);
begin
  _ID := ID;
  _Callback := Callback;
end;

class function TSubscriber<T>.New(const Callback: TSubscriberCalback<T>): ISubscriber<T>;
var
  ID: TGuid;
begin
  CreateGuid(ID);
  Result := TSubscriber<T>.Create(ID, Callback);
end;

class function TSubscriber<T>.NewWithID(const ID: TSubscriberID; const Callback: TSubscriberCalback<T>): ISubscriber<T>;
begin
  Result := TSubscriber<T>.Create(ID, Callback);
end;

end.
