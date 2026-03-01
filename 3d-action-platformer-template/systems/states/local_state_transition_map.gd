class_name LocalStateTransitionMap
extends RefCounted

var transitions: Dictionary[State, LocalStateTransition] = {}


## TODO: add docs
func add_transition(target_state: State, transition: LocalStateTransition) -> void:
	assert(target_state != null)
	assert(not transitions.has(target_state))

	transitions.get_or_add(target_state, transition)


## TODO: add docs
func create_and_add_transition(
	target_state: State,
	callable: Callable,
	priority: int = 0
) -> void:
	assert(target_state != null)
	assert(not transitions.has(target_state))

	var transition: LocalStateTransition = LocalStateTransition.create(callable, priority) 

	transitions.get_or_add(target_state, transition)


## TODO: add docs
func update_transition(target_state: State, transition: LocalStateTransition) -> void:
	assert(target_state != null)
	assert(transitions.has(target_state))

	transitions.set(target_state, transition)


## TODO: add docs
func toggle_transition_disabled(target_state: State, disabled: bool) -> void:
	assert(target_state != null)
	assert(transitions.has(target_state))

	transitions[target_state].disabled = disabled


## TODO: add docs
func remove_transition(target_state: State) -> void:
	assert(target_state != null)
	assert(transitions.has(target_state))

	transitions.erase(target_state)


func is_empty() -> bool:
	return transitions.is_empty()
