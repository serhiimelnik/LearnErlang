-module(pool_worker).
-author("Serhii Melnyk").
-behaviour(gen_server).

-export([test/1]).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, 
         handle_info/2, code_change/3, terminate/2]).

-record(state, {counter}).

test(F) ->
  gen_server:call(?MODULE, {F}).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([S]) ->
  {ok, S}.

handle_call({F}, _From, S) ->
  F,
  {reply, S, S}.

handle_cast(_Msg, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.