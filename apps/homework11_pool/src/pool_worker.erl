-module(pool_worker).
-author("Serhii Melnyk").
-behaviour(gen_server).

-export([test/3]).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, 
         handle_info/2, code_change/3, terminate/2]).

test(Mod, Fun, Args) ->
  gen_server:call(?MODULE, {exec, Mod, Fun, Args}).

start_link() ->
  gen_server:start_link(?MODULE, [], []).

init(_Args) ->
  {ok, {}}.

handle_call({exec, Mod, Fun, Args}, _From, State) ->
  {reply, apply(Mod, Fun, Args), State}.

handle_cast(_Msg, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.