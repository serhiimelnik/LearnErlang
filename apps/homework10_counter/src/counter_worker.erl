-module(counter_worker).
-author("Serhii Melnyk").
-behaviour(gen_server).

-export([get/0, up/0, up/1]).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, 
         handle_info/2, code_change/3, terminate/2]).

-record(state, {counter}).

get() ->
  gen_server:call(?MODULE, {get}).

up() -> up(1).
up(Incr) ->
  gen_server:call(?MODULE, {up, Incr}).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
  {ok, #state{counter = 0}}.

handle_call({get}, _From, State = #state{counter = Counter}) ->
  {reply, Counter, State};
handle_call({up, Incr}, _From, State = #state{counter = Counter}) ->
  NewCounter = Counter + Incr,
  {reply, NewCounter, State#state{counter = NewCounter}}.

handle_cast(_Msg, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%% format_status(_Opt, Status) ->
%%   Status.