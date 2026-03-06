class_name GlobalStateTransitionMap
extends RefCounted


var transitions: Dictionary[State, GlobalStateTransition] = {}


## TODO: add docs
func add_transition(target_state: State, transition: GlobalStateTransition) -> void:
	assert(target_state != null)
	assert(not transitions.has(target_state))

	_connect_signals(transition.connections)

	transitions.get_or_add(target_state, transition)


## TODO: add docs
func create_and_add_transition(
	signal_event: Signal,
	target_state: State,
	callable: Callable
) -> void:
	assert(not signal_event.is_null())
	assert(target_state != null)
	assert(not transitions.has(target_state))

	var transition: GlobalStateTransition = GlobalStateTransition.create({
		signal_event: callable
	}) 

	_connect_signals(transition.connections)

	transitions.get_or_add(target_state, transition)


func create_and_add_multiple_transitions(
	target_state: State,
	transition_dict: Dictionary[Signal, Callable]
) -> void:
	assert(target_state != null)
	assert(not transitions.has(target_state))

	var transition: GlobalStateTransition = GlobalStateTransition.create(transition_dict) 

	_connect_signals(transition_dict)
	transitions.get_or_add(target_state, transition)



## TODO: add docs
func update_transition(target_state: State, transition: GlobalStateTransition) -> void:
	assert(target_state != null)
	assert(transitions.has(target_state))

	_disconnect_signals(transitions[target_state].connections)
	transitions.set(target_state, transition)
	_connect_signals(transitions[target_state].connections)


## TODO: add docs
func disable_all_transitions(target_state: State) -> void:
	assert(target_state != null)
	assert(transitions.has(target_state))

	var global_transition: GlobalStateTransition = transitions[target_state]
	_disconnect_signals(global_transition.connections)


## TODO: add docs
func disable_transition(target_state: State, signal_event: Signal) -> void:
	assert(target_state != null)
	assert(transitions.has(target_state))

	var global_transition: GlobalStateTransition = transitions[target_state]

	assert(global_transition.connections.has(signal_event))
	var callable: Callable = global_transition.connections[signal_event]

	assert(signal_event.is_connected(callable))
	signal_event.disconnect(callable)

	assert(not signal_event.is_connected(callable))


## TODO: add docs
func enable_all_transitions(target_state: State) -> void:
	assert(target_state != null)
	assert(transitions.has(target_state))

	var global_transition: GlobalStateTransition = transitions[target_state]
	_connect_signals(global_transition.connections)


## TODO: add docs
func enable_transition(target_state: State, signal_event: Signal) -> void:
	assert(target_state != null)
	assert(transitions.has(target_state))

	var global_transition: GlobalStateTransition = transitions[target_state]

	assert(global_transition.connections.has(signal_event))
	var callable: Callable = global_transition.connections[signal_event]

	assert(not signal_event.is_connected(callable))
	signal_event.connect(callable)

	assert(signal_event.is_connected(callable))


## TODO: add docs
func remove_transition(target_state: State) -> void:
	assert(target_state != null)
	assert(transitions.has(target_state))

	_disconnect_signals(transitions[target_state].connections)
	transitions.erase(target_state)


func add_connection(
	target_state: State,
	signal_event: Signal,
	callable: Callable
) -> void:
	assert(transitions.has(target_state))
	assert(not signal_event.is_connected(callable))
	transitions[target_state].add_transition(signal_event, callable)

	assert(signal_event.is_connected(callable))


func _disconnect_signals(connections: Dictionary[Signal, Callable]) -> void:
	for signal_event: Signal in connections:
		assert(connections.has(signal_event))
		var callable: Callable = connections.get(signal_event)

		assert(signal_event.is_connected(callable))
		signal_event.disconnect(callable)

		assert(not signal_event.is_connected(callable))


func _connect_signals(connections: Dictionary[Signal, Callable]) -> void:
	for signal_event: Signal in connections:
		assert(not signal_event.is_null())
		assert(connections.has(signal_event))
		var callable: Callable = connections.get(signal_event)

		assert(not signal_event.is_connected(callable))
		signal_event.connect(callable)

		assert(signal_event.is_connected(callable))
