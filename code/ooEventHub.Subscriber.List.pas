{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Object to define a subscriber list
  @created(04/12/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooEventHub.Subscriber.List;

interface

uses
  SysUtils,
  Generics.Collections,
  ooEventHub.Subscriber;

type
{$REGION 'documentation'}
{
  @abstract(Object to define a subscriber list)
  @member(
    Exists Checks if a subscriber object exists in the list
    @param(Subscriber Subscriber object)
    @return(@true if subscriber exists, @false if not founded)
  )
  @member(
    Add Add a subscriber object into the list
    @param(Subscriber Subscriber object)
    @return(Index of list consumed for the object)
  )
  @member(
    Remove Remove a subscriber object from the list
    @param(Subscriber Subscriber object)
    @return(Index in list removed for the object)
  )
  @member(Count return the number of elements in the list)
  @member(
    Subscriber Return a subscriber item from his index in the list
    @param(Index Index of list)
    @return(Subscriber object)
  ) }
{$ENDREGION}
  ISubscriberList<T> = interface
    ['{9D79B003-9867-4078-908B-BB3D3973BB7A}']
    function Exists(const Subscriber: ISubscriber<T>): Boolean;
    function Add(const Subscriber: ISubscriber<T>): Integer;
    function Remove(const Subscriber: ISubscriber<T>): Integer;
    function Subscriber(const Index: Cardinal): ISubscriber<T>;
    function Count: Integer;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISubscriberList))
  @member(Exists @seealso(ISubscriberList.Exists))
  @member(Add @seealso(ISubscriberList.Add))
  @member(Remove @seealso(ISubscriberList.Remove))
  @member(Count @seealso(ISubscriberList.Count))
  @member(Subscriber @seealso(ISubscriberList.Subscriber))
  @member(Create Object constructor)
  @member(Destroy Object destructor)
  @member(New Create a new @classname as interface)
}
{$ENDREGION}

  TSubscriberList<T> = class sealed(TInterfacedObject, ISubscriberList<T>)
  strict private
  type
    _TSubscriberList = TList<ISubscriber<T>>;
  strict private
    _List: _TSubscriberList;
  public
    function Exists(const Subscriber: ISubscriber<T>): Boolean;
    function Add(const Subscriber: ISubscriber<T>): Integer;
    function Remove(const Subscriber: ISubscriber<T>): Integer;
    function Count: Integer;
    function Subscriber(const Index: Cardinal): ISubscriber<T>;
    constructor Create;
    destructor Destroy; override;
    class function New: ISubscriberList<T>;
  end;

implementation

function TSubscriberList<T>.Add(const Subscriber: ISubscriber<T>): Integer;
begin
  if Exists(Subscriber) then
    Result := -1
  else
    Result := _List.Add(Subscriber);
end;

function TSubscriberList<T>.Remove(const Subscriber: ISubscriber<T>): Integer;
begin
  if Exists(Subscriber) then
    Result := _List.Remove(Subscriber)
  else
    Result := -1;
end;

function TSubscriberList<T>.Subscriber(const Index: Cardinal): ISubscriber<T>;
begin
  Result := _List.Items[Index];
end;

function TSubscriberList<T>.Exists(const Subscriber: ISubscriber<T>): Boolean;
var
  Item: ISubscriber<T>;
begin
  Result := False;
  for Item in _List do
  begin
    Result := IsEqualGUID(Item.ID, Subscriber.ID);
    if Result then
      Break;
  end;
end;

function TSubscriberList<T>.Count: Integer;
begin
  Result := _List.Count;
end;

constructor TSubscriberList<T>.Create;
begin
  _List := _TSubscriberList.Create;
end;

destructor TSubscriberList<T>.Destroy;
begin
  _List.Free;
  inherited;
end;

class function TSubscriberList<T>.New: ISubscriberList<T>;
begin
  Result := TSubscriberList<T>.Create;
end;

end.
