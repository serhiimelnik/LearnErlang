-module(trade_fsm).
-behaviour(gen_fsm).

%% public API
-export([start/1, start_link/1, trade/2, accept_trade/1,
        make_offer/2, retract_offer/2, ready/1, cancel/1]).

%% gen_fsm callbacks
-export([init/1, handle_event/3, handle_sunc_event/4, handle_info/3,
        terminate/3, code_change/4,
        %% custom state names
        idle/2, idle/3, idle_wait/2, idle_wait/3, negotiate/2,
        negotiate/3, wait/2, ready/2, ready/3]).

%%% PUBLIC API
start(Name) ->
  gen_fsm:start(?MODULE, [Name], []).

start_link(Name) ->
  gen_fsm:start_link(?MODULE, [Name], []).

%% asc for a begin session. Returns when/if the other accepts
trade(OwnPid, OtherPid) ->
  gen_fsm:sync_send_event(OwnPid, {negotiate, OtherPid}, 30000).

%% Accept someone's trade offer.
accept_trade(OwnPid) ->
  gen_fsm:sync_send_event(OwnPid, accept_negotiate).

%% Send an item on the table to the traded
make_offer(OwnPid, Item) ->
  gen_fsm:send_event(OwnPid, {make_offer, Item}).

%% Cancel trade offer
retract_offer(OwnPid, Item) ->
  gen_fsm:send_event(OwnPid, {retract_offer, Item}).

%% Mention that you're ready for a trade. When the offer
%% player also declares being ready, the trade is done
ready(OwnPid) ->
  gen_fsm:sync_send_event(OwnPid, ready, infinity).

%% Cancel the transaction
cancel(OwnPid) ->
  gen_fsm:sync_send_all_state_event(OwnPid, cancel).

%%% CLIENT TO CLIENT API
%% These calls are only listed for the gen_fsm to call
%% among themselves
%% All calls are asynchronous to avoid deadlocks


