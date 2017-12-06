{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Object to define a path between events and subscribers
  @created(04/12/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooEventHub.Subscription.Path;

interface

uses
  Generics.Collections,
  ooEventHub.Event,
  ooEventHub.Subscriber.List;

type
{$REGION 'documentation'}
{
  @abstract(Object to define a path between events and subscribers)
  Use a dictionary to link events with subscribers (1..N)
  @member(
    SubscribersByID Get a list of subscribers under the event ID
    @param(ID Event identifier)
    @return(List for this event identifier, if the event ID not exist then create a new dictionary entry);
  )
  @member(Count return the number of elements in the list)
}
{$ENDREGION}
  ISubscriptionPath<T> = interface
    ['{CD282CD9-EAB5-430D-9F76-10B51E8E36E5}']
    function SubscribersByID(const ID: TEventID): ISubscriberList<T>;
    function Count: Integer;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISubscriptionPath))
  @member(SubscribersByID @seealso(ISubscriptionPath.SubscribersByID))
  @member(Count @seealso(ISubscriptionPath.Count))
  @member(Create Object constructor)
  @member(Destroy Object destructor)
  @member(New Create a new @classname as interface and make unique ID)
}
{$ENDREGION}

  TSubscriptionPath<T> = class sealed(TInterfacedObject, ISubscriptionPath<T>)
  strict private
  type
    _TDictionary = TObjectDictionary<TEventID, ISubscriberList<T>>;
  strict private
    _Dictionary: _TDictionary;
  public
    function SubscribersByID(const ID: TEventID): ISubscriberList<T>;
    function Count: Integer;
    constructor Create;
    destructor Destroy; override;
    class function New: ISubscriptionPath<T>;
  end;

implementation

function TSubscriptionPath<T>.SubscribersByID(const ID: TEventID): ISubscriberList<T>;
begin
  if _Dictionary.ContainsKey(ID) then
    Result := _Dictionary.Items[ID]
  else
  begin
    Result := TSubscriberList<T>.New;
    _Dictionary.Add(ID, Result);
  end;
end;

function TSubscriptionPath<T>.Count: Integer;
begin
  Result := _Dictionary.Count;
end;

constructor TSubscriptionPath<T>.Create;
begin
  _Dictionary := _TDictionary.Create([]);
end;

destructor TSubscriptionPath<T>.Destroy;
begin
  _Dictionary.Free;
  inherited;
end;

class function TSubscriptionPath<T>.New: ISubscriptionPath<T>;
begin
  Result := TSubscriptionPath<T>.Create;
end;

end.
