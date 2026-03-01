class_name GlobalStateTransition
extends RefCounted


var connections: Dictionary[Signal, Callable] = {}


static func create(state_connections: Dictionary[Signal, Callable]) -> GlobalStateTransition:
	assert(not state_connections.is_empty())

	var transition: GlobalStateTransition = GlobalStateTransition.new()

	for connection: Signal in state_connections:
		assert(not connection.is_null())

		assert(state_connections[connection].is_valid())

		transition.connections.get_or_add(connection, state_connections[connection])

	return transition
	

func add_transition(signal_event: Signal, callable: Callable) -> void:
	assert(not connections.has(signal_event))
	connections.get_or_add(signal_event, callable)
