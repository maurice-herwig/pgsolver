(** Interface for array paritygame.
    For further information on each class method see paritygame.mli 
 *)


(**************************************************************
 *                          TOOLS                             *
 **************************************************************)
(** Method for adding an edge between two nodes in an (priority * player * successors * predecessors * description) array.
    
    @param array array to set edge (v,u) in
    @param predecessor v
    @param successor u
*)
val add_edge_in_node_array :
  ('a * 'b * Pgnodeset.nodeset * Pgnodeset.nodeset * 'c) array ->
  Pgnode.node -> Pgnode.node -> unit




(**************************************************************
 *                       ARRAY PARITYGAME                     *
 **************************************************************)
(** Arrayparitygame class. 
    This class inherits from the general paritygame class and replaces the former paritygame type.
    The structure behind this class is an (priority * player * nodeset * nodeset * string option) array. 

    @param initfunction initializer function parameter. is not required. if should be used has to be tagged with ~initFunc:(fun....)
    @param int size of arrayparitygame. is required.
*)                                          
class array_pg : ?initFunc:(Pgnode.node ->Paritygame.priority * Paritygame.player * Pgnode.node list * string option) -> int ->
  object ('self)
           
    val mutable nodes : (Paritygame.priority * Paritygame.player * Pgnodeset.nodeset * Pgnodeset.nodeset * string option) array

                                                                                                                            
    (********** GENERAL **********)  
    method private init : (Pgnode.node -> Paritygame.priority * Paritygame.player * Pgnode.node list * string option) -> unit

    method size : int
                    
    method copy : 'self
                    
    method iterate : (Pgnode.node -> Paritygame.priority * Paritygame.player * Pgnodeset.nodeset * Pgnodeset.nodeset * string option -> unit) -> unit
                                                                                                                                                         
    method edge_iterate : (Pgnode.node -> Pgnode.node -> unit) -> unit

    method map : (Pgnode.node -> Paritygame.priority * Paritygame.player * Pgnodeset.nodeset * Pgnodeset.nodeset * string option ->
                  Paritygame.priority * Paritygame.player * Pgnodeset.nodeset * Pgnodeset.nodeset * string option) -> 'self
                                                                                                                          
    method map2 : 'a. (Pgnode.node -> (Paritygame.priority * Paritygame.player * Pgnodeset.nodeset * Pgnodeset.nodeset * string option) -> 'a) -> 'a array
                                                                                                                                                     

    (********** GETTERS **********)                                                                                                                                                 
    method get_node : int -> Paritygame.priority * Paritygame.player * Pgnodeset.nodeset * Pgnodeset.nodeset * string option

    method get_priority : Pgnode.node -> Paritygame.priority

    method get_owner : Pgnode.node -> Paritygame.player

    method get_successors : Pgnode.node -> Pgnodeset.nodeset

    method get_predecessors : Pgnode.node -> Pgnodeset.nodeset

    method get_desc : Pgnode.node -> string option
                                                
    method get_desc' : Pgnode.node -> string

    method find_desc : string option -> Pgnode.node

    method is_defined : Pgnode.node -> bool

    method format_game : string

    method get_boxes : Pgnodeset.nodeset -> Pgnodeset.nodeset

    method get_diamonds : Pgnodeset.nodeset -> Pgnodeset.nodeset

    method get_index : int

    method get_max : Paritygame.pg_ordering -> Pgnode.node

    method get_max_prio : Paritygame.priority

    method get_max_prio_for : Paritygame.player -> Paritygame.priority

    method get_max_prio_node : Pgnode.node

    method get_max_rew_node_for : Paritygame.player -> Pgnode.node

    method get_min : Paritygame.pg_ordering -> Pgnode.node

    method get_min_prio : Paritygame.priority

    method get_prio_nodes : Paritygame.priority -> Pgnodeset.nodeset

    method get_priorities : Paritygame.priority list

    method get_selected_priorities : (Paritygame.priority -> bool) -> Paritygame.priority list

    method edge_count : int

    method node_count : int

    method print : unit
  
    method to_dotty : Paritygame.solution -> Paritygame.strategy -> out_channel -> unit

    method to_dotty_file : Paritygame.solution -> Paritygame.strategy -> string -> unit

    method to_string : string

                         
    (********** SETTERS **********)
    method set_node' : int -> Paritygame.priority * Paritygame.player * Pgnodeset.nodeset * Pgnodeset.nodeset * string option -> unit

    method set_node : int -> Paritygame.priority -> Paritygame.player -> Pgnodeset.nodeset -> Pgnodeset.nodeset -> string option -> unit
                                                
    method set_priority : Pgnode.node -> Paritygame.priority -> unit

    method set_owner : Pgnode.node -> Paritygame.player -> unit

    method set_desc : Pgnode.node -> string option -> unit

    method set_desc' : Pgnode.node -> string -> unit

    method add_edge : Pgnode.node -> Pgnode.node -> unit

    method del_edge : Pgnode.node -> Pgnode.node -> unit
                                                              
    method remove_nodes : Pgnodeset.nodeset -> unit

    method remove_edges : (Pgnode.node * Pgnode.node) list -> unit


    (********** NODE COLLECTION  **********)
    method collect_nodes : (Pgnode.node -> Paritygame.priority * Paritygame.player * Pgnodeset.nodeset * Pgnodeset.nodeset * string option -> bool) -> Pgnodeset.nodeset

    method collect_nodes_by_prio : (Paritygame.priority -> bool) -> Pgnodeset.nodeset

    method collect_nodes_by_owner : (Paritygame.player -> bool) -> Pgnodeset.nodeset * Pgnodeset.nodeset

    method collect_max_prio_nodes : Pgnodeset.nodeset

    method collect_max_parity_nodes : Pgnodeset.nodeset


    (********** SUBGAME **********)
    method subgame_by_edge_pred : (Pgnode.node -> Pgnode.node -> bool) -> 'self

    method subgame_by_node_pred : (Pgnode.node -> bool) -> 'self

    method subgame_by_list : Pgnodeset.nodeset -> 'self

    method subgame_by_node_filter : (Pgnode.node -> bool) -> 'self * (Pgnode.node -> Pgnode.node) * (Pgnode.node -> Pgnode.node)

    method subgame_by_strat : Paritygame.strategy -> 'self

    method subgame_by_strat_pl : Paritygame.strategy -> Paritygame.player -> 'self


    (********** DOMINION **********)
    method set_closed : Pgnodeset.nodeset -> Paritygame.player -> bool

    method set_dominion : ('self -> Paritygame.solution * Paritygame.strategy) -> Pgnodeset.nodeset -> Paritygame.player -> Paritygame.strategy option

    (********** DECOMPOSITION **********)                                                                                                                                             
    method strongly_connected_components : Pgnodeset.nodeset array * Paritygame.scc array * Paritygame.scc list array * Paritygame.scc list

    method sccs_compute_connectors : Pgnodeset.nodeset array * Paritygame.scc array * Paritygame.scc list array * Paritygame.scc list ->
                                     (Paritygame.scc * Paritygame.scc, (Paritygame.scc * Paritygame.scc) list) Hashtbl.t


    (********** ATTRACTOR CLOSURE **********) 
    method attr_closure_inplace' : Paritygame.strategy -> Paritygame.player -> Pgnodeset.nodeset -> bool -> (Pgnode.node -> bool) -> bool -> Pgnodeset.nodeset

    method attr_closure_inplace : Paritygame.strategy -> Paritygame.player -> Pgnodeset.nodeset -> Pgnodeset.nodeset
                                                                                                                                                    
    method attractor_closure_inplace_sol_strat : (Pgnode.node -> bool) -> Paritygame.solution -> Paritygame.strategy -> Pgnodeset.nodeset ->
                                                  Pgnodeset.nodeset -> Pgnodeset.nodeset * Pgnodeset.nodeset


    (********** PARTIAL PARITYGAME **********)
    method induce_partialparitygame : Pgnode.node -> Paritygame.partial_paritygame

    method induce_counting_partialparitygame : Pgnode.node -> int ref * Paritygame.partial_paritygame

    method partially_solve_dominion : Pgnode.node -> Paritygame.partial_solver -> Paritygame.solution * Paritygame.strategy

    method partially_solve_game : Paritygame.partial_solver -> Paritygame.solution * Paritygame.strategy



    (********** GAME INFORMATION **********)
    method get_player_decision_info : bool * bool

    method is_single_parity_game : Paritygame.priority option

    method number_of_strategies : Paritygame.player -> int -> int

    method compute_priority_reach_array : Paritygame.player -> Paritygame.priority array array


    (********** DYNAMIC PARITYGAME **********)
    method to_dynamic_paritygame : Paritygame.dynamic_paritygame

    method to_dynamic_paritygame_by_strategy : Paritygame.strategy -> Paritygame.dynamic_paritygame                                           
  end



(********************************************************
 *                 PARITYGAME BUILDER                   *
 ********************************************************)
(* This can be used to build parity games starting from a particular node in an on-the-fly fashion.
   It is particularly useful when the resulting size is not (easily) known in advance. For an example
   of its use, see src/generators/langincl.ml .

   To use it, define a module of the type PGDescription using some type gamenode to represent nodes and
   giving functions that read off the priority, owner successors, a possible string representation of a
   game node, and a list of particular initial nodes.
   The module obtained by applying the functor Build then gives you a module with a function that
   builds a parity game containing all the game nodes that are reachable these initial ones. Additionally,
   you get functions that take nodes as arguments from which to build the parity game.
 *)
module type PGDescription =
  sig
    type gamenode
    val compare : gamenode -> gamenode -> int
    val owner : gamenode -> Paritygame.player
    val priority : gamenode -> Paritygame.priority
    val successors : gamenode -> gamenode list
    val show_node : gamenode -> string option
    val initnodes : unit -> gamenode list
  end

module type PGBuilder =
  sig
    type gamenode
    val build : unit -> array_pg
    val build_from_node : gamenode -> array_pg
    val build_from_nodes : gamenode list -> array_pg
  end

module Build :
  functor (T : PGDescription) ->
    sig
      type gamenode = T.gamenode
      val build : unit -> array_pg
      val build_from_node : gamenode -> array_pg
      val build_from_nodes : gamenode list -> array_pg
    end
