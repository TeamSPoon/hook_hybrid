% File: /opt/PrologMUD/pack/logicmoo_base/prolog/logicmoo/util/hook_database.pl
:- module(hook_database,
          [ ain/1,
            ain0/1,
            aina/1,
            ainz/1,
            
            if_flag_true/2,
            current_module_from/2,
            attributes_equal/3,
            
          ereq/1,
          dbreq/1,
            
            is_visible_module/1,
            hb_to_clause/3,
            paina/1,pain/1,painz/1,
            modulize_head/2,
            remove_term_attr_type/2,
            ainz_clause/1,ainz_clause/2,
            simple_var/1,
            
            find_module/2,
            module_of/3,
            callable_module/2,
            expand_to_hb/3,
            assert_if_new/1,
            asserta_if_new/1,
            asserta_new/1,
            assertz_if_new/1,
            assertz_new/1,
            assert_setting/1,
            assert_setting_if_missing/1,
            call_provider/1,
            call_provider/2,
            clause_true/1,
            modulize_head_fb/4,
            clause_asserted/1,clause_asserted/2,clause_asserted/3,
            clause_asserted_i/1,clause_asserted_i/2,clause_asserted_i/3,
            clause_i/1,clause_i/2,clause_i/3,
            assert_i/1,asserta_i/1,assertz_i/1,
            retract_i/1,retractall_i/1,
            
            clause_safe/2,
            
            erase_safe/2,
            eraseall/2,
            find_and_call/1,
            somehow_callable/1,
            find_and_call/3,
            std_provider/3,
            mpred_mop/3,
            mpred_op_prolog/2,
            mpred_split_op_data/3,
            retract_eq/1,
            safe_univ/2,
            safe_univ0/2,
            my_module_sensitive_code/1
          ]).

:- meta_predicate clause_asserted_i(:).
:- set_module(class(library)).

:- meta_predicate
        ain(:),
        ain0(:),
        pain(:),
        paina(:),
        painz(:),
        aina(:),
        ainz(:),
        ainz_clause(:),
        ainz_clause(:, ?),
        expand_to_hb(?, ?, ?),
        assert_if_new(:),
        asserta_if_new(:),
        asserta_new(:),
        assertz_if_new(:),
        call_provider(0),
        clause_asserted(:),
        clause_asserted(:, ?),
        clause_asserted(:, ?, -),
        clause_safe(?, ?),
        eraseall(+, +),
        find_and_call(*),
        find_and_call(+, +, ?),
        module_of(+,+,?),
        callable_module(:,-),
        find_module(+, ?),
        mpred_mop(+, 1, ?),
        mpred_op_prolog(?, :),
        mpred_op_prolog0(1,?),
        my_module_sensitive_code(?).

:- module_transparent
         find_module/2,
         module_of/3,
         callable_module/2,
            
        
        modulize_head/2,
        modulize_head_fb/4,
        my_module_sensitive_code/1,
        assertz_new/1,
        call_provider/2,
        
        is_visible_module/1,
        clause_asserted/3,
        erase_safe/2,
        current_module_from/2,
        find_and_call/1,
        baseKB:first_std_provider/3,
        std_provider/3,
        mpred_split_op_data/3,
        retract_eq/1,
        safe_univ/2,
        clause_asserted/1,clause_asserted/2,clause_asserted/3,
        safe_univ0/2.


:- module_transparent
         ain/1,
            ain0/1,
            aina/1,
            ainz/1,

            if_flag_true/2,
            current_module_from/2,
            attributes_equal/3,            

            
            is_visible_module/1,
            hb_to_clause/3,
            paina/1,pain/1,painz/1,
            modulize_head/2,
            remove_term_attr_type/2,
            ainz_clause/1,ainz_clause/2,
            simple_var/1,
            
            expand_to_hb/3,
            assert_if_new/1,
            asserta_if_new/1,
            asserta_new/1,
            assertz_if_new/1,
            assertz_new/1,
            assert_setting/1,
            assert_setting_if_missing/1,
            call_provider/1,
            call_provider/2,
            clause_true/1,
            modulize_head_fb/4,
            clause_asserted/1,clause_asserted/2,clause_asserted/3,
            clause_asserted_i/1,clause_asserted_i/2,clause_asserted_i/3,
            clause_i/1,clause_i/2,clause_i/3,
            assert_i/1,asserta_i/1,assertz_i/1,
            retract_i/1,retractall_i/1,


            clause_safe/2,
            
            erase_safe/2,
            eraseall/2,
            find_and_call/1,
            somehow_callable/1,
            find_and_call/3,
            std_provider/3,
            mpred_mop/3,
            mpred_op_prolog/2,
            mpred_split_op_data/3,
            retract_eq/1,
            safe_univ/2,
            safe_univ0/2,
            my_module_sensitive_code/1.

:- reexport(library(clause_attvars)).

baseKB:first_std_provider(_,_,mpred_op_prolog).

:- meta_predicate clause_safe(:, ?).
:- module_transparent clause_safe/2.
:- export(clause_safe/2).


:- meta_predicate my_module_sensitive_code(?).

%= 	 	 

%% my_module_sensitive_code( ?E) is semidet.
%
% My Module Sensitive Code.
%
my_module_sensitive_code(_E):- source_context_module(CM),writeln(source_context_module=CM).


% clause_safe(M:H,B):-!,predicate_property(M:H,number_of_clauses(_)),system:clause(H,B).
% clause_safe(H,B):-predicate_property(_:H,number_of_clauses(_)),system:clause(H,B).

%= 	 	 

%% clause_safe( ?H, ?B) is semidet.
%
% Clause Safely Paying Attention To Corner Cases.
%
clause_safe(H,B):-predicate_property(H,number_of_clauses(C)),C>0,system:clause(H,B).

:- meta_predicate(if_flag_true(:,:)).
if_flag_true(TF,Goal):-
  (current_prolog_flag(TF,F) -> 
    (F\=false -> find_and_call(Goal); true);
   (find_and_call(TF)->find_and_call(Goal);true)).

/*
if_flag_true(TF,Goal):-
  (somehow_callable(TF)-> 
    (find_and_call(TF)->find_and_call(Goal);true);
  (current_prolog_flag(TF,F) -> 
    (F\=false -> find_and_call(Goal); true);
   trace_or_throw(if_flag_true(TF,Goal)))).
*/

:- export(mpred_op_prolog/2).
:- module_transparent(mpred_op_prolog/2).
% mpred_op_prolog(P):-mpred_split_op_data(P,OP,Term),mpred_op_prolog(OP,Term).


%= 	 	 

%% mpred_split_op_data( ?OP, ?O, ?P) is semidet.
%
% Managed Predicate Split Oper. Data.
%
mpred_split_op_data(M:OP,M:O,P):-sanity(compound(OP)),OP=..[O,P],!.
mpred_split_op_data(M:OP,M:call,OP):-!.
mpred_split_op_data(OP,O,P):-sanity(compound(OP)),OP=..[O,P],!.
mpred_split_op_data(OP,call,OP).



% mpred_mop(OP,CALL):- sanity(not_ftVar(OP)),fail.
:- export(mpred_mop/3).
:- meta_predicate mpred_mop(+,1,?).

%= 	 	 

%% mpred_mop( +M, :PRED1Op, ?Term) is semidet.
%
% Managed Predicate Mop.
%
mpred_mop(M,C:call,CALL):-!,find_and_call(C,M,CALL).
mpred_mop(M,C:Op,Term):-!,append_term(Op,Term,CALL),find_and_call(C,M,CALL).
mpred_mop(M,Op,Term):-append_term(Op,Term,CALL),find_and_call(M,M,CALL).
mpred_mop(M,call,CALL):-!,find_and_call(M,M,CALL).
mpred_mop(M,Op,Term):-append_term(Op,Term,CALL),find_and_call(M,M,CALL).


:-meta_predicate(cp2(0)).
cp2(G):-loop_check_early(G,G).

:-meta_predicate(found_call(+,*)).
found_call(C,G):- on_x_debug(loop_check_early(C:call(G),cp2(C:G))).

%% find_and_call( +OUT1, +C, ?G) is semidet.
%
% Find And Call.
%
:-meta_predicate(find_and_call(+,+,?)).
find_and_call(_,_,C:G):-current_predicate(_,C:G),!,found_call(C,G).
find_and_call(_,C,  G):-current_predicate(_,C:G),!,found_call(C,G).
find_and_call(C,_,  G):-current_predicate(_,C:G),!,found_call(C,G).
find_and_call(_,_,  G):-current_predicate(_,C:G),!,found_call(C,G).
find_and_call(C,M,  G):-dtrace,C:on_x_debug(M:G).


current_module_ordered(user).
current_module_ordered(baseKB).
current_module_ordered(X):-current_module(X).
%= 	 	 

%% find_and_call( :TermG) is semidet.
%
% Find And Call.
%
find_and_call(C:G):-current_predicate(_,C:G),!,found_call(C,G).
find_and_call(G):-current_predicate(_,G),!,on_x_debug(loop_check_early(G,cp2(G))).
find_and_call(_:G):-current_predicate(_,R:G),!,found_call(R,G).
find_and_call(G):-current_predicate(_,R:G),!,found_call(R,G).

module_of(O,G,M):-predicate_property(O:G,imported_from(M)),!.
module_of(M,G,M):-predicate_property(M:G,defined), \+ predicate_property(M:G,imported_from(_)).

find_module(G,R):- strip_module(G,M,P),module_of(M,P,R),!.
find_module(G,M):- current_module_ordered(C),module_of(C,G,M),!.

callable_module(G,R):- strip_module(G,R,P),predicate_property(R:P,defined),!.
callable_module(G,R):- strip_module(G,_,P),current_module_ordered(R),predicate_property(R:P,defined),!.
callable_module(G,R):- strip_module(G,M,P),module_of(M,P,R).

%% somehow_callable( :TermG) is semidet.
%
% Detects if find_and_call/1 will be able to call the term
%
somehow_callable(G):-current_predicate(_,G),!.
somehow_callable(_:G):-!,current_predicate(_,_:G),!.
somehow_callable(G):-current_predicate(_,_:G),!.


%= 	 	 

%% ain0( ?N) is semidet.
%
% Assert If New Primary Helper.
%
ain0(N):-notrace(clause_asserted(N))->true;mpred_op_prolog(assert,N).

:- export(mpred_op_prolog/2).
:- module_transparent(mpred_op_prolog/2).
:- meta_predicate mpred_op_prolog(?,:).

%= 	 	 

%% mpred_op_prolog( ?UPARAM1, ?N) is semidet.
%
% Managed Predicate Oper. Prolog.
%
mpred_op_prolog(ain0,N):- !,(notrace(clause_asserted(N))->true;mpred_op_prolog0(assert,N)).
mpred_op_prolog(paina,N):-!,(notrace(clause_asserted(N))->true;mpred_op_prolog0(system:asserta,N)).
mpred_op_prolog(painz,N):-!,(notrace(clause_asserted(N))->true;mpred_op_prolog0(system:assertz,N)).
mpred_op_prolog(pain,N):- !,(notrace(clause_asserted(N))->true;mpred_op_prolog0(assert,N)).
mpred_op_prolog(aina,N):- !,(clause_asserted(N)->true;mpred_op_prolog0(system:asserta,N)).
mpred_op_prolog(ainz,N):- !,(clause_asserted(N)->true;mpred_op_prolog0(system:assertz,N)).
mpred_op_prolog(ain,N):-  !,(clause_asserted(N)->true;mpred_op_prolog0(assert,N)).
% mpred_op_prolog(OP,M:Term):- unnumbervars(Term,Unumbered),Term \=@= Unumbered,!,dtrace,mpred_mop(M,OP,Unumbered).
mpred_op_prolog(OP,M:Term):-  dtrace,!,mpred_mop(M, OP,Term).
mpred_op_prolog(OP,M:Term):- 
  copy_term(Term, Copy, Gs),
  (Gs==[] -> mpred_mop(M,OP,Term);
    show_call(why,(
      expand_to_hb(Copy,H,B),conjoin(maplist(call,Gs),B,NB),dtrace,mpred_mop(M,OP,(H:-NB))))).
  

%= 	 	 

%% mpred_op_prolog0( :PRED1OP, ?MTerm) is semidet.
%
% Managed Predicate Oper. Prolog Primary Helper.
%
mpred_op_prolog0(OP,MTerm):- call(OP,MTerm).

% peekAttributes/2,pushAttributes/2,pushCateElement/2.
:- module_transparent((aina/1,ain/1,ainz/1,ain0/1,ainz_clause/1,ainz_clause/2,clause_asserted/2,expand_to_hb/3,clause_asserted/1,eraseall/2)).
:- module_transparent((asserta_new/1,asserta_if_new/1,assertz_new/1,assertz_if_new/1,assert_if_new/1)). % ,assertz_if_new_clause/1,assertz_if_new_clause/2,clause_asserted/2,expand_to_hb/2,clause_asserted/1,eraseall/2)).

:- meta_predicate paina(:),pain(:),painz(:),ain0(:),ainz_clause(:),ainz_clause(:,?).
:- meta_predicate clause_asserted(:,?),expand_to_hb(?,?,?),clause_asserted(:),eraseall(+,+).

% aina(NEW):-ignore((system:retract(NEW),fail)),system:asserta(NEW).
% ainz(NEW):-ignore((system:retract(NEW),fail)),system:assertz(NEW).
% aina(_Ctx,NEW):-ignore((system:retract(NEW),fail)),system:asserta(NEW).
% writeqnl(_Ctx,NEW):- fmt('~q.~n',[NEW]),!.


%= 	 	 

%% eraseall( +F, +A) is semidet.
%
% Eraseall.
%
eraseall(M:F,A):-!,forall((current_predicate(M:F/A),functor_catch(C,F,A)),forall(system:clause(M:C,B,X),erase_safe(system:clause(M:C,B,X),X))).
eraseall(F,A):-forall((current_predicate(M:F/A),functor_catch(C,F,A)),forall(system:clause(M:C,B,X),erase_safe(system:clause(M:C,B,X),X))).


:-thread_local(t_l:std_provider_asserted/3).
:-thread_local(t_l:current_std_provider/1).
:-dynamic(baseKB:first_std_provider/2).
:-dynamic(baseKB:next_std_provider/2).
:-multifile(baseKB:first_std_provider/2).
:-multifile(baseKB:next_std_provider/2).

%= 	 	 

%% mpred_provider( ?OP, ?Term, ?PROVIDER) is semidet.
%
% Hook To [std_provider/3] For Module Logicmoo_util_database.
% Managed Predicate Provider.
%
std_provider(OP,Term,PROVIDER):- t_l:std_provider_asserted(OP,Term,PROVIDER).
std_provider(_,_,PROVIDER):- t_l:current_std_provider(PROVIDER).
std_provider(OP,Term,PROVIDER):- baseKB:first_std_provider(OP,Term,PROVIDER).


:- meta_predicate call_provider(?).

%= 	 	 

%% call_provider( ?P) is semidet.
%
% Call Provider.
%
call_provider(P):-mpred_split_op_data(P,OP,Term),call_provider(OP,Term).


%= 	 	 

%% call_provider( ?OP, ?Term) is semidet.
%
% Call Provider.
%
call_provider(OP,Term):- must(std_provider(OP,Term,PROVIDER)),!,call(PROVIDER,OP,Term).

call_provider(OP,Term):- must(std_provider(OP,Term,PROVIDER)),!,
   (loop_check_early(call(PROVIDER,OP,Term),fail)*->true;
   (loop_check_early(must(baseKB:next_std_provider(PROVIDER,NEXT)),NEXT=mpred_op_prolog),!,PROVIDER\=NEXT,call(NEXT,OP,Term))).



:- meta_predicate assert_setting(:).
%% assert_setting( ?X) is semidet.
assert_setting(M:P):-functor(P,_,A),duplicate_term(P,DP),setarg(A,DP,_),system:retractall(M:DP),system:asserta(M:P).
:- meta_predicate assert_setting_if_missing(:).
assert_setting_if_missing(M:P):-functor(P,_,A),duplicate_term(P,DP),setarg(A,DP,_),(system:clause(M:DP,_)->true;system:asserta(M:P)).

:- meta_predicate assert_if_new(:).

%% assert_if_new( ?X) is semidet.
%
% Assert If New.
%
assert_if_new(X):-mpred_op_prolog(pain,X).
:- meta_predicate asserta_if_new(:).

%= 	 	 

%% asserta_if_new( ?X) is semidet.
%
% Asserta If New.
%
asserta_if_new(X):-mpred_op_prolog(paina,X).
:- meta_predicate assertz_if_new(:).

%= 	 	 

%% assertz_if_new( ?X) is semidet.
%
% Assertz If New.
%
assertz_if_new(X):-mpred_op_prolog(painz,X).

:- meta_predicate asserta_new(:).

%= 	 	 

%% asserta_new( ?X) is semidet.
%
% Asserta New.
%
asserta_new(X):-mpred_op_prolog(paina,X).
:- meta_predicate asserta_new(:).

%= 	 	 

%% assertz_new( ?X) is semidet.
%
% Assertz New.
%
assertz_new(X):-mpred_op_prolog(painz,X).


%= 	 	 

%% pain( ?N) is semidet.
%
% Pain.
%
pain(N):- call_provider(pain(N)).

%= 	 	 

%% paina( ?N) is semidet.
%
% Paina.
%
paina(N):-call_provider(paina(N)).

%= 	 	 

%% painz( ?N) is semidet.
%
% Painz.
%
painz(N):-call_provider(painz(N)).


:-module_transparent(ain/1).
:-module_transparent(aina/1).
:-module_transparent(ainz/1).
:-dynamic(ain/1).
:-dynamic(aina/1).
:-dynamic(ainz/1).

%= 	 	 

%% ain( ?N) is semidet.
%
% Assert If New.
%
ain(N):- call_provider(pain(N)).

%= 	 	 

%% aina( ?N) is semidet.
%
% Aina.
%
aina(N):-call_provider(paina(N)).

%= 	 	 

%% ainz( ?N) is semidet.
%
% Ainz.
%
ainz(N):-call_provider(painz(N)).


%= 	 	 

%% ainz_clause( ?C) is semidet.
%
% Ainz Clause.
%
ainz_clause(C):- expand_to_hb(C,H,B),ainz_clause(H,B).

%= 	 	 

%% ainz_clause( ?H, ?B) is semidet.
%
% Ainz Clause.
%
ainz_clause(H,B):- clause_asserted(H,B)->true;call_provider(system:assertz((H:-B))).



%% expand_to_hb( ?Clause, ?H, ?B) is semidet.
%
% Split a Head+Body from Clause.
%
expand_to_hb( Var, H, B):- var(Var),!,dmsg(warn(expand_to_hb( Var, H, B))), when(nonvar(Var),expand_to_hb( Var, H, B)).
expand_to_hb( M:((H :- B)),M:H,B):-!.
expand_to_hb( ((H :- B)),H,B):-!.
expand_to_hb( H,  H,  true).



%% is_visible_module( +Op) is semidet.
%
%  Is a stripped Module (Meaning it will be found via inheritance)
%
is_visible_module(A):-var(A),!,fail.
is_visible_module(user).
is_visible_module(system).
%is_visible_module(Inherited):-'$current_source_module'(E), default_module(E,Inherited).
%is_visible_module(Inherited):-'$current_typein_module'(E), default_module(E,Inherited).
%is_visible_module(baseKB).


simple_var(Var):- var(Var),\+ attvar(Var).

to_mod_if_needed(M,B,MB):- B==true-> MB=B ; MB = M:B.

%% hb_to_clause( ?H, ?B, ?Clause ) is semidet.
%
% Join a Head+Body To Clause.
%
hb_to_clause(H,B,H):- B==true,!.
hb_to_clause(M:(H:-B1),B2,(M:H:- (B2,B1))):-!.
hb_to_clause((H:-B1),B2,(H:- (B2,B1))):-!.
hb_to_clause(H,B,(H:-B)).


:-export(clause_asserted/1).
:-meta_predicate(clause_asserted(:)).

%= 	 	 

%% clause_asserted( ?C) is semidet.
%
% Clause Asserted.
%
clause_asserted(C):- expand_to_hb(C,H,B),clause_asserted(H,B).

:-export(clause_asserted/2).
:-meta_predicate(clause_asserted(:,?)).

%= 	 	 

%% clause_asserted( ?H, ?B) is semidet.
%
% Clause Asserted.
%
clause_asserted(H,B):-clause_asserted(H,B,_).

:-export(clause_asserted/3).
:-meta_predicate(clause_asserted(:,?,-)).

%= 	 	 

%% clause_asserted( ?M, ?B, -R) is semidet.
%
% Clause Asserted.
%
clause_asserted(M:H,B,R):- copy_term(M:H:B,MHB),system:clause(M:H,B,R),variant(M:H:B,MHB).


:-meta_predicate(modulize_head(?,?)).

current_module_from(Cm,M):- default_module(Cm,M).
current_module_from(Cm,M):- current_module_ordered(M), \+ default_module(Cm,M).

%% modulize_head( +HEAD, -ModulePlusHead) is semidet.
%
% Modulize Head.
%
modulize_head(MH,M:H):- strip_module(MH,Cm,H),!,
  modulize_head_fb(Cm,H,Cm,M:H).

modulize_head_fb(From,H,Fallback,M:H):- 
 notrace((findall(M:H,
  ((no_repeats(M, ((current_module_from(From,M),current_predicate(_,M:H),\+ predicate_property(M:H,imported_from(_))))))->true;
  M=Fallback),List))),
 member(M:H,List).



:- reexport(library(listing_vars)).


%% clause_asserted_i(+Head) is semidet.
%
% PFC Clause For User Interface.
%
clause_asserted_i(Head):- 
  \+ \+ ((
  % fully_expand_now_wte(assert,Head,HeadC),
  copy_term(Head,HC),
  copy_term_nat(Head,Head_copy),
  % find a unit system:clause identical to Head by finding one which unifies,
  clause_i(Head_copy),
  % and then checking to see if it is identical
  term_attvars(Head:Head_copy:HC,Vars),maplist(del_attr_type(vn),Vars),
  =@=(Head,HC),
  variant(Head,Head_copy))),!.


clause_asserted_i(H,B):- clause_asserted_i(H,B,_).
clause_asserted_i(MH,B,R):- ground(MH:B),!,system:clause(MH,B,R),system:clause(MHR,BR,R),ground(MHR:BR).
clause_asserted_i(MH,B,R):- copy_term(MH:B,MHB),clause_i(MH,B,R),variant(MH:B,MHB).




put_clause_ref(_Ref,_V):- !.
put_clause_ref(Ref,V):- !, nop(dmsg(put_clause_ref(Ref,V))).
put_clause_ref(Ref,V):-put_attr(V,cref,Ref).

remove_term_attr_type(Term,Mod):- notrace((term_attvars(Term,AVs),maplist(del_attr_type(Mod),AVs))).

:- op(700,xfx,'=@=').


attribute_is_info(name_variable(_Var,  _Name)).
attribute_is_info(put_attrs(_Var, vn, _Name)).

attributes_equal(R,L,Attribs):-R=@=L,!,Attribs = R.
attributes_equal([INFO|L],R,TODO):- attribute_is_info(INFO),INFO,!,delete(R,INFO,RR),attributes_equal(L,RR,TODO).
attributes_equal(R,[INFO|L],TODO):- attribute_is_info(INFO),INFO,!,delete(R,INFO,RR),attributes_equal(L,RR,TODO).

attributes_equal(L,R,[H|TODO]):- select(H,L,LL), select(HH,R,RR),H==HH,!,
    delete(LL,HH,LLL),delete(RR,H,RRR),attributes_equal(LLL,RRR,TODO).
attributes_equal(L,R,[H|TODO]):- select(H,L,LL), select(HH,R,RR),H =HH,!,
    delete(LL,HH,LLL),delete(RR,H,RRR),attributes_equal(LLL,RRR,TODO).


%% clause_i( ?H, ?B, ?Ref) is semidet.
%
% Clause For Internal Interface.
%
clause_i(HB):- expand_to_hb(HB,H,B)->clause_i(H,B,_).
clause_i(H,B):- clause_i(H,B,_).

% TODO track which predicate have attributeds vars
clause_i(H0,B0,Ref):- \+ current_prolog_flag(assert_attvars,true) ,!, system:clause(H0,B0,Ref).
clause_i(H0,B0,Ref):- clause_attv(H0,B0,Ref).

assert_i(HB):- clausify_attributes(HB,CL),assert(CL).
asserta_i(HB):-clausify_attributes(HB,CL),system:asserta(CL).
assertz_i(HB):-clausify_attributes(HB,CL),system:assertz(CL).
retract_i(HB):- expand_to_hb(HB,H,B), (clause_i(H,B,Ref)*->erase(Ref)).
retractall_i(H):-expand_to_hb(H,HH,_),forall(clause_i(HH,_,Ref),erase(Ref)).


:- dynamic(ereq/1).
:- module_transparent(ereq/1).
ereq(C):- find_and_call(C).

:- dynamic(dbreq/1).
:- module_transparent(dbreq/1).
dbreq(C):- ereq(C).


:-meta_predicate(clause_true(?)).


%= 	 	 

%% clause_true( ?G) is semidet.
%
% Clause True.
%
clause_true(G):- !, clause_b(G).

clause_true(M:G):-!,system:clause(M:G,true)*->true;(current_module_ordered(M2),system:clause(M2:G,true)).
clause_true(G):- notrace((current_module_ordered(M), \+ \+  system:clause(M:G,_,_))),!, system:clause(M:G,true).
%clause_true(M:G):- predicate_property(M:G,number_of_clauses(_)),!,system:clause(M:G,true).
%clause_true(_:G):-!,predicate_property(M:G,number_of_clauses(_)),system:clause(M:G,true).
%clause_true(G):-!,predicate_property(M:G,number_of_clauses(_)),system:clause(M:G,true).

clause_true_anywhere(G):- strip_module(G,M,S),!,
  functor(S,F,A),
  functor(P,F,A),
  ((M2=M; M2=baseKB ;(current_module_ordered(M2),M2\=M)),
    current_predicate(M2:P)),!,
    system:clause(M2:S,B,Ref),
     (B==true->! ;
    (clause_property(Ref,module(M22));M22=M2),!,call(M22:B)).


:-export(retract_eq/1).

%= 	 	 

%% retract_eq( ?HB) is semidet.
%
% Retract Using (==/2) (or =@=/2) ).
%
retract_eq(HB):-expand_to_hb(HB,H,B),show_failure(modulize_head(H,MH)),clause_asserted(MH,B,Ref),erase(Ref).


:-export(safe_univ/2).

%= 	 	 

%% safe_univ( ?Call, ?List) is semidet.
%
% Safely Paying Attention To Corner Cases Univ.
%
safe_univ(SCall,Univ):-string(SCall),!,atom_string(Call,SCall),[Call]=Univ.
safe_univ(Call,List):- notrace(safe_univ0(Call,List)),!.


%= 	 	 

%% safe_univ0( ?M, :TermN) is semidet.
%
% Safely Paying Attention To Corner Cases Univ Primary Helper.
%
safe_univ0(M:Call,[N:L|List]):- nonvar(M),nonvar(N),!,safe_univ0(Call,[L|List]).
safe_univ0(M:Call,[N:L|List]):- nonvar(N),var(M),N=M,!,safe_univ(Call,[L|List]).
safe_univ0(Call,[M:L|List]):- nonvar(M),!,safe_univ(Call,[L|List]).
safe_univ0(M:Call,[L|List]):- nonvar(M),!,safe_univ(Call,[L|List]).
safe_univ0(Call,[L|List]):- not(is_list(Call)),sanity(atom(L);compound(Call)), Call =..[L|List],!,warn_bad_functor(L).
safe_univ0([L|List],[L|List]):- var(List),atomic(Call),!,rtrace,Call =.. [L|List],warn_bad_functor(L).
safe_univ0(Call,[L|List]):- sanity(atom(L);compound(Call)),catchv(Call =.. [L|List],E,(dumpST,'format'('~q~n',[E=safe_univ(Call,List)]))),warn_bad_functor(L).

/*

%% bad_functor( ?L) is semidet.
%
% Bad Functor.
%
bad_functor(L) :- arg(_,v('|','.',[],':','/'),L).

:- export(warn_bad_functor/1).

%=

%% warn_bad_functor( ?L) is semidet.
%
% Warn Bad Functor.
%
warn_bad_functor(L):-ignore((notrace(bad_functor(L)),!,dtrace,call(ddmsg(bad_functor(L))))).


%= 	 	 
*/

:-export(erase_safe/2).

%= 	 	 

%% erase_safe( ?VALUE1, ?REF) is semidet.
%
% Erase Safely Paying Attention To Corner Cases.
%
erase_safe(_,REF):-erase(REF).
/*
erase_safe(((M:A):-B),REF):-!,erase_safe(system:clause(M:A,B),REF).
erase_safe(system:clause(U:A,B),REF):-U=user,!, erase_safe(system:clause(A,B),REF).
%erase_safe(system:clause(A,U:B),REF):-U=user,!, erase_safe(system:clause(A,B),REF).
%erase_safe(system:clause(M:A,B),REF):-!, erase_safe_now(M,system:clause(A,B),REF).
erase_safe(system:clause(A,B),REF):-!, erase_safe_now(_,system:clause(A,B),REF).
erase_safe(M:(A:-B),REF):-!,erase_safe(system:clause(M:A,B),REF).
erase_safe((A:-B),REF):-!,erase_safe(system:clause(A,B),REF).
erase_safe(system:clause(A,B,_),REF):-!,erase_safe(system:clause(A,B),REF).
erase_safe(system:asserta(A,_),REF):-!,erase_safe(system:clause(A,true),REF).
erase_safe(M:A,REF):-M==user,!,erase_safe(A,REF).
erase_safe(A,REF):-!,erase_safe(system:clause(A,true),REF).


erase_safe_now(_,system:clause(M:A,B),REF):-!,erase_safe_now(M,system:clause(A,B),REF).
erase_safe_now(M,system:clause(A,B),REF):-!,
   ignore((show_success(erase_safe_now, \+ system:clause(M:A,B, REF)))),
   (((var(REF);
   show_success(erase_safe_now, \+ nth_clause(A, _Index, REF));   
   show_success(erase_safe_now, clause_property(REF,erased));
   show_success(erase_safe_now, \+ clause_property(REF,_))))
   -> logicmoo_util_catch:ddmsg(warn(var_erase_safe(system:clause(A,B),REF))) ; 
       erase(REF)).
*/


:- ignore((source_location(S,_),prolog_load_context(module,M),module_property(M,class(library)),
 forall(source_file(M:H,S),
 ignore((functor(H,F,A),
  ignore(((\+ atom_concat('$',_,F),(export(F/A) , current_predicate(system:F/A)->true; system:import(M:F/A))))),
  ignore(((\+ predicate_property(M:H,transparent), module_transparent(M:F/A), \+ atom_concat('__aux',_,F),debug(modules,'~N:- module_transparent((~q)/~q).~n',[F,A]))))))))).

 
